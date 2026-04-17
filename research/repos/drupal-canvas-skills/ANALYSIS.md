# Analysis: drupal-canvas-skills

1. **What problem does it solve?**  
This repo provides a focused skill library for developing Drupal Canvas Code Components. `README.md` defines it as a collection of agentskills.io-formatted skills for Canvas development, and the individual files under `skills/` break that problem into narrower tasks like component definition, metadata/schema design, composability, data fetching, styling conventions, push/publish, and workbench usage.

2. **Primary artefact type**  
Skills. `INDEX.md` records 9 `SKILL.md` files, all under `skills/`, including `skills/canvas-component-definition/SKILL.md`, `skills/canvas-component-metadata/SKILL.md`, `skills/canvas-component-push/SKILL.md`, and related Canvas-specialized entries.

3. **Distribution model**  
Standalone npm-distributed GitHub repo. `README.md` installs it with `npx skills add drupal-canvas/skills`, and `INDEX.md` records `package.json`/`package-lock.json` rather than Composer packaging.

4. **Standards conformance**  
High. `README.md` explicitly says the skills follow the Agent Skills format, and `INDEX.md` confirms the preferred root `skills/` layout with multiple `SKILL.md` files. This is one of the cleaner standards-aligned repos in the landscape.

7. **Coverage**  
- Canonical Canvas component contract and minimum file set: `skills/canvas-component-definition/SKILL.md`  
- `component.yml` metadata, prop/slot rules, enum handling, and validation details: `skills/canvas-component-metadata/SKILL.md`  
- Component composability and repeatable content patterns: `skills/canvas-component-composability/SKILL.md`, `skills/canvas-component-composability/references/repeatable-content.md`  
- Canvas data-fetching patterns: `skills/canvas-data-fetching/SKILL.md`  
- Styling conventions for Canvas components: `skills/canvas-styling-conventions/SKILL.md`  
- Component utilities: `skills/canvas-component-utils/SKILL.md`  
- Workbench preview/mocks and page definition support: `skills/canvas-workbench/SKILL.md`, `skills/canvas-page-definition/SKILL.md`  
- Explicit push/publish workflow and retry behavior: `skills/canvas-component-push/SKILL.md`

8. **Quality signals**  
- Last commit date: `INDEX.md` records `2026-04-16 19:49:30 +0200`.  
- Issue count: `REPO_METADATA.md` records 0 open issues.  
- Stars/watchers: `REPO_METADATA.md` records 1 star and 1 watcher.  
- Packaging discipline: `INDEX.md` shows `package.json`, `package-lock.json`, and `.husky/pre-commit`.  
- Tests/evals/CI: no dedicated eval or workflow files are visible in the indexed top level.  
- Maintainer signal: active and very recent.

11. **Compatibility with ai_best_practices' decisions**  
Structurally high, scope-wise narrow. The repo already uses root `skills/` and standards-friendly `SKILL.md` files, but its topic area is specific to Drupal Canvas rather than universal Drupal development. If ai_best_practices covers Canvas at all, the content would still need renaming into gerund-form skill names and alignment with minimal metadata expectations.

13. **One-paragraph verdict**  
**Reference**. `drupal-canvas-skills` is one of the cleanest examples of standards-aligned skill packaging in the ecosystem, but its subject matter is specialized rather than universal. ai_best_practices should reference it as strong prior art for structure and for Canvas-specific extensions, while keeping the main consolidated library focused on topics that apply across Drupal projects.
