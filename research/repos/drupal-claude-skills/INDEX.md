# drupal-claude-skills Index

## Repo Facts

- Path: /Users/webchick/Documents/Codex/2026-04-17-research-drupal-ai-tooling-landscape-synthesis-2/research/repos/drupal-claude-skills
- Last commit date: 2026-03-20 13:33:12 -0400
- Skill count (SKILL.md): 9

## Presence / Absence

- CLAUDE.md: yes
- AGENTS.md: yes
- skills/: yes
- .claude/skills/: no
- agents/: no
- commands/: no
- hooks/: no
- .claude/: yes
- prompts/: no
- evals/: no
- composer.json: no
- package.json: no
- skills.yaml: no
- Any SKILL.md files: yes

## File Tree (Depth 3)

~~~text
.
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
./.claude/scripts
./.claude/scripts/sync-d9book.sh
./.claude/scripts/sync-ivan-rules.sh
./.claude/settings.json
./.gitignore
./AGENTS.md
./CLAUDE.md
./CONTRIBUTING.md
./INDEX.md
./LICENSE
./README.md
./install.sh
./skills
./skills/drupal-at-your-fingertips
./skills/drupal-at-your-fingertips/.sync-metadata
./skills/drupal-at-your-fingertips/SKILL.md
./skills/drupal-at-your-fingertips/references
./skills/drupal-canvas
./skills/drupal-canvas/SKILL.md
./skills/drupal-config-mgmt
./skills/drupal-config-mgmt/SKILL.md
./skills/drupal-config-mgmt/references
./skills/drupal-contrib-mgmt
./skills/drupal-contrib-mgmt/SKILL.md
./skills/drupal-contrib-mgmt/examples
./skills/drupal-contrib-mgmt/references
./skills/drupal-ddev
./skills/drupal-ddev/SKILL.md
./skills/drupal-ddev/references
./skills/drupal-search-api
./skills/drupal-search-api/SKILL.md
./skills/drupal-simple-oauth
./skills/drupal-simple-oauth/SKILL.md
./skills/ivangrynenko-cursorrules-drupal
./skills/ivangrynenko-cursorrules-drupal/.sync-metadata
./skills/ivangrynenko-cursorrules-drupal/SKILL.md
./skills/ivangrynenko-cursorrules-drupal/references
./skills/skill-developer
./skills/skill-developer/SKILL.md
~~~

## File Type Counts

~~~text
.json	1
.md	91
.sh	7
[dotfile-no-ext]	3
[no-ext]	1
~~~

## README (First 200 Lines)

Source: README.md

~~~text
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


~~~

## License

Source: LICENSE

~~~text
MIT License

Copyright (c) 2024 Drupal Claude Skills Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

---

THIRD-PARTY CONTENT NOTICES

This project includes content from multiple sources with different licenses:

1. Drupal at Your Fingertips
   Source: https://drupalatyourfingertips.com
   Author: Selwyn Polit
   License: Open access documentation
   Location: .claude/skills/drupal-at-your-fingertips/

2. Ivan Grynenko - Cursor Rules for Drupal
   Source: https://github.com/ivangrynenko/cursorrules
   Author: Ivan Grynenko
   License: MIT License
   Location: .claude/skills/ivangrynenko-cursorrules-drupal/

All third-party content is used with respect to its original license. Please
refer to individual skill directories for specific licensing information.

~~~
