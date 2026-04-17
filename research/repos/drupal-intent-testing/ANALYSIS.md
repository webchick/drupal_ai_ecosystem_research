# Analysis: drupal-intent-testing

1. **What problem does it solve?**  
This repo adds an "intent testing" skill for UI-first verification: instead of checking only whether code runs, it uses `agent-browser` to drive a real browser and validate whether the user-facing workflow actually makes sense. `README.md` explicitly positions it as complementary to PHPUnit/Kernel/FunctionalJavascript tests, with templates for content-authoring and Canvas-style configuration-to-UI propagation checks.

2. **Primary artefact type**  
Skill plus test harness. The core entry point is the root `SKILL.md`, but the repo also includes Python runner/collector scripts under `scripts/` and a real automated test suite under `tests/`.

3. **Distribution model**  
Standalone GitHub repo used as an installable skill plus a Python toolchain. `README.md` shows usage through `agent-run skills/basic_content.agent` and references `agent-browser`; `requirements.txt` supplies Python dependencies.

4. **Standards conformance**  
Partial. It uses `SKILL.md` plus references/scripts, which is close to agentskills.io structure, but the repo is organized around a root skill and scenario harness rather than a root `skills/<name>/SKILL.md` library. It is also runtime-specific to `agent-browser` per `README.md`.

7. **Coverage**  
- UI-first exploratory verification: `SKILL.md`, `README.md`  
- Content creation / writer workflow: `scripts/test_scenarios/basic_content_creation.txt`  
- Canvas or backend-config-to-frontend propagation: `scripts/test_scenarios/canvas_ai_context_label.txt`, `README.md`  
- Baseline-vs-modified comparison: `scripts/compare_runs.py`  
- Intent manifests and validation: `scripts/intent/manifest.py`, `scripts/intent/validate_manifest.py`  
- Evidence collection and judging: `scripts/collectors.py`, `scripts/judge_intent.py`  
- Drupal-specific testing patterns: `references/drupal_patterns.md`

8. **Quality signals**  
- Last commit date: `INDEX.md` records `2026-02-02 15:22:26 -0500`.  
- Issue count: `REPO_METADATA.md` records 1 open issue.  
- Stars/watchers: `REPO_METADATA.md` records 5 stars and 0 watchers.  
- Tests: strong for a Tier 2 repo; `tests/test_collectors.py`, `tests/test_compare_runs.py`, `tests/test_intent_manifest.py`, `tests/test_intent_test.py`, and `tests/test_judge_intent.py` are present.  
- Eval harness: not a formal eval directory, but the whole repo is effectively a verification harness via `scripts/compare_runs.py` and scenario files.  
- CI: not locally verified; no workflow file is visible in the depth-3 tree.  
- Versioning discipline: lightweight; no changelog/release files are visible in the scanned tree.  
- Active maintainer signal: recent enough, but the commit history is short and adoption modest.

11. **Compatibility with ai_best_practices' decisions**  
Low to moderate. The guidance is useful, but this is not a universal best-practices skill in the chosen packaging structure; it is a specialized testing harness. To merge cleanly, its skill would need to be repackaged under `skills/` and renamed to a gerund form, but the bigger value probably lies in borrowing ideas for an optional verification/eval layer rather than absorbing the whole repo.

13. **One-paragraph verdict**  
**Reference**. `drupal-intent-testing` is valuable specialized prior art for browser-driven, agent-authored verification and could heavily inform ai_best_practices' testing/evals direction, but it is too runtime-specific and harness-oriented to be folded wholesale into the main Drupal best-practices skill library.
