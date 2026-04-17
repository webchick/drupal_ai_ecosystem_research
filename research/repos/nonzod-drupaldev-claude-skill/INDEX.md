# nonzod-drupaldev-claude-skill — Structural Index

**Source URL**: https://github.com/nonzod/drupaldev-claude-skill
**Clone URL used**: https://github.com/nonzod/drupaldev-claude-skill
**Last commit**: 2025-11-11 15:43:04 +0100
**Last commit subject**: Custom commands
**License**: none
**Default branch**: refs/heads/main

## File type counts

```
     37 md
      1 sh
      1 png
      1 gitignore
```

## Presence of key files/dirs

- CLAUDE.md: ✓ present
- AGENTS.md: ✗ absent
- README: ✓ present (README.md)
- skills/ : ✗ absent
- .claude/ : ✓ present
- .claude/skills/ : ✓ present
- agents/ : ✗ absent
- commands/ : ✗ absent (note: `.claude/commands/` is present)
- hooks/ : ✗ absent
- prompts/ : ✗ absent
- evals/ : ✗ absent
- composer.json: ✗ absent
- package.json: ✗ absent
- skills.yaml: ✗ absent
- .cursorrules / .cursor/ : ✗ absent
- .github/ : ✗ absent

## SKILL.md count

Number of SKILL.md files (case-sensitive): **1**

Lowercase `skill.md` count: 0 (none — not flagged)

Paths:
- `./.claude/skills/drupal-standards/SKILL.md`

## File tree (depth 3)

```
.
./.claude
./.claude/commands
./.claude/commands/refactor-module.md
./.claude/commands/user-story.md
./CLAUDE.md
./CLAUDE.sample.md
./.claude/skills
./.claude/skills/drupal-standards
./coding_standards
./coding_standards/accessibility
./coding_standards/accessibility/accessibility.md
./coding_standards/composer
./coding_standards/composer/package-name.md
./coding_standards/css
./coding_standards/css/architecture.md
./coding_standards/css/coding.md
./coding_standards/css/csscomb.md
./coding_standards/css/file-organization.md
./coding_standards/css/files
./coding_standards/css/format.md
./coding_standards/css/review.md
./coding_standards/index.md
./coding_standards/javascript
./coding_standards/javascript/best-practice.md
./coding_standards/javascript/coding.md
./coding_standards/javascript/documentation.md
./coding_standards/javascript/eslint.md
./coding_standards/javascript/jquery.md
./coding_standards/markup
./coding_standards/markup/style.md
./coding_standards/php
./coding_standards/php/coding.md
./coding_standards/php/documentation-examples.md
./coding_standards/php/documentation.md
./coding_standards/php/e_all.md
./coding_standards/php/exceptions.md
./coding_standards/php/index.md
./coding_standards/php/namespaces.md
./coding_standards/php/naming-services.md
./coding_standards/php/placeholders-delimiters.md
./coding_standards/php/psr4.md
./coding_standards/spelling
./coding_standards/spelling/spelling.md
./coding_standards/sql
./coding_standards/sql/conventions.md
./coding_standards/sql/keywords.md
./coding_standards/sql/select-from.md
./coding_standards/twig
./coding_standards/twig/coding.md
./coding_standards/yaml
./coding_standards/yaml/configuration-files.md
./install.sh
./README.md
```

## README first 200 lines

Source: README.md

```
# Drupal Coding Standards Skill

Claude Code skill that automatically applies Drupal coding standards based on development context.

## What It Does

Automatically detects file types and loads relevant coding standards:

- **PHP**: Coding, documentation, namespaces, PSR-4, services, exceptions
- **JavaScript**: Coding, documentation, best practices, ESLint, jQuery
- **CSS/SCSS**: Coding, formatting, file organization, architecture
- **SQL**: Conventions, keywords, SELECT queries
- **Twig**: Template coding and markup standards
- **YAML**: Configuration file standards
- **Composer**: Package naming conventions
- **Accessibility**: WCAG compliance standards

## Installation

### Quick Install

```bash
git clone <your-repository-url> drupal-standards-skill
cd drupal-standards-skill
./install.sh
```

### Manual Install

```bash
git clone <your-repository-url> drupal-standards-skill
cp -r drupal-standards-skill/.claude/skills/drupal-standards ~/.claude/skills/
```

### Verify Installation

```bash
ls -la ~/.claude/skills/drupal-standards
```

## Usage

The skill activates automatically when:
- Working with `.php`, `.js`, `.css`, `.sql`, `.twig`, `.yml` files
- Mentioning keywords: "module", "query", "template", "form", "custom code"

No manual activation required. Works in all Claude Code sessions globally.

## Structure

```
.claude/skills/drupal-standards/
├── SKILL.md              # Skill definition
├── README.md             # Documentation
└── coding_standards/     # Drupal standards
    ├── accessibility/
    ├── composer/
    ├── css/
    ├── javascript/
    ├── markup/
    ├── php/
    ├── spelling/
    ├── sql/
    ├── twig/
    └── yaml/
```

## Example

```
You: "Create a custom Drupal module for user management"

Claude will:
1. Detect: PHP module development
2. Load: php/coding.md, php/documentation.md, php/namespaces.md
3. Generate: Fully compliant module with proper structure
```

## Requirements

- Claude Code CLI (not available in web version)
- Linux, macOS, or Windows with bash

## Updating

```bash
cd drupal-standards-skill
git pull
./install.sh
```

## Uninstall

```bash
rm -rf ~/.claude/skills/drupal-standards
```

## Standards

All code follows Drupal's "always-current" standards:
- US English spelling enforced
- Version-independent standards
- Boy Scout Rule: Leave code better than you found it

## License

Follow Drupal community standards and licensing.
```
