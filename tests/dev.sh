#!/bin/sh
#
# tests/dev.sh [SCRIPT] — scenarios for `dev up`'s flags reaching the
# sourced .jrb/dev (DEV_TUNNEL), straight and through the re-exec
# when run from inside the `run` window. Fake tmux and pool; HOME,
# LOCAL_CONFIG and the repo are temp dirs. SCRIPT defaults to this
# checkout's bin/dev.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_dev="${1:-$_root/bin/dev}"
_t="$(mktemp -d)"
trap 'rm -rf "$_t"' EXIT
export FAKE="$_t/fake" HOME="$_t/home" LOCAL_CONFIG="$_t/cfg" \
  DEV_FILE="$_t/devfile" DEV_EXPIRE_POLL=0
mkdir -p "$FAKE/bin" "$HOME" "$_t/repo"
git -C "$_t/repo" init -q

# tmux: one session `s` whose `run` window @1 holds pane %1; run-shell
# saves its command to $FAKE/detached.
cat > "$FAKE/bin/tmux" <<'X'
#!/bin/sh
case "$1" in
  display-message)
    case "$*" in
      *'#S'*) echo s ;;
      *'#{window_id}'*) echo @1 ;;
    esac ;;
  list-windows) echo '@1 1 run' ;;
  new-window) echo '@2 %2' ;;
  run-shell) eval "c=\${$#}"; printf '%s' "$c" > "$FAKE/detached" ;;
esac
exit 0
X
printf '#!/bin/sh\nexit 0\n' > "$FAKE/bin/pool"
chmod +x "$FAKE/bin"/*
export PATH="$FAKE/bin:$PATH"

cat > "$DEV_FILE" <<'X'
#!/bin/sh
echo "${DEV_TUNNEL-unset}|$(sh -c 'echo "${DEV_TUNNEL-unset}"')" \
  > "$FAKE/got"
X
chmod +x "$DEV_FILE"
openssl sha256 "$DEV_FILE" > "$HOME/..dev.digests"

_pass=0 _fail=0
_then() {
  _got="$(cat "$FAKE/got" 2>/dev/null)"
  if test "$_got" = "$2"; then
    _pass=$((_pass + 1))
  else
    _fail=$((_fail + 1))
    echo "FAIL: $1: got '$_got', want '$2'"
  fi
}

# _up [ENV=VAL ...] -- ARGS: dev up in the repo, as session s.
_up() {
  rm -f "$FAKE/got" "$FAKE/detached"
  _e=''
  while test "$1" != --; do _e="$_e $1"; shift; done
  shift
  (cd "$_t/repo" && unset TMUX TMUX_PANE &&
    env DEV_SESSION=s $_e "$_dev" up "$@" > /dev/null 2>&1)
}

# _up_in_run ARGS: dev up typed in the run window: it re-execs
# through tmux run-shell, which the test then runs.
_up_in_run() {
  rm -f "$FAKE/got" "$FAKE/detached"
  (cd "$_t/repo" && unset DEV_SESSION DEV_TUNNEL &&
    TMUX=fake TMUX_PANE=%1 "$_dev" up "$@" > /dev/null 2>&1)
  test -f "$FAKE/detached" || return 0
  (unset TMUX TMUX_PANE && sh -c "$(cat "$FAKE/detached")") \
    > /dev/null 2>&1
}

_up --
_then "plain up: DEV_TUNNEL empty, exported" '|'

_up -- --tunnel
_then "up --tunnel: DEV_TUNNEL=1, exported" '1|1'

_up -- --wait --tunnel
_then "up --wait --tunnel: DEV_TUNNEL=1" '1|1'

_up DEV_TUNNEL=1 --
_then "plain up with DEV_TUNNEL=1 in the caller's env: empty" '|'

_up_in_run --tunnel
_then "up --tunnel from the run window: survives the re-exec" '1|1'

_up_in_run
_then "plain up from the run window: empty after the re-exec" '|'

echo "$_pass passed, $_fail failed"
test "$_fail" = 0
