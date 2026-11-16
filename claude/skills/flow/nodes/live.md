# Merged or deployed: is it live?

- Is it live? Where does it run, and how do I know the version
  running is this one (deploy status, installed file, version)?
- How can I verify that it's working as intended? When should its
  effect show: now, the next scheduled run, the next time someone
  uses it? Check it the way they use it: the page in a browser, the
  tool called as an agent would, a real run. A grep of the bundle
  proves it shipped, not that it works.
- Is it breaking anything else? Who else runs this code (shared
  code, other tenants, other jobs)? What do the logs, alerts,
  metrics and costs say since it went out? Read-only.
- Broken for users? A stable state comes first (CLAUDE.md says
  how). Back or forward: is rolling back safe (migrations, data
  written, a contract the old build can't read), or is the fix
  smaller and proven? Then: what broke, for whom, since when, what
  did I do?
- Works: who should know (announce node)? Anything left before I
  call it done?
