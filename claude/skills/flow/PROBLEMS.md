# Problems the flow fixes

Working on 1 and 2.

1. **Throughput is limited by my attention.**
2. **Tokens/PR is way too high**
3. (Downstream effect) My inventory is too high
4. (Downstream effect) My lead time is too high

## Success

Inventory drains while cost drops. Baseline W46, from my-impact:

| | W46 | Target direction |
|---|---|---|
| Inventory (started, not live) | 68, 30 older than 7 d | way down |
| Deployed per week | 93 | way up |
| Tokens per deploy | 13.6M (budget 105%) | way down |

Lead time follows inventory (Little's law), so it isn't a separate
target.
