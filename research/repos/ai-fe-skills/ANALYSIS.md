# Analysis: ai-fe-skills

1. **What problem does it solve?**  
This repo packages cross-agent frontend skills, currently centered on a Drupal-specific workflow for turning Figma designs into Drupal Canvas + SDC components. `README.md` frames it as reusable skills for Claude Code, Codex, Gemini CLI, Cursor, Windsurf, and others, while `drupal-figma-to-canvas-sdc/SKILL.md` defines a three-phase plan-implement-validate workflow with project context files, anti-pattern checks, and validation scripts.

2. **Primary artefact type**  
Skill plus validation script. The main artefacts are `drupal-figma-to-canvas-sdc/SKILL.md`, the references under `drupal-figma-to-canvas-sdc/references/`, the assets under `drupal-figma-to-canvas-sdc/assets/`, and `drupal-figma-to-canvas-sdc/scripts/validate-antipatterns.sh`.

3. **Distribution model**  
Standalone GitHub repo distributed by cloning and copying the skill folder into a local skills directory, according to `README.md`. It is not a Drupal module or Composer package.

4. **Standards conformance**  
Moderate to high. `README.md` explicitly says the skill uses cross-compatible `SKILL.md` files for Claude Code, Codex, Gemini CLI, Cursor, Windsurf, and others. The repo does not use root `skills/`, but the individual skill folder structure is close to agentskills.io practice and far more multi-tool aware than most Claude-specific repos.

7. **Coverage**  
- Figma-to-Drupal Canvas SDC component generation workflow: `drupal-figma-to-canvas-sdc/SKILL.md`  
- Planning phase and component-spec generation: `drupal-figma-to-canvas-sdc/references/planning.md`, `drupal-figma-to-canvas-sdc/assets/component-plan.md`  
- Implementation phase for `.component.yml`, `.twig`, `.pcss`, and `.src.js`: `drupal-figma-to-canvas-sdc/SKILL.md`, `drupal-figma-to-canvas-sdc/references/implementation.md`  
- Validation, build/lint, anti-pattern checks, and Drupal component validation: `drupal-figma-to-canvas-sdc/references/validation.md`, `drupal-figma-to-canvas-sdc/scripts/validate-antipatterns.sh`  
- Project-specific context templating and worked example: `drupal-figma-to-canvas-sdc/project-context.example.md`, `drupal-figma-to-canvas-sdc/assets/worked-example.md`

8. **Quality signals**  
- Last commit date: `INDEX.md` records `2026-03-04 15:20:30 +0200`.  
- Issue count: `REPO_METADATA.md` records 0 open issues.  
- Stars/watchers: `REPO_METADATA.md` records 0 stars and 0 watchers.  
- Tests/evals: no formal CI or test harness is visible, but the validation layer is substantial in `drupal-figma-to-canvas-sdc/references/validation.md` and `scripts/validate-antipatterns.sh`.  
- Maintainer signal: recent but very early-stage; the repo was created and last pushed on the same day per `REPO_METADATA.md`.

11. **Compatibility with ai_best_practices' decisions**  
Moderate. The multi-tool `SKILL.md` mindset aligns well with ai_best_practices, but the repo is narrowly focused on a Figma-to-Canvas-SDC workflow rather than universal Drupal guidance, and it does not use root `skills/`. If anything is merged, it would be the plan/implement/validate and validation-gate ideas, not the exact folder or task scope.

13. **One-paragraph verdict**  
**Reference**. `ai-fe-skills` is valuable specialized prior art for a disciplined three-phase generation-and-validation workflow, especially in `drupal-figma-to-canvas-sdc/SKILL.md` and `drupal-figma-to-canvas-sdc/references/validation.md`, but it is too narrow and frontend-specific to absorb into the core ai_best_practices library. It should influence workflow and validation design rather than become part of the main content set.
