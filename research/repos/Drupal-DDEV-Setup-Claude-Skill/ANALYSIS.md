# Analysis: Drupal-DDEV-Setup-Claude-Skill

1. **What problem does it solve?**  
This repo packages a Claude-oriented skill for creating new Drupal projects, onboarding developers onto existing projects, syncing local environments after pulls, and resetting broken local setups. `README.md` presents it as an end-to-end Drupal lifecycle helper centered on DDEV workflows, while `.claude/skills/drupal-setup/skill.md`, `.claude/skills/drupal-setup/init.sh`, and the documented templates handle the underlying setup logic.

2. **Primary artefact type**  
Skill plus templates. The main artefacts are `.claude/skills/drupal-setup/skill.md`, `.claude/skills/drupal-setup/init.sh`, and the repo-level planning and workflow documents such as `CurrentWorkflow.md` and `plan.md`.

3. **Distribution model**  
Standalone GitHub repo installed by cloning and copying `.claude/skills/drupal-setup/` into `~/.claude/skills/`, or by packaging a zip for Claude Code Web, as documented in `README.md`, `INSTALL.md`, and `package-skill.sh`.

4. **Standards conformance**  
Low to moderate. The repo uses a skill-like layout under `.claude/skills/drupal-setup/`, but `INDEX.md` records zero `SKILL.md` files because the main file is lowercase `skill.md`, and there is no `AGENTS.md`. The format is therefore Claude-oriented rather than cleanly agentskills.io-native.

7. **Coverage**  
- New-project scaffolding for Drupal 11 Core or Drupal CMS: `README.md`, `.claude/skills/drupal-setup/skill.md`  
- Existing-project onboarding and local sync after pulling: `README.md`, `CurrentWorkflow.md`  
- DDEV environment management and reset flows: `README.md`, `.claude/skills/drupal-setup/skill.md`  
- Project templates for settings, gitignore, DDEV config, README, and CLAUDE guidance: `README.md`, `.claude/skills/drupal-setup/README.md`  
- Organizational workflow assumptions and architecture notes: `CurrentWorkflow.md`, `plan.md`

8. **Quality signals**  
- Last commit date: `INDEX.md` records `2025-11-12 20:38:19 +0000`.  
- Issue count: `REPO_METADATA.md` records 1 open issue.  
- Stars/watchers: `REPO_METADATA.md` records 12 stars and 2 watchers.  
- License: `REPO_METADATA.md` records GPL-2.0 and `INDEX.md` shows `LICENSE`.  
- Tests/evals/CI: none are evident in `INDEX.md`.  
- Maintainer signal: weak to moderate; the GitHub metadata shows recent repo updates in March 2026, but the actual last pushed commit recorded in `REPO_METADATA.md` and `INDEX.md` is from November 2025.

11. **Compatibility with ai_best_practices' decisions**  
Low. This repo is project-setup automation with organization-specific workflow assumptions, not universal cross-project guidance. To merge anything into ai_best_practices, the content would need to be split into gerund-named root `skills/` entries and trimmed heavily to remove project-template and local-environment assumptions. Its strongest overlap is the DDEV/onboarding topic area, not its overall package structure.

13. **One-paragraph verdict**  
**Reference**. `Drupal-DDEV-Setup-Claude-Skill` is useful prior art for DDEV-centric onboarding and local environment sync, but it is too Claude-specific, too workflow-prescriptive, and too project-setup-oriented to absorb directly into ai_best_practices. Reference it when shaping DDEV and onboarding guidance, but keep the consolidated library focused on reusable Drupal-wide practices rather than scaffold automation.
