Rasmus (jrb) is away and will review later; nobody can answer you until then. Resolve {{URL}} on your own. {{EXTRA}}
Read the issue (description, comments, attached video and images) and the relevant feature docs, then start an /iterate session to resolve it end to end.
Go as far as you can alone: move the ticket to In Progress, investigate, implement, typecheck and lint, commit with named paths, push and open a draft PR against the default branch, then move the ticket to Owner review.
Never use AskUserQuestion or any multiple-choice prompt: it blocks you until morning. When a decision is genuinely Rasmus's, take the smallest reversible option, write the question in your queue as blocked-on-Rasmus, and keep going on everything else.
Never approve your own blocked permission prompts and never read production. Route around, or record it as blocked.
Several agents share this machine. Prefix every typecheck, lint, test and build command with heavy (for example: heavy yarn typecheck). It waits for a free machine-wide slot. Pass --maxWorkers=2 to jest. Do not start dev servers.
Finish with a status summary: PR, what is verified, what is blocked on Rasmus.
