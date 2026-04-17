# Analysis: drupaltools-skills

1. **What problem does it solve?**  
`drupaltools-skills` aims to be a broad Drupal AI toolbox rather than a narrow coding-only library: it bundles installable skills for development, contrib work, onboarding, migration planning, site audits, contracts, postmortems, and more, alongside specialist agents. `README.md` presents it as a collection of AI skills for Drupal development, but the actual scope spills into delivery and business workflows too.

2. **Primary artefact type**  
Primarily skills, secondarily agents. The core library is `skills/*/SKILL.md`, and `agents/*.md` adds ten specialist agent personas.

3. **Distribution model**  
Standalone GitHub repo installable with `npx skills add https://github.com/drupaltools/skills` or by cloning into `~/.claude/skills/` or `~/.agents/skills/` as documented in `README.md`.

4. **Standards conformance**  
Good on skill layout, mixed on the broader package. The repo uses a root `skills/` directory with many `SKILL.md` files, which aligns mechanically with agentskills.io and ai_best_practices. It also includes agents outside the skill spec (`agents/*.md`) and an `opencode` workflow in `.github/workflows/opencode.yml`, so the package is multi-tool aware but not skill-only.

5. **Architectural pattern**  
Large flat library with optional specialist agents and embedded helper scripts. Most value lives directly in `skills/*/SKILL.md`, but some skills also ship executable helpers such as `skills/drupaltools-code-search/dsearch.py`, `skills/drupaltools-contrib-search/csearch.py`, and `skills/drupaltools-module-info/drupal-module-info.py`. There is no central routing/index layer beyond the repository catalog in `README.md`.

6. **Naming convention**  
Consistent prefixing, but not aligned with ai_best_practices' gerund decision. Every skill is namespaced with `drupaltools-` (for example `drupaltools-coding-standards`, `drupaltools-issue-generate`, `drupaltools-module-rename`), which helps avoid collisions but uses noun/task labels instead of the agreed gerund-prefix convention.

7. **Coverage**  
- Best-practice auditing: `skills/drupaltools-best-practices/SKILL.md`  
- Development checklisting: `skills/drupaltools-checklist-development/SKILL.md`  
- Drupal code search: `skills/drupaltools-code-search/SKILL.md`, `skills/drupaltools-code-search/dsearch.py`  
- Coding standards: `skills/drupaltools-coding-standards/SKILL.md`  
- Drupal contrib GitLab CI: `skills/drupaltools-contrib-gitlab-ci/SKILL.md`  
- Contrib source lookup/search: `skills/drupaltools-contrib-lookup/SKILL.md`, `skills/drupaltools-contrib-search/SKILL.md`, `skills/drupaltools-contrib-search/csearch.py`  
- README generation for contrib: `skills/drupaltools-contrib-readme/SKILL.md`  
- Contribution readiness validation: `skills/drupaltools-contrib-validator/SKILL.md`  
- Cost estimation / contracts / postmortems: `skills/drupaltools-cost-estimation/SKILL.md`, `skills/drupaltools-maintenance-contract/SKILL.md`, `skills/drupaltools-postmortem/SKILL.md`  
- Developer setup / onboarding: `skills/drupaltools-developer-setup/SKILL.md`, `skills/drupaltools-onboarding/SKILL.md`  
- Git blame / issue summary generation: `skills/drupaltools-git-blame/SKILL.md`, `skills/drupaltools-issue-generate/SKILL.md`  
- Migration planning: `skills/drupaltools-migration-plan/SKILL.md`  
- Module cloning/info/rename: `skills/drupaltools-module-clone/SKILL.md`, `skills/drupaltools-module-info/SKILL.md`, `skills/drupaltools-module-rename/SKILL.md`  
- OOP hooks: `skills/drupaltools-oop-hooks/SKILL.md`  
- Optimization / patching / site audit / site clone / translations: `skills/drupaltools-optimize/SKILL.md`, `skills/drupaltools-patch/SKILL.md`, `skills/drupaltools-site-audit/SKILL.md`, `skills/drupaltools-site-clone/SKILL.md`, `skills/drupaltools-translations/SKILL.md`

8. **Quality signals**  
- Last commit date: `INDEX.md` records `2026-04-16 09:00:15 +0200`.  
- Issue count: `REPO_METADATA.md` records 0 open issues.  
- Stars/watchers: `REPO_METADATA.md` records 3 stars and 0 watchers.  
- Tests: no dedicated automated test suite is visible in `INDEX.md`.  
- Eval harness: none found; no `evals/` directory in `INDEX.md`.  
- CI: `.github/workflows/opencode.yml` is present.  
- Versioning discipline: weak to moderate; no changelog or tagged-release structure is visible in the scanned tree, but the repo is very recently active.  
- Active maintainer signal: `REPO_METADATA.md` shows updates and pushes on 16 April 2026.

9. **Notable innovations**  
Its biggest contribution is breadth plus namespace discipline. The `drupaltools-` prefix avoids skill-name collisions, and several skills embed small utility scripts (`dsearch.py`, `csearch.py`, `fetch-blame.py`, `drupal-module-info.py`) that move beyond passive markdown guidance into reproducible helper tooling.

10. **Weaknesses / gaps**  
The scope is too broad for ai_best_practices' stated purpose. Skills about contracts, cost estimation, postmortems, and sales-style site audits in `README.md` are not universal Drupal engineering guidance. The naming scheme also conflicts with the gerund-prefix decision, and the absence of an eval harness or strong testing story makes content quality harder to verify.

11. **Compatibility with ai_best_practices' decisions**  
Mechanically high, semantically mixed. The root `skills/` layout is already correct, but names would need conversion from `drupaltools-*` to gerund-prefix forms, and a large portion of the catalog would need pruning as out of scope. The most compatible parts are coding-standards, contrib-validator, oop-hooks, translations, and some module/contrib workflow helpers.

12. **Relationship to Surge**  
Very compatible. Because the repo already uses a standard root `skills/` directory, Surge could aggregate the skill layer readily. The agent layer is extra and may remain tool-specific, but there is no structural conflict.

13. **One-paragraph verdict**  
**Absorb** selected skills, **ignore** out-of-scope business/process content, and **reference** the rest. `drupaltools-skills` is one of the most structurally mergeable repos in the landscape because it already uses `skills/` and ships many focused `SKILL.md` files. But ai_best_practices should be selective: pull in universally useful Drupal engineering guidance, not the repo's broader agency/business toolset.
