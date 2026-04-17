# Analysis of Drupal-DDEV-Setup-Claude-Skill

**1. What problem does it solve?**
According to the `README.md`, it is "A comprehensive Claude Code skill for the complete Drupal development lifecycle - from project creation to team collaboration and ongoing maintenance." It aims to provide a 30-second setup for new projects with organizational best practices (Drupal 11 Core or CMS, DDEV, Git) and a 2-minute onboarding process for existing projects by automating environment sync and local resets.

**2. Primary artefact type**
Claude Code plugin / skill.

**3. Distribution model**
Standalone git repo. It is installed manually by either cloning the repository and copying `.claude/skills/drupal-setup` to the user's `~/.claude/skills/` directory, or by running `./package-skill.sh` to create a `.zip` file for upload to Claude Code Web (detailed in `INSTALL.md` and `README.md`).

**4. Standards conformance**
Proprietary format. It does not use the `agentskills.io` format. There is no `SKILL.md` or `AGENTS.md` in the root directory (confirmed by `INDEX.md`). Instead, it uses Claude Code's native user/project skills format with a `skill.md` file located inside `.claude/skills/drupal-setup/`. It is strictly single-tool compatible (Claude Code only).

**7. Coverage**
- **Project scaffold / Creation (Drupal 11 Core & Drupal CMS)**: `.claude/skills/drupal-setup/skill.md`, `plan.md`
- **DDEV setup and configuration**: `.claude/skills/drupal-setup/skill.md`, `.claude/skills/drupal-setup/templates/ddev-config.yaml`
- **Configuration management / sync**: `.claude/skills/drupal-setup/skill.md`, `plan.md`
- **Git and GitHub repository setup (ignores, branching)**: `.claude/skills/drupal-setup/skill.md`, `.claude/skills/drupal-setup/templates/gitignore`
- **Local environment reset and team onboarding**: `.claude/skills/drupal-setup/skill.md`

**8. Quality signals**
- **Last commit date**: 2025-11-12 (from git log)
- **Issue count / Stars / Watchers**: Unknown locally, but links to a personal GitHub repo (`jamieaa64/Drupal-DDEV-Setup-Claude-Skill`).
- **Tests / Eval harness**: Absent. `HISTORY.md` explicitly states "**⚠️ THIS SKILL HAS NOT BEEN TESTED YET ⚠️**".
- **CI**: Absent (no `.github/workflows/` directory).
- **Versioning discipline**: None visible (relies on raw git clones and a manual packaging script).
- **Active maintainer**: Looks like an experimental, untested personal repository.

**11. Compatibility with ai_best_practices' decisions**
This repository is highly incompatible with `ai_best_practices` out of the box. 
- **Directory & Metadata**: It nests its core instructions inside a tool-specific folder (`.claude/skills/drupal-setup/skill.md`) rather than using a standard root-level `SKILL.md`. 
- **Scope**: It relies heavily on Claude Code's specific capabilities (e.g., executing shell scripts during initialization) and UI (Claude Code Web vs CLI detection).
- **To merge in**: It would require a complete rewrite to extract the Drupal/DDEV knowledge out of the Claude-specific bash scripts and into a standard, tool-agnostic `SKILL.md` format. The custom `./package-skill.sh` and proprietary directory structures would need to be discarded.

**13. One-paragraph verdict**
`ai_best_practices` should **absorb** the specific DDEV configuration templates and the conceptual workflows for "config-first" Drupal sync, but otherwise **ignore** the repository as a whole. The project is tightly coupled to Claude Code's proprietary skill format, explicitly admits to being completely untested, and takes a highly prescriptive approach to project scaffolding that overlaps with standard tools like Composer and DDEV. Extracting the useful workflow prompts (like how to reset a DDEV environment or sync configuration) into a standard, tool-agnostic `SKILL.md` is the only valuable path forward.