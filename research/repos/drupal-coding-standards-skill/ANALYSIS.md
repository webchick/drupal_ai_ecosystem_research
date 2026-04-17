# Analysis of drupal-coding-standards-skill

1. **What problem does it solve?**
It provides an "Agent Skill that provides AI agents with the ability to review code according to Drupal's official coding standards" (`README.md`). By using a dynamic context discovery mechanism, it efficiently loads "only the relevant standards based on the file type being reviewed," preventing the agent's context window from being flooded with irrelevant guidelines (`README.md`).

2. **Primary artefact type**:
An Agent Skill (`README.md`, `.claude/skills/drupal-coding-standards/SKILL.md`). The author describes it specifically as a "routing layer over the official Drupal coding standards" (`README.md`).

3. **Distribution model**:
A Composer package installed via `composer require ronaldtebrake/drupal-coding-standards-skill --dev` (`README.md`, `composer.json`). The assets are scaffolded into `.claude/skills/drupal-coding-standards/` and the user is instructed to manually copy them or use `drupal/surge` to aggregate them (`README.md`). It relies on `drupal/coding_standards` as a Composer dependency (`composer.json`).

4. **Standards conformance**:
It conforms to the Agent Skills format using `SKILL.md` (`README.md`, `.claude/skills/drupal-coding-standards/SKILL.md`). It also includes an `AGENTS.md` file for project-level compatibility (`README.md`, `AGENTS.md`). It is multi-tool compatible via the open agentskills.io format, although the default directory structure (`.claude/skills/`) is geared toward Claude (`AGENTS.md`).

7. **Coverage**:
- PHP (`.claude/skills/drupal-coding-standards/standards-index.md`)
- JavaScript (`.claude/skills/drupal-coding-standards/standards-index.md`)
- CSS (`.claude/skills/drupal-coding-standards/standards-index.md`)
- Twig (`.claude/skills/drupal-coding-standards/standards-index.md`)
- YAML (`.claude/skills/drupal-coding-standards/standards-index.md`)
- SQL (`.claude/skills/drupal-coding-standards/standards-index.md`)
- Markup/HTML (`.claude/skills/drupal-coding-standards/standards-index.md`)
- Composer package naming (`.claude/skills/drupal-coding-standards/standards-index.md`)
- Accessibility (`.claude/skills/drupal-coding-standards/standards-index.md`)
- Spelling (`.claude/skills/drupal-coding-standards/standards-index.md`)

8. **Quality signals**:
Abandoned / Unmaintained (`README.md` explicitly states "# Unmaintained" and redirects users to `ai_best_practices`). The last commit is dated `2026-04-06` (likely a typo by the author when marking it abandoned) (`INDEX.md`). There are no tests, no CI, and no eval harness present in the repository. Due to its abandoned state, the rest of the signals are de-emphasised.

11. **Compatibility with ai_best_practices' decisions**:
The repository uses the `.claude/skills/drupal-coding-standards` directory convention (`AGENTS.md`), which would need adjusting to match `ai_best_practices`'s directory structure. Its metadata approach (`SKILL.md` and `AGENTS.md`) is standards-compliant but relies on pulling official docs via Composer. To merge it in, the dynamic routing logic (`.claude/skills/drupal-coding-standards/standards-index.md`) would need to be adapted to the `ai_best_practices` architecture, and the dependency on `drupal/coding_standards` would need to be evaluated against `ai_best_practices`'s own distribution model.

13. **One-paragraph verdict**:
**Absorb**. The author explicitly states in `README.md` that they have abandoned this project to focus their efforts on `ai_best_practices`. The core innovation here—a dynamic routing table (`.claude/skills/drupal-coding-standards/standards-index.md`) that maps file extensions to specific Drupal coding standards to save context window space—is highly valuable. `ai_best_practices` should pull this routing concept and the standard-loading mechanism directly into its own offering.