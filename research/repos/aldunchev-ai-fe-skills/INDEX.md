# aldunchev-ai-fe-skills — Structural Index

**Source URL**: https://github.com/aldunchev/ai-fe-skills
**Clone URL used**: https://github.com/aldunchev/ai-fe-skills
**Last commit**: 2026-03-04 15:20:30 +0200
**Last commit subject**: Fix skill installation instructions to use actual clone-based approach
**License**: none
**Default branch**: refs/heads/main

## File type counts

     10 md
      1 sh

## Presence of key files/dirs

- CLAUDE.md: ✗ absent
- AGENTS.md: ✗ absent
- README: ✓ present (README.md)
- skills/ : ✗ absent
- .claude/ : ✗ absent
- .claude/skills/ : ✗ absent
- agents/ : ✗ absent
- commands/ : ✗ absent
- hooks/ : ✗ absent
- prompts/ : ✗ absent
- evals/ : ✗ absent
- composer.json: ✗ absent
- package.json: ✗ absent
- skills.yaml: ✗ absent
- .cursorrules / .cursor/ : ✗ absent
- .github/ : ✗ absent

## SKILL.md count

Number of SKILL.md files: 1

Paths:

```
./drupal-figma-to-canvas-sdc/SKILL.md
```

## File tree (depth 3)

```
.
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
./README.md
```

## README first 200 lines

Source: README.md

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
