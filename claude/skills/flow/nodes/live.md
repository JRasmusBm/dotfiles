# Merged or deployed: does it work in prod?

- Is it live? Where does it run, and how do I know the version
  running is this one (deploy status, installed file, version)?
- When should its effect show: now, the next scheduled run, the next
  time someone uses it? Can I check then instead of guessing now?
- Does it work for the people who use it, the way they use it? The
  page opened in a browser, the tool called as an agent would, a
  real run. A grep of the bundle proves it shipped, not that it
  works.
- What would tell me it's broken: errors in the logs, an alert, a
  metric or a cost moving the wrong way? Did I look, read-only?
- Broken for users? Then a stable state comes first (CLAUDE.md says
  how), and Rasmus hears after.
- Works: who should know (announce node)? Anything left before I
  call it done?
