# INDEX for ai-fe-skills
## File Tree (Depth 3)
```
.
./.git
./drupal-figma-to-canvas-sdc
./drupal-figma-to-canvas-sdc/assets
./drupal-figma-to-canvas-sdc/assets/component-plan.md
./drupal-figma-to-canvas-sdc/assets/worked-example.md
./drupal-figma-to-canvas-sdc/project-context.example.md
./drupal-figma-to-canvas-sdc/references
./drupal-figma-to-canvas-sdc/references/implementation.md
./drupal-figma-to-canvas-sdc/references/planning.md
./drupal-figma-to-canvas-sdc/references/project-context.md
./drupal-figma-to-canvas-sdc/references/shared-context.md
./drupal-figma-to-canvas-sdc/references/validation.md
./drupal-figma-to-canvas-sdc/scripts
./drupal-figma-to-canvas-sdc/scripts/validate-antipatterns.sh
./drupal-figma-to-canvas-sdc/SKILL.md
./INDEX.md
./README.md
```
## File Type Counts
```
  11 md
   1 sh
```
## Presence of key files/directories
- CLAUDE.md: Absent
- AGENTS.md: Absent
- skills/: Absent
- .claude/skills/: Absent
- agents/: Absent
- commands/: Absent
- hooks/: Absent
- .claude/: Absent
- prompts/: Absent
- evals/: Absent
- composer.json: Absent
- package.json: Absent
- skills.yaml: Absent
- SKILL.md: Absent
## First 200 lines of README
```
# Skills

Agent skills for frontend development — Drupal, AEM, performance optimization.

Reusable [SKILL.md](https://docs.anthropic.com/en/docs/claude-code/skills) workflows that work across AI coding agents: Claude Code, Codex, Gemini CLI, Cursor, Windsurf, and others.

## Available Skills

| Skill | Description |
|-------|-------------|
| [drupal-figma-to-canvas-sdc](./drupal-figma-to-canvas-sdc) | Build production-ready Drupal SDC components from Figma designs. Three-phase Plan-Implement-Validate workflow for Canvas + SDC + Tailwind CSS projects. |

## Usage

Clone the repo and copy the skill you need into your Claude Code skills directory:

```bash
# Personal (all projects)
git clone https://github.com/aldunchev/ai-fe-skills.git ~/.claude/skills/ai-fe-skills

# Project-level (current project only)
git clone https://github.com/aldunchev/ai-fe-skills.git .claude/skills/ai-fe-skills
```

Skills are discovered automatically — once copied, they appear when you type `/` in Claude Code.

For other agents (Codex, Cursor, Windsurf, etc.), each skill folder contains a `SKILL.md` with YAML frontmatter following the cross-compatible Agent Skills format. Copy the skill folder into your project or reference it per your agent's documentation.

## Structure

```
skills/
└── <skill-name>/
    ├── SKILL.md              # Skill definition (YAML frontmatter + instructions)
    ├── references/           # Context files used by sub-agents
    ├── assets/               # Examples and templates
    └── scripts/              # Validation scripts
```

## License

MIT
```
## License
```
No LICENSE found.
```
## Last Commit Date
2026-03-04 15:20:30 +0200
## Skill Count
1 SKILL.md files found.
