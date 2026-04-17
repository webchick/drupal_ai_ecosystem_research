# grasmash-drupal-claude-skills — Structural Index

**Source URL**: https://github.com/grasmash/drupal-claude-skills
**Clone URL used**: https://github.com/grasmash/drupal-claude-skills
**Last commit**: 2026-03-20 13:33:12 -0400
**Last commit subject**: Add install script and improve Quick Install with 4 options
**License**: LICENSE
**Default branch**: refs/heads/main

## File type counts

     90 md
      7 sh
      2 sync-metadata
      1 /LICENSE
      1 json
      1 gitignore

## Presence of key files/dirs

- CLAUDE.md: ✓ present
- AGENTS.md: ✓ present
- README: ✓ present (README.md)
- skills/ : ✓ present
- .claude/ : ✓ present
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

Number of SKILL.md files: 9

Paths:

```
./skills/drupal-at-your-fingertips/SKILL.md
./skills/drupal-canvas/SKILL.md
./skills/drupal-config-mgmt/SKILL.md
./skills/drupal-contrib-mgmt/SKILL.md
./skills/drupal-ddev/SKILL.md
./skills/drupal-search-api/SKILL.md
./skills/drupal-simple-oauth/SKILL.md
./skills/ivangrynenko-cursorrules-drupal/SKILL.md
./skills/skill-developer/SKILL.md
```

## File tree (depth 3)

```
.
./AGENTS.md
./.claude
./.claude/agents
./.claude/agents/done-gate.md
./.claude/agents/drupal-specialist.md
./.claude/agents/frontend-specialist.md
./.claude/agents/quality-gate.md
./.claude/agents/researcher.md
./.claude/agents/reviewer.md
./.claude/agents/test-runner.md
./.claude/agents/test-writer.md
./CLAUDE.md
./.claude/scripts
./.claude/scripts/sync-d9book.sh
./.claude/scripts/sync-ivan-rules.sh
./.claude/settings.json
./CONTRIBUTING.md
./install.sh
./LICENSE
./README.md
./skills
./skills/drupal-at-your-fingertips
./skills/drupal-at-your-fingertips/references
./skills/drupal-at-your-fingertips/SKILL.md
./skills/drupal-at-your-fingertips/.sync-metadata
./skills/drupal-canvas
./skills/drupal-canvas/SKILL.md
./skills/drupal-config-mgmt
./skills/drupal-config-mgmt/references
./skills/drupal-config-mgmt/SKILL.md
./skills/drupal-contrib-mgmt
./skills/drupal-contrib-mgmt/examples
./skills/drupal-contrib-mgmt/references
./skills/drupal-contrib-mgmt/SKILL.md
./skills/drupal-ddev
./skills/drupal-ddev/references
./skills/drupal-ddev/SKILL.md
./skills/drupal-search-api
./skills/drupal-search-api/SKILL.md
./skills/drupal-simple-oauth
./skills/drupal-simple-oauth/SKILL.md
./skills/ivangrynenko-cursorrules-drupal
./skills/ivangrynenko-cursorrules-drupal/references
./skills/ivangrynenko-cursorrules-drupal/SKILL.md
./skills/ivangrynenko-cursorrules-drupal/.sync-metadata
./skills/skill-developer
./skills/skill-developer/SKILL.md
```

## README first 200 lines

Source: README.md

```
# Drupal Claude Skills

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude-Code-orange.svg)](https://claude.com/claude-code)
[![Drupal](https://img.shields.io/badge/Drupal-10%20%7C%2011-blue.svg)](https://www.drupal.org)
[![agentskills.io](https://img.shields.io/badge/spec-agentskills.io-purple.svg)](https://agentskills.io)

A comprehensive collection of Claude Code skills and agents for Drupal development. Install battle-tested patterns for configuration management, module updates, security, local development, OAuth, search, and more.

## Quick Install

### Option 1: Give this prompt to your AI agent

Copy-paste this into Claude Code (or any AI coding agent) from your Drupal project directory:

```
Install Drupal Claude Skills into this project from https://github.com/grasmash/drupal-claude-skills:

1. Clone the repo to a temp directory
2. Copy skills/ into .claude/skills/
3. Copy .claude/agents/ into .claude/agents/
4. Copy .claude/settings.json (if I don't already have one)
5. Read AGENTS.md from the repo and append the "Agent Workflow Guide" section to my CLAUDE.md (create CLAUDE.md if it doesn't exist)
6. Clean up the temp directory
```

### Option 2: Shell script

```bash
bash <(curl -s https://raw.githubusercontent.com/grasmash/drupal-claude-skills/main/install.sh)
```

Or from a cloned copy:

```bash
./install.sh /path/to/your/drupal/project
```

### Option 3: Skills CLI (skills only, no agents)

```bash
npx skills add grasmash/drupal-claude-skills
```

This copies skills into `.claude/skills/` but does **not** install agents, settings, or the workflow guide. Works with Claude Code, Cursor, Codex, Gemini CLI, and any tool supporting the [agentskills.io specification](https://agentskills.io).

### Option 4: Manual

```bash
git clone https://github.com/grasmash/drupal-claude-skills.git /tmp/drupal-skills

# Skills
cp -r /tmp/drupal-skills/skills/* .claude/skills/

# Agents
cp -r /tmp/drupal-skills/.claude/agents/* .claude/agents/

# Settings (review and customize)
cp /tmp/drupal-skills/.claude/settings.json .claude/settings.json

# Clean up
rm -rf /tmp/drupal-skills
```

Then add the agent workflow guide from [AGENTS.md](AGENTS.md) to your project's CLAUDE.md.

## What's Included

### 9 Skills (`skills/`)

| Skill | Description |
|-------|-------------|
| **[drupal-at-your-fingertips](skills/drupal-at-your-fingertips/)** | 50+ Drupal topics from [Selwyn Polit's book](https://drupalatyourfingertips.com) — services, hooks, entities, forms, theming, caching, testing |
| **[drupal-config-mgmt](skills/drupal-config-mgmt/)** | Configuration management — safe import/export, config splits (complete vs partial), environment syncing, merge workflows |
| **[drupal-contrib-mgmt](skills/drupal-contrib-mgmt/)** | Contrib module management — Composer updates, patch management, Drupal 11 compatibility, drupal.org contribution workflow |
| **[drupal-ddev](skills/drupal-ddev/)** | DDEV local development — setup, commands, database ops, Xdebug, performance (Mutagen), Docker/Mutagen troubleshooting |
| **[ivangrynenko-cursorrules-drupal](skills/ivangrynenko-cursorrules-drupal/)** | OWASP Top 10 security patterns from [Ivan Grynenko](https://github.com/ivangrynenko/cursorrules) — auth, access control, injection prevention, crypto |
| **[drupal-simple-oauth](skills/drupal-simple-oauth/)** | OAuth2 with simple_oauth — TokenAuthUser permissions, scope/role matching, field_permissions, CSRF bypass, debugging |
| **[drupal-search-api](skills/drupal-search-api/)** | Search API — index configuration, boost processors, custom processors, config management, reindexing |
| **[drupal-canvas](skills/drupal-canvas/)** | Drupal Canvas Code Components — scaffolding, Nebula template, Acquia Source Site Builder integration |
| **[skill-developer](skills/skill-developer/)** | Meta-skill for creating new skills — agentskills.io spec, frontmatter schema, progressive disclosure, 500-line rule |

### 8 Agents (`.claude/agents/`)

| Agent | Description |
|-------|-------------|
| **quality-gate** | Pre-commit code review — security, performance, testing, regressions |
| **done-gate** | Completion validator — builds pass, tests run, deliverables exist |
| **drupal-specialist** | Drupal/PHP implementation — modules, hooks, services, Drush |
| **frontend-specialist** | Frontend — Twig, SCSS, JavaScript, responsive design, accessibility |
| **researcher** | Codebase exploration — architecture, patterns, execution paths |
| **reviewer** | Code review — bugs, security, quality, actionable feedback |
| **test-runner** | Test execution — PHP, JS, SCSS validation, build checks |
| **test-writer** | ExistingSite test writing — bug reproduction, DTT patterns |

### Settings (`.claude/settings.json`)

Sample Drupal-safe permission patterns. Prompts for confirmation before destructive operations like `drush cim`, `drush sql-drop`, and `drush site:install`.

## Canvas Ecosystem

For Drupal Canvas Code Components, this repo includes a lightweight `drupal-canvas` skill as an entry point. For the full 7-skill Canvas development suite:

```bash
npx skills add drupal-canvas/skills
```

Scaffold a new Canvas project:

```bash
npx @drupal-canvas/create my-project
```

## Usage

Skills activate automatically based on context:

- Working with config splits → `drupal-config-mgmt` activates
- Updating a module → `drupal-contrib-mgmt` activates
- Security review → `ivangrynenko-cursorrules-drupal` activates
- OAuth debugging → `drupal-simple-oauth` activates
- Local dev issue → `drupal-ddev` activates

You can also invoke skills explicitly:
```
"Using the drupal-config-mgmt skill, help me set up partial config splits"
```

## Repository Structure

```
skills/                              # Skills (agentskills.io format)
├── drupal-at-your-fingertips/       #   50+ Drupal topics
│   ├── SKILL.md
│   └── references/
├── drupal-config-mgmt/              #   Config management
│   ├── SKILL.md
│   └── references/
├── drupal-contrib-mgmt/             #   Module management
│   ├── SKILL.md
│   ├── references/
│   └── examples/
├── drupal-ddev/                     #   DDEV local dev
│   ├── SKILL.md
│   └── references/
├── ivangrynenko-cursorrules-drupal/ #   Security patterns
│   ├── SKILL.md
│   └── references/
├── drupal-simple-oauth/             #   OAuth2 patterns
│   └── SKILL.md
├── drupal-search-api/               #   Search API patterns
│   └── SKILL.md
├── drupal-canvas/                   #   Canvas components
│   └── SKILL.md
└── skill-developer/                 #   Meta-skill for creating skills
    └── SKILL.md
.claude/
├── agents/                          # Agent definitions
│   ├── quality-gate.md
│   ├── done-gate.md
│   ├── drupal-specialist.md
│   ├── frontend-specialist.md
│   ├── researcher.md
│   ├── reviewer.md
│   ├── test-runner.md
│   └── test-writer.md
├── settings.json                    # Sample Drupal permissions
└── scripts/                         # Upstream sync scripts
    ├── sync-d9book.sh
    └── sync-ivan-rules.sh
```

## Updating Upstream Skills

Two skills sync from upstream sources:

```bash
# Sync Drupal at Your Fingertips references
./.claude/scripts/sync-d9book.sh

# Sync Ivan Grynenko security patterns
./.claude/scripts/sync-ivan-rules.sh
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:
- Adding new skills (follow [agentskills.io spec](https://agentskills.io/specification))
- Adding new agents
- Improving existing content
- Syncing upstream sources

## Credits

- **[Selwyn Polit](https://drupalatyourfingertips.com)** — Drupal at Your Fingertips
- **[Ivan Grynenko](https://github.com/ivangrynenko/cursorrules)** — Drupal security patterns
- **Drupal Community** — Ongoing contributions to documentation and best practices

## License
```
