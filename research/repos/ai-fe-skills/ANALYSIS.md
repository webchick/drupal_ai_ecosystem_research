1. **What problem does it solve?**
The repository provides "Agent skills for frontend development — Drupal, AEM, performance optimization." It offers reusable workflows to "Build production-ready Drupal SDC components from Figma designs" using a "Three-phase Plan-Implement-Validate workflow for Canvas + SDC + Tailwind CSS projects" (`README.md`).

2. **Primary artefact type**
skills. The repository currently contains a single skill housed in the `drupal-figma-to-canvas-sdc/` directory, defined by `drupal-figma-to-canvas-sdc/SKILL.md` (`INDEX.md`).

3. **Distribution model**
standalone git repo. Users are instructed to install it via `git clone`, directly copying the files into their global or project-level skills directories (e.g., `git clone https://github.com/aldunchev/ai-fe-skills.git ~/.claude/skills/ai-fe-skills`) (`README.md`).

4. **Standards conformance**
It uses the standard Agent Skills format, utilizing a `SKILL.md` file with YAML frontmatter (`drupal-figma-to-canvas-sdc/SKILL.md`). It is designed to be multi-tool compatible, explicitly stating it works across "Claude Code, Codex, Gemini CLI, Cursor, Windsurf, and others" (`README.md`).

7. **Coverage**
- Single Directory Components (SDC): `drupal-figma-to-canvas-sdc/SKILL.md`, `drupal-figma-to-canvas-sdc/references/implementation.md`
- Frontend development (Tailwind CSS, Canvas): `drupal-figma-to-canvas-sdc/SKILL.md`, `drupal-figma-to-canvas-sdc/references/planning.md`

8. **Quality signals**
- Last commit date: 2026-03-04 (`INDEX.md`).
- Tests: No automated testing framework is present, though a validation script is provided at `drupal-figma-to-canvas-sdc/scripts/validate-antipatterns.sh` (`INDEX.md`).
- Issue count, stars/watchers, eval harness, CI, versioning discipline: N/A (No evidence of these practices in the repository).
- Active maintainer: The commit date suggests recent activity, but without issue tracker data, it is hard to assess active maintenance beyond code pushes.

11. **Compatibility with ai_best_practices' decisions**
- Naming convention: The skill directory `drupal-figma-to-canvas-sdc/` uses a descriptive, kebab-case naming convention (`INDEX.md`).
- Directory: The `README.md` documents a `skills/` wrapper directory structure, but the actual file tree shows the skill directory sitting at the repository root (`./drupal-figma-to-canvas-sdc/`) (`INDEX.md`). To merge it, the skill folder would need to be moved into a standard `skills/` directory.
- Metadata: It correctly uses `SKILL.md` (`drupal-figma-to-canvas-sdc/SKILL.md`).
- Scope: Highly targeted at a specific frontend tech stack (Figma, Canvas, SDC, Tailwind).

13. **One-paragraph verdict**
`ai_best_practices` should **absorb** this repository. It consists of a single, well-structured skill for converting Figma designs into Drupal SDCs using modern tooling (Canvas and Tailwind). Because it already adheres to the `SKILL.md` standard and is built for multi-agent compatibility, its contents (`drupal-figma-to-canvas-sdc/` and its supporting references and scripts) can be directly copied into a broader, centralized skills repository with minimal refactoring.
