---
name: product-ideas
description: "Harvest product ideas customers raised on Gong calls and in Polar AI chats / MCP, ranked by merit, checked against Linear and existing features. Use for 'product ideas from Gong', 'cool product ideas from calls this week', 'what are customers asking for this week', 'feature requests from calls', 'ideas from Gong this week'."
---

# Product ideas

1. Run (default 7 days; `--dry-run` first if unsure of cost, stop above $5;
   it still collects and writes the DB, only LLM spend is skipped):
   `cd ~/projects/polar/zeitgeist &&
   caffeinate -i zsh -ic '.venv/bin/python -m zeitgeist product --days N'`
   Long-running: run it in the background. The last line printed is the
   `product.md` path.
2. Needs Snowflake access, `ANTHROPIC_API_KEY` and the VPN for chats. The
   header's sources line says if chats were "cache only"; say so in the
   answer. Ideas rank by merit (model-scored value, breadth and fit,
   divided by size), then one comparative ranking call orders them;
   demand (accounts x ARR x status x recency) is evidence only.
3. Read `product.md`. For the top ideas (max 10), check whether each
   exists: Linear `list_issues` by keywords (load `linear`), and the
   `feature-inventory` skill's feature docs. Mark each: new / already
   tracked (ticket link) / already exists (doc link) / partly exists.
4. Answer: quick wins (small + new) first, then bigger bets, each group
   in product.md rank order, then one line per already tracked/exists. Each:
   improvement, merit with value/breadth/fit, small/big (guess), accounts
   with ARR as evidence, one quote + its Gong link. Say merit, its parts
   and size are the model's judgement, not measurements.
5. When the user picks one: draft a Linear ticket (title = improvement,
   acceptance, quotes + Gong links and accounts as evidence, names not
   anonymised). Create it only after the user says so, then load
   `work-management` and hand off with `wt feat <ticket url>`.
