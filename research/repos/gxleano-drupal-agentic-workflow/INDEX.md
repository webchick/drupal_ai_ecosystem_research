# gxleano-drupal-agentic-workflow — Structural Index

**Source URL**: https://github.com/gxleano/drupal-agentic-workflow
**Clone URL used**: https://github.com/gxleano/drupal-agentic-workflow
**Last commit**: 2026-03-12 15:26:52 +0100
**Last commit subject**: Update skills
**License**: none
**Default branch**: refs/heads/main

## File type counts

     38 md
      4 sh
      3 yml
      2 twig
      2 json
      2 css
      1 theme
      1 js
      1 gitignore

## Presence of key files/dirs

- CLAUDE.md: ✗ absent
- AGENTS.md: ✗ absent
- README: ✓ present (README.md)
- skills/ : ✗ absent
- .claude/ : ✓ present
- .claude/skills/ : ✓ present
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

Number of SKILL.md files: 20

Paths:

```
./.claude/skills/accessibility/SKILL.md
./.claude/skills/api/SKILL.md
./.claude/skills/code-review/SKILL.md
./.claude/skills/config-management/SKILL.md
./.claude/skills/ddev/SKILL.md
./.claude/skills/debug/SKILL.md
./.claude/skills/doctor/SKILL.md
./.claude/skills/drupal-expert/SKILL.md
./.claude/skills/drupal-frontend-expert/SKILL.md
./.claude/skills/drupal-security/SKILL.md
./.claude/skills/drupal-site-builder-expert/SKILL.md
./.claude/skills/drush/SKILL.md
./.claude/skills/entity/SKILL.md
./.claude/skills/generate-tests/SKILL.md
./.claude/skills/migrate/SKILL.md
./.claude/skills/performance/SKILL.md
./.claude/skills/refactor/SKILL.md
./.claude/skills/scaffold/SKILL.md
./.claude/skills/solr-setup/SKILL.md
./.claude/skills/update-module/SKILL.md
```

## File tree (depth 3)

```
.
./assets
./assets/theme-template
./assets/theme-template/css
./assets/theme-template/js
./assets/theme-template/STARTER.breakpoints.yml
./assets/theme-template/STARTER.info.yml
./assets/theme-template/STARTER.libraries.yml
./assets/theme-template/STARTER.theme
./assets/theme-template/templates
./bin
./bin/setup.sh
./.claude
./.claude/hooks
./.claude/hooks/post-generation-lint.sh
./.claude/hooks/pre-bash-guard.sh
./.claude/hooks/prompt-context.sh
./.claude/hooks/README.md
./.claude/settings.json
./.claude/skills
./.claude/skills/accessibility
./.claude/skills/api
./.claude/skills/code-review
./.claude/skills/config-management
./.claude/skills/ddev
./.claude/skills/debug
./.claude/skills/doctor
./.claude/skills/drupal-expert
./.claude/skills/drupal-frontend-expert
./.claude/skills/drupal-security
./.claude/skills/drupal-site-builder-expert
./.claude/skills/drush
./.claude/skills/entity
./.claude/skills/generate-tests
./.claude/skills/migrate
./.claude/skills/performance
./.claude/skills/refactor
./.claude/skills/scaffold
./.claude/skills/solr-setup
./.claude/skills/update-module
./CLAUDE-TEMPLATE.md
./.prettierrc.json
./README.md
```

## README first 200 lines

Source: README.md

```
# Drupal Agentic Workflow for Claude Code

> Turn Claude Code into a Drupal-native development partner with 20 AI-powered skills, automated code quality hooks, and security scanning.

## Why Use This?

| Without | With |
|---------|------|
| Claude generates code with coding standard violations | phpcbf auto-fixes violations before you see them |
| Manual phpcs/phpstan runs after every change | Post-generation hook lints every file automatically |
| No protection against destructive commands | Pre-bash guard blocks `git reset --hard`, `rm -rf`, etc. |
| Generic AI responses about Drupal | 20 specialized skills with Drupal 10/11 expertise |
| Security issues caught in code review | Security patterns scanned on every file save |

### What Happens When You Write Code

```
Claude writes/edits a file
  │
  ├─ PreToolUse: pre-bash-guard.sh
  │   └─ Blocks destructive Bash commands (git reset --hard, rm -rf, etc.)
  │
  └─ PostToolUse: post-generation-lint.sh
      ├─ Is PHP? → phpcbf auto-fix → phpcs → security-perf-scan
      ├─ Is JS/TS? → prettier → eslint
      ├─ Is CSS/SCSS? → prettier → stylelint
      ├─ Is Twig/YAML/JSON? → prettier
      └─ Exit 2 if errors → Claude sees feedback and auto-corrects
```

## Prerequisites

- **Claude Code CLI** installed and authenticated
- **DDEV** local development environment
- **Drupal 10.3+ or 11** project using `drupal/recommended-project`
- **PHP 8.3+** and **Composer 2**
- **jq** — required by hooks for JSON parsing (`brew install jq` / `apt-get install jq`)
- **Node.js 18+** — optional, for Prettier/ESLint/Stylelint (gracefully skipped if absent)

## Quick Setup

### 1. Clone This Repository

```bash
git clone <repo-url> ~/drupal-agentic-workflow
```

Keep it somewhere permanent — you'll reference it for each project.

### 2. Initialize Claude Code in Your Project

```bash
cd /path/to/your/drupal-project
claude /init
```

This generates a `CLAUDE.md` with auto-detected project info.

### 3. Run Setup

```bash
~/drupal-agentic-workflow/bin/setup.sh .
```

This single command:
- Checks for code quality tools (`drupal/coder`, `phpstan`) and offers to install them
- Copies all 20 skills and hooks into `.claude/`
- Appends Drupal coding rules to your existing `CLAUDE.md`
- Installs `.prettierrc.json` and `phpstan.neon`
- Optionally analyzes custom modules and generates `AI_CONTEXT.md` with real module info (hooks, routes, services, etc.)
- Auto-populates the Custom Modules section in `CLAUDE.md` with discovered modules

The script is fully idempotent — safe to run multiple times. It never overwrites files you've customized.

Options:
```
~/drupal-agentic-workflow/bin/setup.sh --dry-run .       # Preview without changes
~/drupal-agentic-workflow/bin/setup.sh --force .         # Skip Drupal detection
~/drupal-agentic-workflow/bin/setup.sh --skip-tools .    # Skip code quality tools check
~/drupal-agentic-workflow/bin/setup.sh --skip-ai-context . # Skip AI_CONTEXT.md generation prompt
~/drupal-agentic-workflow/bin/setup.sh --help            # Show help
```

### 4. Fill In Project Details

In your `CLAUDE.md`, complete:
- **Custom Modules** — auto-populated by setup if modules were found; review and adjust
- **Contributed Modules** — list installed contrib
- Review generated `AI_CONTEXT.md` files in `web/modules/custom/*/` and add any missing context
- Any project-specific conventions

### 5. Verify Setup

```bash
# Check that hooks are registered
cat .claude/settings.json | jq '.hooks'

# Check that skills are available (start Claude Code)
claude
# Then type: /drupal-expert
```

## What's Included

### Skills (20)

| Skill | Type | Purpose |
|-------|------|---------|
| **drupal-expert** | Inline | Drupal development knowledge base |
| **scaffold** | Inline | Generate modules, services, plugins, forms, hooks |
| **code-review** | Agent | Architectural code reviews with reports |
| **generate-tests** | Agent | PHPUnit test generation for custom modules |
| **debug** | Inline | Drupal code-level troubleshooting |
| **ddev** | Inline | DDEV environment management |
| **migrate** | Inline | Drupal migration management |
| **solr-setup** | Inline | DDEV Solr configuration |
| **drupal-frontend-expert** | Inline | Twig, SDC, theming, CSS/JS libraries, a11y |
| **drupal-site-builder-expert** | Inline | Views, content types, Layout Builder, config mgmt |
| **drupal-security** | Inline | Proactive security during development |
| **update-module** | Inline | Safe contrib module update workflow |
| **config-management** | Inline | Config export/import, Config Split, Recipes |
| **performance** | Inline | Caching, queries, BigPipe, profiling |
| **drush** | Inline | Drush CLI reference, SQL, PHP eval, deprecated commands |
| **refactor** | Inline | Code smell detection and refactoring guidance |
| **doctor** | Inline | Diagnostic health check for workflow setup |
| **accessibility** | Inline | WCAG 2.2 compliance, ARIA patterns, a11y testing |
| **api** | Inline | REST, JSON:API, GraphQL for decoupled Drupal |
| **entity** | Inline | Custom content/config entity types with bundles |

### Hooks

| Hook | Event | Purpose |
|------|-------|---------|
| **pre-bash-guard.sh** | PreToolUse (Bash) | Blocks destructive commands |
| **post-generation-lint.sh** | PostToolUse (Write/Edit) | Auto-fix + lint + security scan |
| **prompt-context.sh** | UserPromptSubmit (opt-in) | Git status summary injection |

### Other

- **Starter theme scaffold** — Ready-to-use theme template in `assets/theme-template/`
- **CLAUDE-TEMPLATE.md** — Drupal coding standards appended to your project's CLAUDE.md
- **phpstan.neon** — Generated with Drupal-specific configuration

## Usage

Once set up, use skills via slash commands in Claude Code:

```
/scaffold module my_module             # Generate a new module
/code-review my_module                 # Review a module
/generate-tests my_module              # Generate PHPUnit tests
/debug                                 # Troubleshoot an issue
/migrate                               # Manage migrations
/ddev                                  # DDEV environment help
/drupal-frontend-expert                # Theming and frontend help
/drupal-site-builder-expert            # Site building guidance
/drupal-security                       # Security review/guidance
/drush                                 # Drush CLI reference and commands
/update-module                         # Safe module update workflow
/config-management                     # Config management guidance
/performance                           # Performance optimization
/refactor                              # Code refactoring guidance
/doctor                                # Verify workflow setup health
/accessibility                         # WCAG 2.2 compliance guidance
/api                                   # REST, JSON:API, GraphQL help
/entity                                # Custom entity type guidance
```

## Manual Setup

### 1. Copy Skills and Hooks

Copy the `.claude/` directory into your Drupal project root:

```bash
cp -r .claude/ /path/to/your/drupal-project/.claude/
```

### 2. Generate CLAUDE.md

In your Drupal project root, initialize Claude Code:

```bash
claude /init
```

### 3. Add Drupal Rules

Open [`CLAUDE-TEMPLATE.md`](CLAUDE-TEMPLATE.md) and copy the sections into your project's `CLAUDE.md`.

### 4. Install Code Quality Tools

```bash
ddev composer require --dev drupal/coder phpstan/phpstan mglaman/phpstan-drupal phpstan/phpstan-deprecation-rules
```

### 5. Fill In Project Details

In your `CLAUDE.md`, complete the Custom Modules and Contributed Modules sections.
```
