# Problems the flow fixes

Each one is a check on whether the flow worked. Working notes for
RAS-74; evidence from the my-impact data, W45–W46.

1. **Throughput is limited by my attention.** Agents need me too
   often: 133 asks in one day (46 of them "approve"), 131 focus
   switches an hour, 70 min median wait on a notification. Goal:
   agents more autonomous while staying reliable, so my attention
   goes to design and scoping.
2. **Agents take the wrong step.** `rd`'s design stop, meant for
   product features, also stopped tooling tickets.
3. **Too much to read, still misses.** About 27k characters of
   CLAUDE.md plus 47 skills per agent, and they still pick the
   wrong rule.
4. **Fix tickets wait on me.** 56 of 93 started tickets are past
   build. Fix PRs sit with green checks. The work repo's ticket
   skill makes "ready to deploy" depend on my word only.
5. **Designed work is gated by my local testing.** Feature PRs are
   2–7k lines and take a median of 13.1 h from open to merge.
   Shipping behind a flag and iterating in prod would make them
   smaller.
6. **Tickets prescribe how.** Ticket-writing agents fix the
   approach. Builders follow it against their own better judgment
   ("I'd have done it differently, but the ticket says"). The
   CLAUDE.md "Plans" brief format (files to read, boundaries, build
   the smallest and ask) pushes both sides that way.
7. **Gaps are closed by adding rules.** Each mistake adds a line
   somewhere, so context grows and nothing tests the fix.
8. **Risk: the flow itself adds turns.** Guard: one short page
   loaded once, rules move into it instead of being added, no nodes
   that ask me, a token budget per path.
