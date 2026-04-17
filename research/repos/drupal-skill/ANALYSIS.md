# Analysis: drupal-skill

1. **What problem does it solve?**
According to the `README.md`, this repository provides "Comprehensive Drupal development skills for Claude Code, organized by specialization." It solves the problem of equipping Claude Code with specialized context and instructions for working on Drupal 8-11+ projects by breaking down the knowledge into frontend, backend, and tooling domains.

2. **Primary artefact type**:
Skills (specifically designed as Claude Code plugins). The repository provides three distinct skills (`drupal-frontend`, `drupal-backend`, and `drupal-tooling`) along with accompanying reference documentation.

3. **Distribution model**:
Claude Code plugin marketplace. It is distributed and installed via Claude Code's built-in plugin mechanism using commands like `/plugin marketplace add Omedia/drupal-skill` and `/plugin install drupal-frontend` (as documented in `README.md` and configured in `.claude-plugin/marketplace.json`).

4. **Standards conformance**:
It uses a proprietary/tool-specific format tailored exclusively for Claude Code. It relies on a `.claude-plugin/marketplace.json` index and its `SKILL.md` files (e.g., `drupal-backend/SKILL.md`) use a custom YAML frontmatter for Claude Code metadata (`name` and `description`). It does not conform to the agentskills.io standard and lacks an `AGENTS.md` file (as noted in `INDEX.md`). It is strictly single-tool compatible (Claude Code).

7. **Coverage**:
- Theme structure, Twig syntax, preprocessing: `drupal-frontend/SKILL.md` and `drupal-frontend/references/theming.md`
- Hooks system and module structure: `drupal-backend/SKILL.md`, `drupal-backend/references/hooks.md`, and `drupal-backend/references/module_structure.md`
- Controllers, Forms API, Entity API, Plugin system, Services/DI: `drupal-backend/SKILL.md`
- DDEV environments: `drupal-tooling/SKILL.md` and `drupal-tooling/references/ddev.md`
- Drush commands: `drupal-tooling/SKILL.md` and `drupal-tooling/references/drush.md`

8. **Quality signals**:
- Last commit date: 2025-10-19 (noted from `git log -1`, likely a typo in the author's local git setup or from an auto-generated repo).
- Issue count, stars/watchers: N/A (local git repository with no remote tracked).
- Tests: None found.
- Eval harness: None found.
- CI: None found (no `.github` or similar CI directory).
- Versioning discipline: Minimal (only 1 commit in history, though `.claude-plugin/marketplace.json` defines version `1.0.0`).
- Active maintainer: Unknown (single commit history).

11. **Compatibility with ai_best_practices' decisions**:
The directory structure and metadata are incompatible. It uses a `.claude-plugin/marketplace.json` directory for registration rather than `AGENTS.md` or a standard `.claude/skills` / `.cursor/rules` structure. The `SKILL.md` files are nested in custom folders (`drupal-backend/`, etc.) instead of a unified `skills/` directory. To merge this in, the directory structure would need to be flattened, the `.claude-plugin/marketplace.json` removed, and the `SKILL.md` files refactored to remove the Claude-specific YAML frontmatter and align with our chosen standard (e.g., `agentskills.io`).

13. **One-paragraph verdict**:
**Absorb**. While the packaging mechanism (Claude Code marketplace plugin) is proprietary and incompatible with our broader multi-tool strategy, the underlying reference materials (e.g., `drupal-backend/references/hooks.md`, `drupal-frontend/references/theming.md`) are highly valuable and well-organized domain knowledge for Drupal. We should absorb these markdown reference documents into our prompt library or reference architecture, and rewrite the core instructions from the three `SKILL.md` files into our standard, tool-agnostic format, discarding the Claude-specific plugin wrapper.