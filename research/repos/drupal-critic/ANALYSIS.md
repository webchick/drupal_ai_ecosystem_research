1. **What problem does it solve?**
According to the `README.md`, `drupal-critic` addresses the problem that general-purpose reviewers miss Drupal-specific failure modes like cache tags that don't invalidate, config exports breaking on deploy, or reimplementing contrib modules as custom code. It layers Drupal domain expertise on top of `harsh-critic`'s structured investigation protocol by running specific checks (e.g., cache correctness, config safety, migration idempotency) and applying context-driven review perspectives that generic agents wouldn't know to apply.

2. **Primary artefact type**:
It is a combination of **skills**, **agents**, and an **aggregator**. Specifically, it provides a Claude Code skill (`.claude/skills/drupal-critic/SKILL.md`), a read-only review agent (`.claude/agents/drupal-critic.md`), and acts as an aggregator by orchestrating 24 external specialist skills listed in `.claude/skills/drupal-critic/references/external-skills-manifest.yaml`.

3. **Distribution model**:
It is a standalone git repo that installs manually via `git clone` or as a CLI package via `npx claude-skills`. As outlined in the `README.md` "Install" section, the installation involves copying its contents to the local `~/.claude/skills/` and `~/.claude/agents/` directories.

4. **Standards conformance**:
It uses Claude Code's native agent and skill formats, deploying to `.claude/skills/` and `.claude/agents/`. It includes a `SKILL.md` file (at `.claude/skills/drupal-critic/SKILL.md`) but does not use an `AGENTS.md` file (which is absent per `INDEX.md`). It is a single-tool compatible product designed specifically for Claude Code (as stated in the `README.md` Compatibility section).

7. **Coverage**:
As listed in the `README.md` ("Drupal review rubric" and "Referenced external skills") and mapped to specific reference files:
- **Security** (routes, entity queries, input validation, safe Twig): `.claude/skills/drupal-critic/references/drupal-review-rubric.md` and `external-skills-manifest.yaml` (`drupal-security`).
- **Caching** (tags, contexts, max-age, BigPipe): `.claude/skills/drupal-critic/references/drupal-review-rubric.md` and SparkFabrik skills in `external-skills-manifest.yaml`.
- **Operational Safety & Tooling** (Composer, Drush, DDEV): `.claude/skills/drupal-critic/references/drupal-review-rubric.md` and `external-skills-manifest.yaml` (`drupal-ddev`, `drupal-tooling`, `ddev-expert`).
- **Architecture & Content Editor** (contrib-first, dependency injection, hooks, workflows, permissions): `.claude/skills/drupal-critic/references/drupal-review-rubric.md` and `.claude/skills/drupal-critic/references/audience-activation-matrix.md`.
- **Contrib & Issue Queue** (upstream patches, issue research): `external-skills-manifest.yaml` (Scott Falconer and Kanopi external skills).
- **Canvas / Components** (defining components, data fetching, styling): `external-skills-manifest.yaml` (Drupal Canvas skills).

8. **Quality signals**:
- **Last commit date**: 2026-03-27 11:51:45 -0400 (per `INDEX.md` and Git log).
- **Versioning discipline**: Exceptional discipline; uses explicit pinned commit SHAs for external skills, which can be updated and validated via Python scripts like `scripts/refresh_external_skills.py` (per `README.md`).
- **CI / Tests**: Uses GitHub Actions for validation (`.github/workflows/validate.yml`) and policy enforcement via `scripts/verify_no_copied_skills.py` (per `INDEX.md`).
- **Active maintainer**: While recently updated (last month relative to system date), the repository's `README.md` explicitly declares that it is no longer actively maintained standalone, as it has been consolidated into `drupal-meta-skills`. Issue counts and stars are unavailable in the local environment.

11. **Compatibility with ai_best_practices' decisions**:
The repo uses a standard `SKILL.md` for skills but nests it under a `.claude/` directory, targeting Claude Code explicitly (e.g. `.claude/skills/drupal-critic/SKILL.md` and `.claude/agents/drupal-critic.md`). To merge it in, the specific target directory structure would need to be flattened to align with broader cross-tool standards (e.g., stripping the `.claude/` prefix and standardising on a top-level `/skills` and `/agents` structure). Additionally, the aggregator manifest `external-skills-manifest.yaml` would need adapting to support whatever standard formats `ai_best_practices` enforces.

13. **One-paragraph verdict**:
Because the `README.md` explicitly states "> This repository has been consolidated into drupal-meta-skills" and instructs users to use the consolidated repository for new installs and updates, `ai_best_practices` should **reference** `drupal-meta-skills` instead of this one, and effectively **ignore** this repo as a standalone candidate for absorption. While the quality and architectural practices (like using an external skill manifest and strict review rubrics) are exemplary, any integration or collaboration efforts should be directed to the active, consolidated project instead.