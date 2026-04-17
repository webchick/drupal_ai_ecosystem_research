# Analysis: drupal-claude-skills

1. **What problem does it solve?**  
This repo aims to distribute a reusable set of Drupal-focused skills and agents that a project can install quickly, giving AI coding tools battle-tested Drupal guidance for configuration management, contrib workflows, DDEV, security, OAuth, Search API, Canvas, and related review/execution gates. That framing is explicit in `README.md`, while `AGENTS.md` clarifies that the repository is not itself a Drupal project but a public skill-and-agent distribution repo.

2. **Primary artefact type**  
Primarily skills, secondarily agents and workflow guidance. `skills/*/SKILL.md` contains the core content, `.claude/agents/*.md` ships agent definitions, and `AGENTS.md` provides a repository-level workflow guide.

3. **Distribution model**  
Standalone GitHub repo installed via `npx skills add`, shell script, manual copy, or git clone. `README.md` documents all four paths, and `install.sh` supports scripted installation.

4. **Standards conformance**  
Strong on Agent Skills, partial on portability. `README.md` and `skills/*/SKILL.md` follow agentskills.io conventions, and `AGENTS.md` is present. The repo claims multi-tool compatibility for skills via `npx skills add` in `README.md`, but agents and settings still assume Claude-style `.claude/agents/` and `.claude/settings.json`, so only the skills layer is broadly portable.

5. **Architectural pattern**  
Flat portable skills library plus a parallel agent layer. `skills/*/SKILL.md` are independent skill entry points with references/examples folders, while `.claude/agents/*.md` define specialist reviewers/executors and `AGENTS.md` overlays a process model with mandatory quality and done gates. This is more than a flat skill dump, but it is not an aggregator or semantic index.

6. **Naming convention**  
Mixed and divergent from ai_best_practices. Some names are noun/topic based (`drupal-config-mgmt`, `drupal-search-api`, `drupal-ddev`), some are product/domain names (`drupal-canvas`, `drupal-simple-oauth`), and one is a meta noun (`skill-developer`). None follow the agreed gerund-prefix pattern such as `writing-automated-tests` or `creating-merge-requests`.

7. **Coverage**  
- General Drupal API/topic reference: `skills/drupal-at-your-fingertips/SKILL.md`  
- Configuration management: `skills/drupal-config-mgmt/SKILL.md`  
- Contrib updates and patch workflow: `skills/drupal-contrib-mgmt/SKILL.md`  
- Local DDEV development: `skills/drupal-ddev/SKILL.md`  
- Search API: `skills/drupal-search-api/SKILL.md`  
- OAuth/simple_oauth: `skills/drupal-simple-oauth/SKILL.md`  
- Security patterns: `skills/ivangrynenko-cursorrules-drupal/SKILL.md`  
- Drupal Canvas component work: `skills/drupal-canvas/SKILL.md`  
- Skill authoring/meta guidance: `skills/skill-developer/SKILL.md`  
- Code review/quality gate process: `.claude/agents/quality-gate.md` and `AGENTS.md`  
- Completion validation: `.claude/agents/done-gate.md` and `AGENTS.md`

8. **Quality signals**  
- Last commit date: `INDEX.md` records `2026-03-20 13:33:12 -0400`.  
- Issue count: `REPO_METADATA.md` records 2 open issues.  
- Stars/watchers: `REPO_METADATA.md` records 57 stars and 4 watchers.  
- Tests: no automated test suite is present in `INDEX.md`; quality control is procedural via agents such as `.claude/agents/quality-gate.md`, not code tests.  
- Eval harness: none found; no `evals/` directory in `INDEX.md`.  
- CI: no workflow files are visible in the depth-3 tree in `INDEX.md`.  
- Versioning discipline: moderate; install paths are documented in `README.md`, but the repo is distributed as a GitHub repo rather than a tagged Drupal/Composer package.  
- Active maintainer signal: `REPO_METADATA.md` shows recent updates in April 2026, and upstream sync scripts exist in `.claude/scripts/`.

9. **Notable innovations**  
The strongest innovation is the combination of skills with explicit agent workflow gates. `AGENTS.md` makes `quality-gate` and `done-gate` mandatory before claiming completion, and `.claude/agents/quality-gate.md` codifies a real review checklist rather than only topical domain guidance. The repo also includes upstream sync scripts in `.claude/scripts/`, which is a practical maintenance mechanism absent from many peer repos.

10. **Weaknesses / gaps**  
It is still Claude-shaped in important places: installation paths, agents, and settings all assume `.claude/*` even though the skills themselves are portable (`README.md`, `AGENTS.md`). The naming convention diverges from ai_best_practices, some content is product/module specific rather than universal Drupal guidance (`skills/drupal-canvas/SKILL.md`, `skills/drupal-simple-oauth/SKILL.md`), and there is no eval harness to prove the guidance triggers or performs well.

11. **Compatibility with ai_best_practices' decisions**  
Partially compatible. The repo already uses a root `skills/` directory and agentskills.io `SKILL.md`, which makes it mechanically mergeable. To merge into ai_best_practices, the skill names would need renaming to the gerund-prefix convention, `.claude/`-specific installation guidance would need to be de-emphasized or split off, metadata would need to stay minimal, and product-specific skills like Canvas or simple_oauth would need disposition decisions because ai_best_practices is scoped to broadly applicable Drupal guidance.

12. **Relationship to Surge**  
Compatible. Surge explicitly documents adding Git repositories like this one as Composer packages in `surge/src/Skills/README.md`, and `drupal-claude-skills` already ships standard `skills/*/SKILL.md` content that an aggregator can consume. The only friction is that its agents/settings layer is still Claude-specific.

13. **One-paragraph verdict**  
**Absorb** selected skill content and **reference** the agent layer. This is one of the strongest direct overlaps with ai_best_practices because it already uses `skills/` and ships substantive Drupal guidance, especially in files like `skills/drupal-config-mgmt/SKILL.md` and `skills/drupal-contrib-mgmt/SKILL.md`. The best path is not a wholesale merge: pull high-quality, broadly applicable guidance into gerund-named ai_best_practices skills, but leave the Claude-specific `.claude/agents/*` layer as an external reference or future inspiration for optional workflow helpers.
