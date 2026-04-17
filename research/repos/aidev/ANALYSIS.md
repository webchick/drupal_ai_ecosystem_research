# Analysis: aidev

1. **What problem does it solve?**  
aidev predates the current Agent Skills wave and tries to help developers "build Drupal systems using natural language" by exposing an API that gathers and preprocesses source code so it can be handed to an AI assistant. `README.md` describes source gathering and preprocessing as the main feature, and `src/Source.php` implements that by collecting project files, applying modifiers, and computing token-ish statistics.

2. **Primary artefact type**  
Drupal contrib module / source-gathering API. The repo contains a standard module scaffold in `aidev.info.yml`, `aidev.services.yml`, and `composer.json`, not a skills library.

3. **Distribution model**  
Drupal contrib module installed with Composer. `REPO_METADATA.md` records the Drupal.org package and release, while `aidev.info.yml` and `composer.json` show standard module packaging.

4. **Standards conformance**  
None to current agent standards. `INDEX.md` shows no `SKILL.md`, no `skills/`, no `AGENTS.md`, and no `.claude/skills/`. The architecture is service/plugin based Drupal code, not agentskills.io-format content.

5. **Architectural pattern**  
Deterministic source-code harvesting plus pluggable preprocessing. `src/Source.php` walks directories, reads files, marks modifiers, applies modifier plugins, and calculates counts; `src/SourceModifierPluginManager.php` provides the plugin manager; `aidev.services.yml` registers the services. This is an ingestion/preprocessing layer, not a skill-routing layer.

6. **Naming convention**  
Not applicable for skills. The module and service naming are conventional Drupal nouns (`aidev.source_code`, `SourceModifierPluginManager` in `aidev.services.yml` and `src/SourceModifierPluginManager.php`), which diverges from ai_best_practices' gerund skill naming because this repo does not define skills.

7. **Coverage**  
- Source-code gathering for modules/themes/directories: `README.md`, `src/Source.php`  
- File inclusion/exclusion/mention modifiers: `README.md`, `src/Source.php`  
- Preprocessing via plugin manager: `src/SourceModifierPluginManager.php`, `src/Plugin/SourceModifierPluginBase.php`  
- Token/word/line/symbol counting for AI context sizing: `src/Source.php`

8. **Quality signals**  
- Last commit date: `INDEX.md` records `2024-04-01 13:50:10 +0300`, which is more than 12 months old and should be treated as abandoned by the rubric.  
- Issue count: `REPO_METADATA.md` records 8 listed issues on Drupal.org.  
- Stars/watchers: not applicable / not verified from local repo files.  
- Tests: none found; `INDEX.md` shows no `tests/` and no test configuration.  
- Eval harness: none found; no `evals/` in `INDEX.md`.  
- CI: none visible in the repo tree from `INDEX.md`.  
- Versioning discipline: weak; `REPO_METADATA.md` shows one alpha release and an old dev branch.  
- Active maintainer signal: weak; `REPO_METADATA.md` shows Drupal.org last updated 3 September 2023 and dev version updated 1 April 2024.

9. **Notable innovations**  
For its time, the modifier pipeline in `src/Source.php` and `src/SourceModifierPluginManager.php` is a pragmatic attempt to shrink and shape project code before sending it to an AI model. That preprocessing concern overlaps conceptually with later "progressive disclosure" ideas, but it is implemented as file rewriting rather than on-demand skill activation.

10. **Weaknesses / gaps**  
It is outdated, has no skills/AGENTS standard support, and appears frozen before the ecosystem converged on agentskills.io. `INDEX.md` and `REPO_METADATA.md` show stale activity, while the repo lacks reusable agent-facing guidance files entirely. It also focuses on source ingestion rather than Drupal cultural knowledge, contribution workflow, or best-practice content.

11. **Compatibility with ai_best_practices' decisions**  
Low. To merge into ai_best_practices it would need a fundamental rewrite from Drupal service code into portable `skills/` content with minimal metadata. The only reusable idea is the desire to preprocess context before model use, not the packaging or content structure.

12. **Relationship to Surge**  
No direct conflict. Surge aggregates skill directories; aidev is a Drupal module with no `skills/` tree, so Surge would not naturally consume it. At most, aidev is adjacent prior art for "prepare better AI context from a Drupal project."

13. **One-paragraph verdict**  
**Ignore**, except as historical background. aidev is useful evidence that Drupal developers were tackling AI-assisted development before the current skills ecosystem formed, but it is too old, too code-centric, and too far from the chosen `skills/` + gerund-named portable-content direction to be a serious merge candidate for ai_best_practices.
