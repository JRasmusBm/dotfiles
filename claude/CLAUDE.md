# Personal Preferences

This file captures my preferences and workflows so Claude can learn and adapt over time. It's a living document - update it when you discover something worth remembering.

## End of Conversation Evaluation

This file is typically read at the end of conversations. When that happens:

1. **Review the conversation** - What went well? What was frustrating or inefficient?
2. **Identify patterns** - Did I express preferences that should be recorded? Did we find workflows worth documenting?
3. **Propose updates** - Suggest specific additions or changes to this file based on what you learned.

Only propose updates for genuine insights - don't add noise.

---

## Dotfiles

My dotfiles are managed in `~/projects/dotfiles`. Configuration files are symlinked using `scripts/symlink` which reads from `files.csv`.

When creating new config or skills, always add them to the dotfiles repo and symlink — never create directly in target locations like `~/.claude/`.

### Claude Skills

- **Repo-specific skills** go in `.claude/skills/` within the repo (not symlinked)
- **Global skills** go in `claude/skills/` in dotfiles (symlinked to `~/.claude/skills/`)

## Tools

- Editor: Neovim
- Shell: Zsh
- Terminal: Alacritty
- OS: macOS
- Window Manager: Hammerspoon

## Working Style

**Be proactive, not permission-seeking.** Make changes first, then ask for feedback. This applies to:
- Code changes
- Skill and documentation updates
- Reflective/introspective tasks (retros, evaluations)

Don't ask "Want me to do X?" - just do it. I'll review the diff and provide feedback.

## Communication Style

Be extremely concise. Sacrifice grammar for the sake of concision.

**When explaining how to do things**, provide extra context and include documentation links where relevant. Don't just give the answer—help me understand the broader picture.

**When investigating**, explain the approach you're taking and why. Don't just show results—share the reasoning.

**I often use voice typing.** Expect phonetic errors and don't ask for clarification on obvious mishearings. Interpret intent from context:
- "cloud MD" → CLAUDE.md
- "sim link" → symlink
- "get hub" → GitHub

## Plans

- Make the plan extremely concise. Sacrifice grammar for the sake of concision.
- At the end of each plan, give me a list of unresolved questions to answer, if
  any.

## Code style

- Unless otherwise specified, try to respect a 80 character line length.

## Skills

- **[teach](~/.claude/skills/teach/SKILL.md)** — Review the conversation and explain related concepts that expand knowledge. Use when you want to learn more about what we discussed.
- **[dictation](~/.claude/skills/dictation/SKILL.md)** — Reference for the Hammerspoon dictation setup. Covers how it works, key files, and CopyQ integration.
