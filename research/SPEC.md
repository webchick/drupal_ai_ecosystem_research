# Proposal: Consolidating Drupal AI Best Practices

## 1. Problem statement

Drupal now has many overlapping AI guidance repos, but most duplicate the same topics in different layouts, naming schemes, and tool-specific wrappers. That fragmentation increases maintenance cost, confuses users, and makes it harder for the community to converge on one portable baseline. The opportunity for `ai_best_practices` is not to replace every experiment, but to become the canonical, portable **content source** for Drupal-wide skills while letting other tools handle installation, aggregation, and specialized workflows.

## 2. Current ai_best_practices decisions recap

This proposal builds on decisions already made in the issue queue:

- Skills are task-oriented and use **gerund-prefixed names**
- Skills live in root `skills/`
- Metadata stays minimal: `drupal-version` and `status`
- The package is **Composer-installable**
- Scope is **universal Drupal guidance**, not project-specific automation

## 3. Proposed architecture

`ai_best_practices` should be a **canonical content repo**, not another workflow framework and not another installer.

Recommended structure:

- `skills/<gerund-name>/SKILL.md` as the canonical entrypoint
- Optional `references/`, `assets/`, and `scripts/` inside each skill
- A short root `AGENTS.md` that indexes the skills and points only to `SKILL.md`
- No `.claude/`, plugin-marketplace, or harness-specific packaging in-source

Recommended content strategy:

- **Absorb** reusable, high-signal skill content from the best repos
- **Adapt** good ideas from richer systems without inheriting their whole runtime
- **Reference** specialized or workflow-heavy repos rather than cloning them
- **Leave distribution to Surge** and similar tooling

Recommended implementation pattern:

1. Start with the most duplicated universal topics:
   - coding standards
   - testing
   - contribution workflow
   - DDEV/Drush/tooling
   - security
2. Prefer deterministic routing where it reduces context cost:
   - file-type routing for coding standards
   - short AGENTS index entries with precise “when to use”
3. Keep evals optional and separate from skill metadata:
   - borrow the pattern from `drupal-workflow`
   - do not require heavyweight runtime machinery to consume the skills

## 4. Per-repo disposition

| Repo | Recommendation | Specific action items |
|---|---|---|
| surge | collaborate | Treat as delivery partner; document `ai_best_practices` as a first-class Surge source |
| aidev | ignore | Mention only as historical background |
| drupal-claude-skills | absorb | Pull high-value content from `drupal-at-your-fingertips`, `drupal-contrib-mgmt`, `drupal-ddev`, and security references |
| drupal-agent-resources | reference | Reuse ideas selectively; do not import `.claude/` packaging |
| drupal-workflow | reference | Borrow routing, eval, and gate patterns; do not import plugin/runtime structure |
| drupal-agentic-workflow | reference | Borrow hook/gate ideas and selected content only |
| claude-skill-drupal-module | reference | Mine API-reference structure for module-dev skills; do not preserve single-skill wrapper |
| drupaltools-skills | absorb | Pull universal Drupal guidance; drop business/process-only or off-scope skills |
| drupal-intent-testing | reference | Use as prior art for optional verification/eval guidance |
| drupal-contribute-fix | absorb | Make it a core input to contribution workflow skills |
| drupalcon-chicago-26-ckeditor-ai-playground | reference | Keep as worked example, not canonical content |
| prompt_library | reference | Reuse wording from Drupal-specific prompts/rules where useful |
| drupal-issue-hygiene-helper | reference | Use for issue-queue automation ideas, not as core skill content |
| drupal-coding-standards-skill | absorb | Fold in its routing model and standards index; retire as separate destination |
| drupal-critic | reference | Borrow review-rubric ideas; keep reviewer-agent logic external |
| Drupal-DDEV-Setup-Claude-Skill | reference | Reuse only portable DDEV/onboarding ideas |
| drupal-canvas-skills | reference | Keep as specialized Canvas extension ecosystem |
| omedia-drupal-skill | absorb | Pull reusable backend/frontend/tooling guidance into task-oriented skills |
| ai-fe-skills | reference | Borrow plan/implement/validate and validation-gate ideas only |

## 5. Relationship with Surge

`ai_best_practices` should be positioned as a **content source that Surge aggregates**, not as a competitor to Surge.

Division of responsibility:

- `ai_best_practices`: canonical Drupal-wide skill content
- `surge`: install, aggregate, compose `AGENTS.md`, and bridge into project/tool layouts

That separation is healthy. It avoids duplicating installer logic and lets `ai_best_practices` stay tool-neutral.

## 6. Migration / compatibility story

- **Current `ai_skills` users**: move directly to `ai_best_practices`; the old project is already unsupported and points here.
- **Surge users**: keep Surge; switch its configured source set to include `ai_best_practices` as the canonical Drupal package.
- **Users of standalone skill repos**: publish a mapping table from old skill names to new gerund-style names.
- **Users of workflow-heavy repos**: keep those repos for agents/hooks/evals, but gradually replace duplicated content with references to `ai_best_practices`.
- **Contrib/module authors**: if they ship domain-specific skills later, they should complement this package, not fork the universal baseline.

Practical compatibility step:

- For the first release wave, document old-to-new naming mappings prominently in `README.md` and `AGENTS.md`.

## 7. Open questions

- Which 5-8 skills should ship first in the canonical set?
- Do we want a small optional eval fixture set in-repo, or keep evals entirely external for now?
- Do we provide temporary compatibility aliases for legacy skill names, or only documentation?
- Where should version-specific guidance split into separate skills versus stay in one skill with `drupal-version` metadata?
- What is the minimum review bar for promoting a skill from `draft` to `stable`?

## 8. Out of scope

- Building another installer, plugin marketplace, or aggregator
- Encoding project-specific local-environment automation as universal guidance
- Reproducing full agent systems, hooks, or CI frameworks from workflow repos
- Covering the Drupal AI module ecosystem for building AI-powered sites
- Solving every specialized domain at once, especially Canvas-only or agency-specific workflows

## Recommended next move

Open a tracking issue for the first consolidation wave with five targets:

1. coding standards
2. testing
3. contribution workflow
4. DDEV/Drush/tooling
5. security

Those are the most duplicated topics in the current landscape and give the fastest path to visible convergence.
