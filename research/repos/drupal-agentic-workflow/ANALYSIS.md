# Analysis: drupal-agentic-workflow

1. **What problem does it solve?**  
This repo is a Claude Code starter kit for Drupal projects that tries to improve coding quality in-flight by shipping 20 Drupal-focused skills plus automatic hooks for command blocking, formatting, linting, and security/performance scanning. `README.md` presents it as a reusable setup that turns Claude Code into a Drupal-native development partner.

2. **Primary artefact type**  
Starter-kit / workflow template with skills and hooks. The main components are `.claude/skills/*/SKILL.md`, `.claude/hooks/*`, `CLAUDE-TEMPLATE.md`, and `bin/setup.sh`.

3. **Distribution model**  
Standalone git repo installed by cloning and running `bin/setup.sh` against a Drupal project, or by manual copy of `.claude/`. `README.md` documents both paths.

4. **Standards conformance**  
Partial. Individual skills use `SKILL.md` frontmatter in `.claude/skills/*/SKILL.md`, but the repo is not organized as a standard root `skills/` library and is tightly coupled to Claude Code's `.claude/` layout, `CLAUDE.md`, and hook settings (`README.md`, `.claude/settings.json`). It is not positioned as multi-tool.

5. **Architectural pattern**  
Opinionated starter kit with post-edit enforcement hooks. `README.md` describes a runtime where Claude writes code, then `post-generation-lint.sh` auto-fixes and lints by file type, while `pre-bash-guard.sh` blocks destructive commands. `bin/setup.sh` is the bootstrapper that installs the package into a project.

6. **Naming convention**  
Mostly noun or expert-role based rather than gerund based: `drupal-expert`, `drupal-frontend-expert`, `drupal-site-builder-expert`, `debug`, `doctor`, `entity`, `performance`, `update-module`, `config-management`, and so on in `.claude/skills/*/SKILL.md`.

7. **Coverage**  
- General Drupal dev guidance: `.claude/skills/drupal-expert/SKILL.md`  
- Frontend/theming: `.claude/skills/drupal-frontend-expert/SKILL.md`  
- Site-building/config UI work: `.claude/skills/drupal-site-builder-expert/SKILL.md`  
- Security: `.claude/skills/drupal-security/SKILL.md`  
- Config management: `.claude/skills/config-management/SKILL.md`  
- DDEV: `.claude/skills/ddev/SKILL.md`  
- Drush: `.claude/skills/drush/SKILL.md`  
- Entities: `.claude/skills/entity/SKILL.md`  
- Tests: `.claude/skills/generate-tests/SKILL.md`  
- Migrations: `.claude/skills/migrate/SKILL.md`  
- Performance: `.claude/skills/performance/SKILL.md`  
- Refactoring: `.claude/skills/refactor/SKILL.md`  
- Accessibility: `.claude/skills/accessibility/SKILL.md`  
- APIs/decoupled work: `.claude/skills/api/SKILL.md`  
- Scaffold generation: `.claude/skills/scaffold/SKILL.md`  
- Hook-based destructive-command blocking: `.claude/hooks/pre-bash-guard.sh`, `.claude/hooks/README.md`  
- Hook-based auto-lint/security scan: `.claude/hooks/post-generation-lint.sh`, `.claude/hooks/README.md`

8. **Quality signals**  
- Last commit date: `INDEX.md` records `2026-03-12 15:26:59 +0100`.  
- Issue count: `REPO_METADATA.md` records 0 open issues.  
- Stars/watchers: `REPO_METADATA.md` records 3 stars and 0 watchers.  
- Tests: no dedicated automated test suite is visible in `INDEX.md`.  
- Eval harness: none found; no `evals/` directory in `INDEX.md`.  
- CI: no workflow files are visible in the depth-3 tree.  
- Versioning discipline: weak to moderate; setup is script-based via `bin/setup.sh`, but no changelog or release discipline is visible in the scanned tree.  
- Active maintainer signal: `REPO_METADATA.md` shows March 2026 activity, so it is recent but not yet broadly adopted.

9. **Notable innovations**  
Its strongest idea is the hook pipeline: `.claude/hooks/README.md` clearly defines pre-Bash destructive-command blocking and post-edit auto-fix/lint/security scanning, creating immediate feedback loops that many other repos only describe aspirationally. `bin/setup.sh` also appears more turnkey than many peers.

10. **Weaknesses / gaps**  
The repo is highly single-tool and installation-path-specific. Everything assumes `.claude/`, Claude hooks, and Claude settings; there is no AGENTS.md and no neutral `skills/` root. The skill names are also broad and expert-role-ish, which makes overlap and ambiguity more likely than focused task skills.

11. **Compatibility with ai_best_practices' decisions**  
Moderate for content, low for structure. The actual Drupal guidance in the skills could be mined, but the repo would need restructuring from `.claude/skills/` to root `skills/`, renaming to gerunds, and pruning of Claude-specific operational assumptions. The hook system is useful but should remain optional/external relative to ai_best_practices' core content library.

12. **Relationship to Surge**  
Surge would not consume this repo cleanly as-is because the content is buried under `.claude/skills/` and bundled with Claude hooks. There is no conceptual conflict, but the packaging conventions differ sharply.

13. **One-paragraph verdict**  
**Reference** with selective absorption of hook ideas and some skill content. This repo is valuable as evidence that automated quality gates and destructive-command guards can be bundled into an installable Drupal AI workflow, but its Claude-specific layout and broad skill naming make it a poor canonical base for ai_best_practices. Pull reusable guidance from the strongest skills, and treat the hook layer as a separate optional integration pattern.
