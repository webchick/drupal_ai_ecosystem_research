# ai-fe-skills Index

## Repo Facts

- Path: /Users/webchick/Documents/Codex/2026-04-17-research-drupal-ai-tooling-landscape-synthesis-2/research/repos/ai-fe-skills
- Last commit date: 2026-03-04 15:20:30 +0200
- Skill count (SKILL.md): 1

## Presence / Absence

- CLAUDE.md: no
- AGENTS.md: no
- skills/: no
- .claude/skills/: no
- agents/: no
- commands/: no
- hooks/: no
- .claude/: no
- prompts/: no
- evals/: no
- composer.json: no
- package.json: no
- skills.yaml: no
- Any SKILL.md files: yes

## File Tree (Depth 3)

~~~text
.
./INDEX.md
./README.md
./drupal-figma-to-canvas-sdc
./drupal-figma-to-canvas-sdc/SKILL.md
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
~~~

## File Type Counts

~~~text
.md	11
.sh	1
~~~

## README (First 200 Lines)

Source: README.md

~~~text
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

~~~

## License

No top-level license file found.
