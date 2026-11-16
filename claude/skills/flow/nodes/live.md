# Merged or deployed: is it live?

- Is it live? Where does it run, and how do I know the version
  running is this one (deploy status, installed file, version)?
  Does something still need to be applied or enabled (infra, a
  flag, config), and by whom (applying-infra node)?
- How can I verify that it's working as intended (does-it-work
  node, now in prod)? When should its effect show: now, the next
  scheduled run, the next time someone uses it? A grep of the bundle
  proves it shipped, not that it works.
- Is it breaking anything else? Who else runs this code (shared
  code, other tenants, other jobs)? What do the logs, alerts,
  metrics and costs say since it went out? Read-only.
