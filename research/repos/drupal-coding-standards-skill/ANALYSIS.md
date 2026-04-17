# Analysis: drupal-coding-standards-skill

1. **What problem does it solve?**  
This repo provides a Drupal coding-standards review skill that acts as a routing layer over official Drupal coding standards content. `README.md` describes it as an Agent Skill with dynamic context discovery, and `.claude/skills/drupal-coding-standards/SKILL.md` plus `.claude/skills/drupal-coding-standards/standards-index.md` show the intended model: identify the file type, map it to the right standards document, and load only the relevant standards instead of dumping a monolithic rule set into context.

2. **Primary artefact type**  
Skill. The core artefacts are `.claude/skills/drupal-coding-standards/SKILL.md`, `.claude/skills/drupal-coding-standards/standards-index.md`, and the repo-level `AGENTS.md`.

3. **Distribution model**  
Composer-installable standalone repo. `README.md` directs users to `composer require ronaldtebrake/drupal-coding-standards-skill --dev` and says the scaffolded skill lands in `.claude/skills/drupal-coding-standards/`. It can also be aggregated by Surge according to `README.md`.

4. **Standards conformance**  
Moderate to high. It uses `AGENTS.md` and a `SKILL.md`-based skill structure under `.claude/skills/drupal-coding-standards/`, and `README.md` explicitly references agentskills.io. It diverges from ai_best_practices on directory choice by using `.claude/skills/` instead of root `skills/`.

7. **Coverage**  
- Drupal coding standards review workflow: `.claude/skills/drupal-coding-standards/SKILL.md`  
- File-type routing for PHP, JavaScript, CSS, Twig, YAML, SQL, markup, and Composer: `.claude/skills/drupal-coding-standards/standards-index.md`  
- Accessibility and spelling as cross-cutting concerns: `.claude/skills/drupal-coding-standards/standards-index.md`  
- AGENTS.md integration for project-level loading: `AGENTS.md`, `README.md`

8. **Quality signals**  
- Last commit date: `INDEX.md` records `2026-04-06 08:42:41 +0200`.  
- Issue count: `REPO_METADATA.md` records 0 open issues.  
- Stars/watchers: `REPO_METADATA.md` records 8 stars and 1 watcher.  
- Tests/evals: none are visible in `INDEX.md`.  
- Versioning discipline: some signal exists via `CHANGELOG.md`.  
- Maintainer signal: mixed. The repo is recent and reasonably adopted, but `README.md` opens with “Unmaintained” and explicitly tells users to use `ai_best_practices` instead.

11. **Compatibility with ai_best_practices' decisions**  
High conceptually, medium structurally. The routing idea and official-source model fit well, but the repo would need to move from `.claude/skills/` to root `skills/`, rename the skill to a gerund form, and align metadata with ai_best_practices' minimal schema. The key architectural idea worth carrying forward is the deterministic file-type router in `.claude/skills/drupal-coding-standards/standards-index.md`, not the exact repo layout.

13. **One-paragraph verdict**  
**Absorb**. Despite being explicitly unmaintained, this repo contains one of the clearest single-purpose patterns in the landscape: keep local routing logic light and pull authoritative standards content by file type. ai_best_practices should absorb that pattern and any reusable wording from `.claude/skills/drupal-coding-standards/SKILL.md` and `.claude/skills/drupal-coding-standards/standards-index.md`, while not preserving the deprecated package as a separate destination.
