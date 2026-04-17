# jamieaa64-Drupal-DDEV-Setup-Claude-Skill — Structural Index

**Source URL**: https://github.com/jamieaa64/Drupal-DDEV-Setup-Claude-Skill
**Clone URL used**: https://github.com/jamieaa64/Drupal-DDEV-Setup-Claude-Skill
**Last commit**: 2025-11-12 20:38:19 +0000
**Last commit subject**: Merge pull request #1 from jamieaa64/claude/consolidate-to-main-011CV4dT6bD6bbaJSzxqbwk7
**License**: LICENSE
**Default branch**: refs/heads/main

## File type counts

      9 md
      2 sh
      1 yaml
      1 php
      1 MD
      1 /LICENSE
      1 gitignore
      1 claude/skills/drupal-setup/templates/gitignore

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

Number of SKILL.md files: 0

(no SKILL.md files)

## File tree (depth 3)

```
.
./.claude
./.claude/skills
./.claude/skills/drupal-setup
./CurrentWorkflow.md
./HISTORY.md
./INSTALL.md
./LICENSE
./package-skill.sh
./plan.md
./README.md
./SKILL_IMPROVEMENTS.MD
```

## README first 200 lines

Source: README.md

```
# Drupal Setup & Development Skill for Claude Code

A comprehensive Claude Code skill for the complete Drupal development lifecycle - from project creation to team collaboration and ongoing maintenance.

**Works in both Claude Code CLI (local) and Web environments.**

## ⚡ Quick Start

### 1. Install the Skill

**See [INSTALL.md](INSTALL.md) for detailed installation instructions.**

**Quick install (Claude Code CLI):**
```bash
# Clone repository
git clone https://github.com/jamieaa64/Drupal-DDEV-Setup-Claude-Skill.git
cd Drupal-DDEV-Setup-Claude-Skill

# Copy to user skills directory
mkdir -p ~/.claude/skills
cp -r .claude/skills/drupal-setup ~/.claude/skills/
```

**Quick install (Claude Code Web):**
```bash
# Package the skill
./package-skill.sh

# Upload drupal-setup-skill.zip to Claude Code Web
```

### 2. Use the Skill

**New project:**
```
Create a new Drupal site called "my-project"
```

**Existing project:**
```
Set up this existing Drupal project
```

**Update after pulling:**
```
Update my local Drupal environment
```

## 🎯 What This Skill Does

### For New Projects
- **30-second setup** with organizational best practices
- Creates Drupal 11 Core or Drupal CMS projects
- Generates all configuration files (settings.php, .gitignore, DDEV config)
- Sets up Git repository and pushes to GitHub
- Includes comprehensive documentation

### For Existing Projects
- **2-minute onboarding** for new team members
- Automatic environment sync after pulling changes
- One-command reset for clean slate
- Works with or without DDEV
- Environment-aware (adapts to local CLI vs web)

### Key Features
- ✅ Intelligent scenario detection (new vs existing project)
- ✅ Environment detection (DDEV vs web)
- ✅ Template-based Quick Mode (fast, production-aligned)
- ✅ Optional Full Mode (SQLite for testing)
- ✅ Complete lifecycle management (setup → develop → maintain)
- ✅ Team collaboration workflows

## 📚 Documentation

- **[INSTALL.md](INSTALL.md)** - Complete installation guide
- **[plan.md](plan.md)** - Architecture and design decisions
- **[CurrentWorkflow.md](CurrentWorkflow.md)** - Organization's Drupal workflow
- **[.claude/skills/drupal-setup/README.md](.claude/skills/drupal-setup/README.md)** - Detailed skill documentation

## 🚀 Usage Examples

### Scenario 1: Creating a New Project

```
You: "Create a new Drupal site called 'client-portal'"

Claude: I'll help you set up a new Drupal project!

1. Project name: client-portal
2. Drupal variant: [1] Drupal 11 Core / [2] Drupal CMS / [3] Minimal
   Choice: 1
3. Setup mode: [1] Quick (30s) / [2] Full (5-8min)
   Choice: 1 (default)
4. GitHub repository: https://github.com/org/client-portal
5. Include common modules? Y

✓ Project created in 30 seconds!
✓ Pushed to GitHub
✓ Ready for team to clone and deploy
```

### Scenario 2: New Team Member Onboarding

```bash
# New developer joins team
git clone https://github.com/org/client-portal
cd client-portal
```

```
You: "Set up this existing Drupal project"

Claude: This looks like an existing Drupal project!

What would you like to do?
[1] Initial setup (first time working on this project)
[2] Update after pulling changes
[3] Reset local environment
[4] Create new project instead

Choice: 1

[With DDEV - Fully Automated]
✓ ddev start
✓ ddev composer install
✓ ddev drush site:install --existing-config
✓ ddev launch

Done! Site ready at https://client-portal.ddev.site
Login: admin / admin

Your local development environment is ready!
```

### Scenario 3: Syncing After Pulling Changes

```bash
git pull  # Team member pushed changes
```

```
You: "Update my local Drupal environment"

Claude: Syncing your environment...

✓ ddev composer install (new dependencies)
✓ ddev drush config:import -y (config changes)
✓ ddev drush updb -y (database updates)
✓ ddev drush cache:rebuild

Changes applied:
- Dependencies updated (composer.lock changed)
- Configuration imported (3 config files changed)
- Database updates run (2 updates)
- Cache cleared

Your local environment is now in sync with the repository!
```

### Scenario 4: Reset Broken Environment

```
You: "Reset my Drupal environment"

Claude: Resetting your local environment...

✓ ddev delete -y (removed database)
✓ ddev start
✓ ddev composer install
✓ ddev drush site:install --existing-config
✓ ddev launch

Environment reset complete!
Fresh Drupal installation with current configuration.
```

## 🏗️ Project Structure

Created projects include:

```
project-name/
├── .ddev/
│   └── config.yaml          # DDEV configuration
├── config/
│   └── sync/                # Drupal configuration (version controlled)
├── private/                 # Private files directory
├── web/                     # Drupal web root
│   ├── modules/custom/     # Custom modules
│   ├── themes/custom/      # Custom themes
│   └── sites/default/
│       ├── settings.php    # Organization-specific settings
│       └── settings.local.php
├── .gitignore              # Comprehensive Drupal .gitignore
├── composer.json           # PHP dependencies
├── README.md               # Project documentation
└── CLAUDE.md               # Claude Code guidance for this project
```

## 🔧 Requirements
```
