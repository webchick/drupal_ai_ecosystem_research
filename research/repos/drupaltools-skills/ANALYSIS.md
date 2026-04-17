# Analysis: drupaltools-skills

1. **What problem does it solve?**
The repository provides "A collection of AI Skills for Drupal development." (`README.md`). It aims to equip AI agents and CLI tools like Claude Code with specific, context-aware capabilities and instructions to assist developers with Drupal tasks, ranging from code auditing to module scaffolding and migration planning.

2. **Primary artefact type**:
Skills and Agents. The repository contains 27 skills located in the `skills/` directory and 10 agent personas located in the `agents/` directory (`INDEX.md`, `README.md`).

3. **Distribution model**:
It relies on a standalone git repo and an npm-based aggregator model. Users can install individual skills via the `skills.sh` registry (`npx skills add https://github.com/drupaltools/skills`) or clone the entire repository directly into their local AI configuration directories (`git clone ... ~/.claude/skills/drupaltools-skills` or `~/.agents/skills/drupaltools-skills`) (`README.md`).

4. **Standards conformance**:
It follows the standard `SKILL.md` format for its skills (`skills/drupaltools-best-practices/SKILL.md`). It is multi-tool compatible, explicitly supporting Claude Code and general agents (`~/.agents/skills`). It does not use an `AGENTS.md` file (`INDEX.md`), and its agent files use a proprietary Markdown format with YAML frontmatter (e.g., `name`, `description`, `color`, `temperature` in `agents/drupal-backend-dev.md`).

5. **Architectural pattern**:
The architecture is a flat skill dump combined with selective load. Users or tools either clone the entire repository or selectively pull specific skills via `npx skills`. There is no central routing layer, semantic index, or `skills.yaml` manifest (`INDEX.md`).

6. **Naming convention**:
It diverges from the `ai_best_practices` gerund-prefix convention. Skills use a `namespace-noun` or `namespace-verb-noun` format (e.g., `drupaltools-best-practices`, `drupaltools-module-clone`, `drupaltools-git-blame`). Agents use a `namespace-role` format (e.g., `drupal-backend-dev`, `drupal-security-engineer`).

7. **Coverage**:
- **Coding Standards**: `skills/drupaltools-coding-standards/SKILL.md`, `skills/drupaltools-best-practices/SKILL.md`
- **Performance**: `agents/drupal-performance-engineer.md`, `skills/drupaltools-optimize/SKILL.md`
- **Security**: `agents/drupal-security-engineer.md`
- **Custom Modules & OOP**: `skills/drupaltools-oop-hooks/SKILL.md`, `skills/drupaltools-module-clone/SKILL.md`
- **CI/CD**: `skills/drupaltools-contrib-gitlab-ci/SKILL.md`
- **Architecture**: `agents/drupal-tech-lead.md`, `agents/drupal-content-architect.md`
- **Migrations**: `skills/drupaltools-migration-plan/SKILL.md`, `agents/drupal-code-archaeologist.md`
- **Translations**: `skills/drupaltools-translations/SKILL.md`
- **Frontend**: `agents/drupal-frontend-dev.md`

8. **Quality signals**:
The repository is active (last commit: `2026-04-16 10:00:03 +0300` via `git log`). It has a GitHub Actions workflow configured (`.github/workflows/opencode.yml`). It lacks an explicit test suite or evaluation harness (`INDEX.md` shows no `tests/` or `evals/` directories), but it maintains a clear directory structure and comprehensive README.

9. **Notable innovations**:
The repository embeds executable Python scripts directly alongside the markdown skills to give the AI agent actual CLI tools rather than just prompt instructions. Examples include `dsearch.py` (`skills/drupaltools-code-search/dsearch.py`), `csearch.py` (`skills/drupaltools-contrib-search/csearch.py`), and `fetch-blame.py` (`skills/drupaltools-git-blame/fetch-blame.py`). This is a novel approach compared to purely text-based skill repositories.

10. **Weaknesses / gaps**:
The repository relies heavily on the `drupaltools-` prefix for skill names, which is verbose. It lacks a unified manifest like `AGENTS.md` or `skills.yaml`, making programmatic discovery more difficult. Furthermore, while it ships Python scripts, there is no global `requirements.txt` or clear dependency management for these scripts (`INDEX.md`), which could lead to runtime failures if the environment lacks necessary packages.

11. **Compatibility with ai_best_practices' decisions**:
The repository's naming conventions (`drupaltools-noun`) directly conflict with the `ai_best_practices` gerund preference. To merge it in, skills would need to be renamed (e.g., `drupaltools-module-clone` to `cloning-modules`). The directory structure (`skills/[name]/SKILL.md`) is compatible, but the `agents/` directory introduces a custom format that would need to be evaluated against the project's agent standards.

12. **Relationship to Surge**:
Surge is listed in the `README.md` under "Similar tools" as a "Drupal module with AI-assisted development tools." Surge is a Drupal module that likely operates within the Drupal runtime, whereas `drupaltools-skills` provides external CLI/agent skills. Surge could potentially aggregate or integrate these skills, but they currently represent parallel ecosystems with no direct conflict.

13. **One-paragraph verdict**:
`ai_best_practices` should **absorb** the innovative executable tool patterns (e.g., the embedded Python scripts for searching and blame) and **reference** the broader repository as a comprehensive library of Drupal personas and instructions. The naming conventions and flat structure do not align perfectly with the target standards, so a direct, wholesale merge would introduce inconsistency, but the high-value, tool-augmented skills should be adapted and brought in.