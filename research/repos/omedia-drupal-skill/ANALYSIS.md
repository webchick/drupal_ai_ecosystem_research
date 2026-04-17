# Analysis: omedia-drupal-skill

1. **What problem does it solve?**  
This repo packages three Claude-installable Drupal development skills split by specialization: front end, back end, and tooling. `README.md` describes it as comprehensive Drupal development skills for Claude Code, and the actual skill bodies in `drupal-frontend/SKILL.md`, `drupal-backend/SKILL.md`, and `drupal-tooling/SKILL.md` provide direct guidance plus starter assets and references.

2. **Primary artefact type**  
Skills. The core artefacts are `drupal-frontend/SKILL.md`, `drupal-backend/SKILL.md`, `drupal-tooling/SKILL.md`, and the marketplace descriptor `.claude-plugin/marketplace.json`.

3. **Distribution model**  
Standalone GitHub repo distributed through Claude plugin marketplace semantics. `README.md` instructs users to run `/plugin marketplace add Omedia/drupal-skill` and then `/plugin install drupal-frontend`, `/plugin install drupal-backend`, or `/plugin install drupal-tooling`. It also supports local marketplace installation from a checked-out repo.

4. **Standards conformance**  
Partial. The repo uses `SKILL.md` files, but not the root `skills/` directory and not `AGENTS.md`. It is packaged for Claude’s plugin marketplace via `.claude-plugin/marketplace.json`, so it is more proprietary than agentskills.io-native repos such as `drupal-canvas-skills`.

7. **Coverage**  
- Custom module development, hooks, controllers, routing, forms, entities, plugins, services, and database operations: `drupal-backend/SKILL.md`, `drupal-backend/references/hooks.md`, `drupal-backend/references/module_structure.md`  
- Theme development, Twig templating, preprocessing, template suggestions, asset libraries, and responsive design: `drupal-frontend/SKILL.md`, `drupal-frontend/references/theming.md`  
- DDEV, Drush, deployment workflows, database operations, and troubleshooting: `drupal-tooling/SKILL.md`, `drupal-tooling/references/ddev.md`, `drupal-tooling/references/drush.md`  
- Scaffolding templates for modules and themes: `drupal-backend/assets/module-template/`, `drupal-frontend/assets/theme-template/`

8. **Quality signals**  
- Last commit date: `INDEX.md` records `2025-10-19 15:53:03 +0400`.  
- Issue count: `REPO_METADATA.md` records 0 open issues.  
- Stars/watchers: `REPO_METADATA.md` records 18 stars and 0 watchers.  
- Tests/evals/CI: none are visible in `INDEX.md`.  
- Packaging discipline: there is at least a marketplace descriptor in `.claude-plugin/marketplace.json`.  
- Maintainer signal: mixed. `REPO_METADATA.md` shows recent metadata updates in April 2026, but the actual recorded push and last commit date are from October 2025.

11. **Compatibility with ai_best_practices' decisions**  
Moderate. The topical overlap is strong, especially for broad Drupal backend/frontend/tooling guidance, but the packaging diverges from root `skills/`, the skill names are nouns rather than gerunds, and the distribution model is plugin-marketplace specific. To merge content, ai_best_practices would need to split and rename the guidance into gerund-form root skills and trim any Claude-specific install framing from `README.md`.

13. **One-paragraph verdict**  
**Absorb**. `omedia-drupal-skill` contains broadly relevant Drupal guidance in a reasonably modular form, especially in `drupal-backend/SKILL.md`, `drupal-frontend/SKILL.md`, and `drupal-tooling/SKILL.md`. The packaging should not be copied, but ai_best_practices should selectively absorb topic content and reference structure from these files while converting names and layout to its already-decided conventions.
