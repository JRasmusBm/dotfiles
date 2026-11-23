# Showing Rasmus a page (artifacts)

A page that shows what I tested, a decision or a report. He runs
many Claude logins, and a published link only opens on the one that
published it, so a local file is what he can open.

- Local by default: one self-contained HTML file at
  `<worktree>/.jrb/artifacts/<name>.html` (`.jrb/` is ignored; the
  scratchpad when there is no worktree). Hand him the absolute path
  on its own line and `open` it.
- Published only when he asks for it, in those words. Then the
  Artifact tool, and the `wt` skill's Claude accounts section for
  logins.
- Log it so `artifacts` lists it from any session (`f` = its
  absolute path):

      printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$(date +%s)" local \
        "file://$f" "<title>" "$f" "$PWD" \
        >>"${LOCAL_CONFIG:-$HOME/.config}/artifacts.tsv"

- A PR body or ticket can't link a local file: put what reviewers
  need there as text, the page is for him.

## Building one

- The review page renders the doc (SKILL.md, The doc): its text and
  Tested screenshots, not a rewrite of them.
- What does he need to judge in two minutes? Lead with that, the one
  or two decisions, then the evidence. Short text, no recap.
- Screenshots of each key state (before, action, result, errors)
  into `<worktree>/.jrb/screenshots/<nn>-<what>.png`, cropped to the
  element when busy, in order, each captioned with what to look for.
- Thumbnails are too small: a click opens an image full-screen with
  its caption, a second shows native size with panning;
  Escape, × or a click outside closes.
- Works from `file://`: images inlined (base64) or relative paths
  (`../screenshots/…`), no CDN, no fetches.
- Opened it myself and checked every image loads and the viewer
  works before handing it over?
