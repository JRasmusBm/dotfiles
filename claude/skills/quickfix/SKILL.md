---
name: quickfix
description: "Reformat file references from conversation into vim quickfix format."
---

# Quickfix

Convert file references in the conversation to vim quickfix
format. Output a fenced code block that can be loaded via
`:cgetbuffer` or yanked into a quickfix list.

## Format

```
path/to/file:line:0: message
```

- Use project-relative paths (from working directory root)
- Column is 0 unless known
- Message is a short summary of the issue
- One line per issue
- If severity grouping exists, preserve order
  (errors first, then warnings, then info)

## Process

1. Scan the conversation for file references with line
   numbers (e.g. `File.ts:42`, `src/foo.ts line 10`)
2. Resolve to project-relative paths
3. Extract the associated message/issue
4. Output a single fenced code block

## Example

Input from conversation:
> **src/components/Button.tsx:42** — handler missing
> **src/utils/format.ts:10** — unused import

Output:
```
src/components/Button.tsx:42:0: handler missing
src/utils/format.ts:10:0: unused import
```
