# Analysis: drupal-workflow

1. **What problem does it solve?**  
`drupal-workflow` tries to turn Claude Code into a Drupal-native workflow engine rather than just a bag of reference skills. `README.md` describes a plugin with skills, agents, commands, behavioral evals, session analysis, semantic documentation, and a "Magic Loop Autopilot" that classifies tasks, monitors drift, and nudges or suppresses behavior during a live session.

2. **Primary artefact type**  
Plugin platform combining skills, agents, commands, hooks, evals, and docs. The evidence is spread across `skills/*/SKILL.md`, `agents/*.md`, `commands/*.md`, `hooks/hooks.json`, `eval/*`, and `.claude-plugin/plugin.json`.

3. **Distribution model**  
Claude Code plugin first. `README.md` installs it with `claude --plugin-dir ./drupal-workflow`; `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json` confirm plugin packaging. The npm package path in `README.md` is explicitly future-facing, not the primary current install route.

4. **Standards conformance**  
Mixed. The skill layer is strongly aligned with agentskills.io, with `SKILL.md` files and rich metadata such as in `skills/structural-index/SKILL.md`. The plugin also uses `CLAUDE.md` and a Claude-specific plugin manifest in `.claude-plugin/plugin.json`, plus hook definitions in `hooks/hooks.json`, so the overall system is single-tool shaped even if parts are portable.

5. **Architectural pattern**  
The most opinionated architecture in the set: a three-layer deterministic-then-semantic system plus live policy enforcement. `README.md` explicitly defines Layer 1 raw codebase, Layer 2 structural index, and Layer 3 semantic docs; `skills/structural-index/SKILL.md` explains the structural middle layer; `hooks/hooks.json` and `scripts/autopilot-monitor.sh` implement the runtime autopilot that classifies tasks and intervenes during sessions. This is not a flat skill library.

6. **Naming convention**  
Mixed and inconsistent with ai_best_practices. Many skills are noun/topic names with a `drupal-` prefix (`drupal-testing`, `drupal-entity-api`, `drupal-caching`), some are bare nouns (`discover`, `structural-index`), and a few are gerund-ish (`writing-plans`) but not consistently adopted. The naming is clearer than random topic names, but it still diverges from the agreed gerund-prefix convention.

7. **Coverage**  
- Brainstorming / planning: `skills/drupal-brainstorming/SKILL.md`, `skills/writing-plans/SKILL.md`  
- Delegation and sub-agent orchestration: `skills/drupal-delegation/SKILL.md`  
- Core Drupal rules: `skills/drupal-rules/SKILL.md`  
- Testing and verification: `skills/drupal-testing/SKILL.md`, `skills/verification-before-completion/SKILL.md`, `commands/drupal-test.md`, `commands/drupal-verify.md`, `agents/drupal-verifier.md`  
- Service DI: `skills/drupal-service-di/SKILL.md`  
- Entity API: `skills/drupal-entity-api/SKILL.md`  
- Caching: `skills/drupal-caching/SKILL.md`  
- Hook patterns: `skills/drupal-hook-patterns/SKILL.md`  
- Security: `skills/drupal-security-patterns/SKILL.md`  
- Coding standards: `skills/drupal-coding-standards/SKILL.md`  
- Config management: `skills/drupal-config-management/SKILL.md`  
- Twig/theming: `skills/twig-templating/SKILL.md`  
- Structural indexing and blast radius: `skills/structural-index/SKILL.md`, `commands/drupal-blast-radius.md`  
- Semantic docs/business mapping: `skills/semantic-docs/SKILL.md`, `commands/drupal-semantic.md`, `agents/semantic-architect.md`  
- Hook/policy enforcement: `hooks/hooks.json`, `scripts/autopilot-monitor.sh`, `scripts/task-classifier.sh`

8. **Quality signals**  
- Last commit date: `INDEX.md` records `2026-04-15 14:03:05 +0200`.  
- Issue count: `REPO_METADATA.md` records 0 open issues.  
- Stars/watchers: `REPO_METADATA.md` records 12 stars and 0 watchers.  
- Tests: substantial nontrivial verification exists in `eval/*` and `scripts/tests/test-autopilot-phase2.sh`.  
- Eval harness: yes; `README.md` advertises behavioral evals and `eval/evals/eval.json`, `eval/eval-skills.py`, `eval/eval-semantic-docs.py`, and related files confirm it.  
- CI: no dedicated GitHub workflow is visible in the depth-3 `INDEX.md`, so automated CI is not locally verified.  
- Versioning discipline: good; `.claude-plugin/plugin.json` pins version `2.0.1`, and `CHANGELOG.md` is present.  
- Active maintainer signal: recent push and update timestamps in `REPO_METADATA.md`, plus extensive recent docs/eval additions in the repo tree.

9. **Notable innovations**  
Two stand out. First, the three-layer workflow from `README.md` and `skills/structural-index/SKILL.md` is the clearest deterministic-to-semantic architecture in the landscape. Second, `hooks/hooks.json` plus the autopilot scripts create a live governance layer that scores drift and escalates interventions during a session, which is more ambitious than simple post-edit lint hooks.

10. **Weaknesses / gaps**  
It is highly Claude-plugin-specific and arguably over-engineered for a shared Drupal best-practices library. The reliance on `.claude-plugin/*`, `CLAUDE.md`, hook JSON, and session-monitor scripts makes portability weaker than the raw skill count suggests. It also includes metadata like `last-reviewed` in `skills/structural-index/SKILL.md`, which conflicts with ai_best_practices' decision to avoid that field.

11. **Compatibility with ai_best_practices' decisions**  
Partially compatible at the content layer, weak at the platform layer. The `skills/` directory is already correct, but names would need conversion to gerunds and frontmatter would need trimming down to minimal metadata. The best compatible pieces are the actual Drupal skill content and the eval ideas; the plugin/hook/autopilot framework should remain external.

12. **Relationship to Surge**  
Surge could potentially aggregate the `skills/` subtree, but the repo's real differentiation is outside Surge's scope: hooks, commands, live autopilot, and semantic-docs workflows. There is no direct conflict; they solve different layers of the stack.

13. **One-paragraph verdict**  
**Reference** and selectively **absorb**. `drupal-workflow` is too tool-specific and too behaviorally opinionated to become the canonical ai_best_practices structure, but it is one of the richest sources for best-in-class ideas: the structural-index skill, the layered docs model, and the eval harness are all strong candidates to borrow. Treat the plugin/autopilot shell as external inspiration, while extracting the most portable Drupal guidance and evaluation patterns.
