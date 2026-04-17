# omedia-drupal-skill Index

## Repo Facts

- Path: /Users/webchick/Documents/Codex/2026-04-17-research-drupal-ai-tooling-landscape-synthesis-2/research/repos/omedia-drupal-skill
- Last commit date: 2025-10-19 15:53:03 +0400
- Skill count (SKILL.md): 3

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
./.claude-plugin
./.claude-plugin/marketplace.json
./.gitignore
./INDEX.md
./README.md
./drupal-backend
./drupal-backend/SKILL.md
./drupal-backend/assets
./drupal-backend/assets/module-template
./drupal-backend/references
./drupal-backend/references/hooks.md
./drupal-backend/references/module_structure.md
./drupal-frontend
./drupal-frontend/SKILL.md
./drupal-frontend/assets
./drupal-frontend/assets/theme-template
./drupal-frontend/references
./drupal-frontend/references/theming.md
./drupal-tooling
./drupal-tooling/SKILL.md
./drupal-tooling/references
./drupal-tooling/references/ddev.md
./drupal-tooling/references/drush.md
~~~

## File Type Counts

~~~text
.css	1
.js	1
.json	1
.md	12
.module	1
.php	1
.theme	1
.twig	1
.yml	4
[dotfile-no-ext]	1
~~~

## README (First 200 Lines)

Source: README.md

~~~text
# Drupal Development Skills for Claude Code

Comprehensive Drupal development skills for Claude Code, organized by specialization. Choose the skills you need for front-end development, back-end development, or development tooling for Drupal 8-11+.

## Quick Start

### Install from Marketplace

If this repository is hosted on GitHub or another git service:

```bash
# Add this marketplace
/plugin marketplace add Omedia/drupal-skill

# Install all three skills
/plugin install drupal-frontend
/plugin install drupal-backend
/plugin install drupal-tooling

# Or install just what you need
/plugin install drupal-frontend  # For theme development
/plugin install drupal-backend   # For module development
```

### Install from Local Repository

For local development or testing:

```bash
# Add local marketplace
/plugin marketplace add /path/to/drupal-skill

# Install skills
/plugin install drupal-frontend
/plugin install drupal-backend
/plugin install drupal-tooling
```

## Available Skills

### drupal-frontend - Front End Specialist

Theme development, Twig templates, and Drupal's rendering system.

**Features:**
- Theme structure and configuration
- Twig templating syntax and filters
- Template suggestions and debugging
- Preprocessing functions
- CSS/JS library management
- Responsive design and breakpoints
- Accessibility best practices

**Use when:**
- Creating or customizing Drupal themes
- Working with Twig templates
- Implementing preprocessing functions
- Managing CSS/JS assets
- Building responsive, accessible designs

**Includes:**
- Complete theming reference (`theming.md`)
- Theme template scaffold
- Twig examples and patterns

### drupal-backend - Back End Specialist

Custom module development, hooks, APIs, and PHP programming.

**Features:**
- Custom module development
- Drupal hooks system
- Controllers and routing
- Forms API (configuration and custom)
- Entity API operations
- Plugin system (blocks, fields, etc.)
- Services and dependency injection
- Database operations

**Use when:**
- Building custom modules
- Implementing hooks
- Working with entities, forms, or plugins
- Creating custom controllers or services
- Database operations and queries

**Includes:**
- Hooks reference with examples (`hooks.md`)
- Module structure patterns (`module_structure.md`)
- Module template scaffold

### drupal-tooling - Development Tools

**Development environment and command-line tools**

DDEV Docker environments and Drush command-line operations.

**Features:**
- DDEV project setup and management
- Database import/export and snapshots
- Drush cache, configuration, and module commands
- Deployment workflows
- User management and debugging
- Performance optimization

**Use when:**
- Setting up local development environments
- Managing databases and configuration
- Running Drush commands
- Deploying configuration changes
- Debugging and troubleshooting

**Includes:**
- Complete DDEV reference (`ddev.md`)
- Complete Drush reference (`drush.md`)
- Workflow examples

## Usage Examples

Once installed, Claude automatically invokes the appropriate skill:

```
# Frontend work (uses drupal-frontend)
"Create a custom theme with a two-column layout"
"Write a preprocess function to add custom variables"
"Create a Twig template for article nodes"

# Backend work (uses drupal-backend)
"Create a custom module that adds a new content entity"
"Write a hook_form_alter to modify the user registration form"
"Build a custom block plugin with configuration"

# Tooling work (uses drupal-tooling)
"Set up a new DDEV project for Drupal 10"
"Import this database and clear the cache"
"Export configuration using Drush"
```

## Supported Drupal Versions

All skills support:
- Drupal 8.x
- Drupal 9.x
- Drupal 10.x
- Drupal 11.x

## Requirements

- **Claude Code** installed
- **For drupal-tooling**: Docker and DDEV installed for local development
- **For drupal-tooling**: Drush 10+ for command-line operations
- **For drupal-backend**: PHP 7.0+ (version depends on Drupal version)

## Repository Structure

```
drupal-skill/
├── .claude-plugin/
│   └── marketplace.json          # Marketplace with all three skills
├── drupal-frontend/
│   ├── SKILL.md                  # Frontend skill instructions
│   ├── references/
│   │   └── theming.md
│   └── assets/
│       └── theme-template/
├── drupal-backend/
│   ├── SKILL.md                  # Backend skill instructions
│   ├── references/
│   │   ├── hooks.md
│   │   └── module_structure.md
│   └── assets/
│       └── module-template/
├── drupal-tooling/
│   ├── SKILL.md                  # Tooling skill instructions
│   └── references/
│       ├── ddev.md
│       └── drush.md
├── LICENSE
├── .gitignore
└── README.md                     # This file
```

## Development

### Testing Locally

1. Clone this repository
2. Add as local marketplace: `/plugin marketplace add ./drupal-skill`
3. Install skills: `/plugin install drupal-frontend` (or backend, tooling)
4. Test with Drupal development tasks

### Contributing

Contributions are welcome! Please:

1. Test changes thoroughly with multiple Drupal versions (8-11+)
2. Update reference documentation as needed
3. Follow existing code patterns and structure
4. Update version numbers in marketplace.json


~~~

## License

No top-level license file found.
