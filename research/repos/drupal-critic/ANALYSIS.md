# Analysis: drupal-critic

1. **What problem does it solve?**  
This repo defines a Drupal-specific review skill and agent for catching Drupal-native failure modes that generic reviewers miss, such as cache invalidation mistakes, config deployment breakage, contrib-first violations, migration idempotency, and editorial UX regressions. `README.md` frames it as a reviewer layered on top of `harsh-critic`, and the local architecture in `.claude/skills/drupal-critic/SKILL.md`, `.claude/skills/drupal-critic/references/`, and `.claude/agents/drupal-critic.md` emphasizes evidence-backed review with selective loading of external specialist skills.

2. **Primary artefact type**  
Review skill plus review agent. `README.md` describes both the `/drupal-critic` skill and the read-only reviewer agent in `.claude/agents/drupal-critic.md`.

3. **Distribution model**  
Standalone GitHub repo, installable by copy or with `npx claude-skills add`, according to `README.md`. It is not a Drupal module or Composer package. `README.md` also says the repo has already been consolidated into `drupal-meta-skills`, so this specific repo is no longer the preferred install target.

4. **Standards conformance**  
Moderate. The repo uses `.claude/skills/drupal-critic/SKILL.md` and `.claude/agents/drupal-critic.md`, but `INDEX.md` records no `AGENTS.md` and no root `skills/` tree. It is still Claude-oriented even though its core architecture could be ported elsewhere.

7. **Coverage**  
- Drupal review rubric across security, architecture, open source, site-builder, editor, operational, caching, testing, and confidence dimensions: `README.md`, `.claude/skills/drupal-critic/references/drupal-review-rubric.md`  
- Audience activation for site-builder/editor/open-source review modes: `README.md`, `.claude/skills/drupal-critic/references/audience-activation-matrix.md`  
- Routing to external specialist skills with pinned SHAs: `README.md`, `.claude/skills/drupal-critic/references/external-skills-manifest.yaml`, `.claude/skills/drupal-critic/references/skill-routing-map.md`  
- Read-only reviewer agent behavior: `.claude/agents/drupal-critic.md`  
- Refresh and policy-enforcement scripts for referenced skills: `scripts/refresh_external_skills.py`, `scripts/verify_no_copied_skills.py`

8. **Quality signals**  
- Last commit date: `INDEX.md` records `2026-03-27 11:51:45 -0400`.  
- Issue count: `REPO_METADATA.md` records 0 open issues.  
- Stars/watchers: `REPO_METADATA.md` records 9 stars and 0 watchers.  
- CI: `INDEX.md` shows `.github/workflows/validate.yml` and `.github/workflows/pages.yml`.  
- Research discipline: unusually strong; `INDEX.md` shows a dedicated `research/drupal-skills/` tree with reports and raw data.  
- Maintainer signal: active in early 2026, but the repo is already superseded; `README.md` says it has been consolidated into `drupal-meta-skills`.

11. **Compatibility with ai_best_practices' decisions**  
Partial. The review rubric and selective-routing ideas are compatible in spirit, but the packaging is `.claude/skills/` plus a reviewer agent rather than root `skills/`, and the repo is built around review orchestration rather than a general Drupal best-practices library. ai_best_practices could absorb some review-checklist phrasing and routing concepts, but not the repo intact.

13. **One-paragraph verdict**  
**Reference**. `drupal-critic` is strong architectural prior art for evidence-based Drupal review, especially its rubric and external-skill routing, but it is both reviewer-specific and already superseded by another bundle. ai_best_practices should reference it for synthesis and selectively borrow ideas, not absorb the repo wholesale.
