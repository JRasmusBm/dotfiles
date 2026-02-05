# Teach

When invoked, review the conversation and expand on concepts that came up. The goal is deeper understanding, not just task completion.

## Process

1. **Identify teachable moments** — What concepts, tools, or techniques were used that have more depth?
2. **Pick 1-3 topics** — Don't overwhelm. Focus on what's most relevant or interesting.
3. **Explain the broader picture** — How does this fit into larger patterns? What are the related concepts?
4. **Provide resources** — Documentation links, further reading, related tools.

## What to look for

- Commands or tools used that have useful flags or variations
- Patterns that have names or are part of larger paradigms
- Techniques that generalize beyond the specific case
- Historical context that explains why things are the way they are
- Common pitfalls or misconceptions
- Related tools or approaches worth knowing

## Tone

- Conversational, not lecturing
- Assume competence — explain the "why" and connections, not basics
- Be specific — concrete examples over abstract descriptions
- Include links to official docs or authoritative sources

## Format

For each topic:

**[Topic Name]**

Brief explanation of the broader concept and how it connects to what we did.

- Key insight or technique
- Related concepts or tools
- Link to documentation or further reading

## Example output

**git log -S (pickaxe search)**

We used `git log -S 'pattern'` to find when code was introduced. This is called "pickaxe" search — it finds commits where the number of occurrences of a string changed (added or removed).

Related techniques:
- `git log -G 'regex'` — finds commits where the diff matches the regex (broader than -S)
- `git bisect` — binary search for the commit that introduced a bug
- `git blame` — line-by-line attribution (but only shows last change, not introduction)

Docs: https://git-scm.com/docs/git-log#Documentation/git-log.txt--Sltstringgt
