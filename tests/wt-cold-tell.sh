#!/bin/sh
#
# tests/wt-cold-tell.sh [BIN] — scenarios for bin/wt-cold telling a
# row's agent instead of pinging me (RAS-109): 'verify in prod' and an
# overdue background agent get one wt-tell per state; I get one row
# when the tell failed or the row is still stalled a workday on.
# wt-tell, notify, notif and tmux are logging fakes first on PATH;
# LOCAL_CONFIG is a temp dir. Nothing real is touched. BIN defaults to
# this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/wtct.XXXX)"
test -n "${KEEP:-}" || trap 'rm -rf "$_t"' EXIT
export LOCAL_CONFIG="$_t/cfg" FAKE="$_t/fake" BIN="$_bin"
mkdir -p "$LOCAL_CONFIG" "$FAKE"
cat > "$FAKE/wt-tell" <<'EOF'
#!/bin/sh
printf '%s|%s|%s\n' "$1" "$2" "$4" >> "$FAKE/told"
exit "${FAKE_TELL_RC:-0}"
EOF
printf '#!/bin/sh\necho "$NOTIFY_REF|$2" >> "$FAKE/pinged"\n' \
  > "$FAKE/notify"
printf '#!/bin/sh\n' > "$FAKE/notif"
printf '#!/bin/sh\n' > "$FAKE/tmux"
chmod +x "$FAKE"/*
export PATH="$FAKE:$_bin:$PATH"

exec python3 - <<'EOF'
import importlib.machinery, importlib.util, os, sys
path = os.path.join(os.environ['BIN'], 'wt-cold')
loader = importlib.machinery.SourceFileLoader('wt_cold', path)
spec = importlib.util.spec_from_loader('wt_cold', loader)
w = importlib.util.module_from_spec(spec)
loader.exec_module(w)
F = os.environ['FAKE']
fail = 0


def check(name, ok):
    global fail
    print(('ok   ' if ok else 'FAIL ') + name)
    fail |= not ok


def lines(f):
    try:
        out = open(os.path.join(F, f)).read().splitlines()
    except OSError:
        out = []
    open(os.path.join(F, f), 'w').close()
    return out


class Nd:
    LOG = ''

    def read_rows(self, *_):
        return []


class B:
    repo, root = 'r', F

    def __init__(self, *items):
        self.items = {i['slug']: i for i in items}


def item(slug, kind, since, st, path=F, why=None):
    return dict(slug=slug, path=path, state='STALLED', st=st,
                since=w.NOW - 7200, tell=(kind, since),
                why=why or {'prod': 'verify in prod',
                            'bg': 'background agent overdue: '
                                  'investigate'}[kind])


def run(*its, inbox=()):
    w.ping(Nd(), list(inbox), [B(*its)], [])
    return lines('told'), lines('pinged')


T0 = w.NOW - 3600
prod = {}
told, pinged = run(item('p', 'prod', T0, prod))
check('prod: one tell, keyed by state', len(told) == 1
      and told[0].split('|')[1] == f'cold:prod:{int(T0)}')
check('prod: tell asks to verify and move or w8',
      'live node' in told[0] and 'wt w8' in told[0])
check('prod: no row for me', pinged == [])

told, pinged = run(item('p', 'prod', T0, prod))
check('prod again: no tell, no row', told == [] and pinged == [])

prod['told']['at'] = w.NOW - 5 * w.DAY
told, pinged = run(item('p', 'prod', T0, prod))
check('a workday on: one row, no tell', told == [] and len(pinged) == 1
      and pinged[0].startswith('r/p|verify in prod: its agent was told'))
row = ['', 'p', '', pinged[0].split('|', 1)[1], '', '', '', 'stalled',
       '', 'r/p']
told, pinged = run(item('p', 'prod', T0, prod), inbox=[row])
check('row pending: not resent', told == [] and pinged == [])
told, pinged = run(item('p', 'prod', T0, prod))
check('row cleared: stays cleared', told == [] and pinged == [])

told, pinged = run(item('p', 'prod', T0 + 60, prod))
check('new state: told again', len(told) == 1 and pinged == [])

os.environ['FAKE_TELL_RC'] = '1'
bg = {}
told, pinged = run(item('b', 'bg', T0, bg))
check('bg, tell fails: one row for me', len(told) == 1
      and 'waiting node' in told[0] and pinged ==
      ['r/b|background agent overdue: investigate: telling its agent '
       'failed'])
told, pinged = run(item('b', 'bg', T0, bg))
check('bg failed: not retried, not re-pinged', told == [] and pinged == [])
del os.environ['FAKE_TELL_RC']

told, pinged = run(item('n', 'prod', T0, {}, path=None))
check('no worktree: plain row, no tell', told == []
      and pinged == ['r/n|verify in prod'])

src = open(path).read()
check('overdue text carries no age',
      "why='background agent overdue: investigate'" in src)
sys.exit(fail)
EOF
