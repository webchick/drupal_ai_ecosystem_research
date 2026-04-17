# Analysis of drupal-agentic-workflow

1. **What problem does it solve?** 
It aims to "Turn Claude Code into a Drupal-native development partner with 20 AI-powered skills, automated code quality hooks, and security scanning" (`README.md`). It addresses issues such as AI generating code with coding standard violations, lack of protection against destructive commands, generic responses about Drupal, and manual code quality checks (`README.md`).

2. **Primary artefact type**:
It is a collection of Claude Code **skills** and **hooks**, bundled with a setup shell script (`bin/setup.sh`) that installs them directly into a project's local `.claude/` directory (`README.md`, `INDEX.md`).

3. **Distribution model**:
It is a **standalone git repo**. It is installed manually by cloning the repository (`git clone <repo-url> ~/drupal-agentic-workflow`) and then executing its setup script (`~/drupal-agentic-workflow/bin/setup.sh .`) inside a Drupal project directory (`README.md`).

4. **Standards conformance**:
It is completely **single-tool** locked. It uses Claude Code's native proprietary format, storing markdown files in `.claude/skills/{name}/SKILL.md` (`README.md`). It does not use `AGENTS.md` or the agentskills.io format (`INDEX.md`).

5. **Architectural pattern**:
It uses a **native skills-manifest** pattern via Claude Code's built-in routing. Skills are injected into the context selectively when invoked by the user via slash commands (e.g., `/drupal-expert`) (`README.md`). Furthermore, it employs an event-driven **hooks architecture** for validation: a `PreToolUse` hook (`pre-bash-guard.sh`) and a `PostToolUse` hook (`post-generation-lint.sh`) run deterministically to validate or modify Claude's output before returning control to the user. It also provides opt-in git context injection via a `UserPromptSubmit` hook (`prompt-context.sh`) (`README.md`).

6. **Naming convention**:
It uses a mix of hyphenated nouns (e.g., `drupal-expert`, `config-management`), verbs (e.g., `generate-tests`, `update-module`), and single nouns (e.g., `accessibility`, `api`) (`INDEX.md`). This **diverges** from the `ai_best_practices` gerund-prefix choice.

7. **Coverage**:
- Drupal development knowledge base: `.claude/skills/drupal-expert/SKILL.md`
- Code scaffolding (modules, services, forms, etc.): `.claude/skills/scaffold/SKILL.md`
- Architectural code reviews: `.claude/skills/code-review/SKILL.md`
- PHPUnit test generation: `.claude/skills/generate-tests/SKILL.md`
- Troubleshooting/debugging: `.claude/skills/debug/SKILL.md`
- DDEV management: `.claude/skills/ddev/SKILL.md`
- Migration management: `.claude/skills/migrate/SKILL.md`
- DDEV Solr configuration: `.claude/skills/solr-setup/SKILL.md`
- Frontend (Twig, SDC, theming): `.claude/skills/drupal-frontend-expert/SKILL.md`
- Site building (Views, Config): `.claude/skills/drupal-site-builder-expert/SKILL.md`
- Security: `.claude/skills/drupal-security/SKILL.md`
- Contrib module updates: `.claude/skills/update-module/SKILL.md`
- Config management (Export/Import, Recipes): `.claude/skills/config-management/SKILL.md`
- Performance (Caching, queries): `.claude/skills/performance/SKILL.md`
- Drush CLI: `.claude/skills/drush/SKILL.md`
- Refactoring guidance: `.claude/skills/refactor/SKILL.md`
- Diagnostic health check: `.claude/skills/doctor/SKILL.md`
- Accessibility (WCAG 2.2): `.claude/skills/accessibility/SKILL.md`
- API (REST, JSON:API, GraphQL): `.claude/skills/api/SKILL.md`
- Custom entity types: `.claude/skills/entity/SKILL.md`

8. **Quality signals**:
- **Last commit date**: 2026-03-12 (Note: This is a future-dated commit in the repository) (`INDEX.md`)
- **CI**: Absent (`INDEX.md`)
- **Tests**: Absent (No test framework for testing the skills themselves) (`INDEX.md`)
- **Eval harness**: Absent (`INDEX.md`)
- **Versioning**: Absent (No `composer.json` or `package.json` for formal releases) (`INDEX.md`)
- *(Issue count and stars/watchers are not applicable/available in the local codebase context).*

9. **Notable innovations**:
The use of **Claude Code event hooks** for autonomous agentic feedback loops is novel. Specifically, the `post-generation-lint.sh` script runs `phpcbf` to auto-fix code, `phpcs` to lint, and uses a custom "security-perf-scan". If errors occur, it exits with a status code of 2, ensuring that "Claude sees feedback and auto-corrects" autonomously before the user reviews the output (`README.md`, `.claude/hooks/post-generation-lint.sh`).

10. **Weaknesses / gaps**:
- **Single-tool lock-in**: Entirely dependent on Claude Code's proprietary `.claude/` folder architecture and hooks API (`README.md`).
- **Installation friction**: Requires a manual `git clone` and running a bash `setup.sh` script to copy files per project, bypassing ecosystem package managers entirely (`README.md`).
- **Missing standardisation**: It does not conform to tool-agnostic standards like `AGENTS.md` or a unified skills registry (`INDEX.md`).

11. **Compatibility with ai_best_practices' decisions**:
- **Naming convention**: Incompatible. Uses hyphens and verbs instead of the gerund-prefix standard.
- **Directory structure**: Incompatible. Skills are stored under `.claude/skills/` instead of an agnostic `skills/` directory (`INDEX.md`).
- **Metadata**: Incompatible. Lacks `AGENTS.md` or tool-agnostic manifests.
- **What needs to change**: The instructional content in the `SKILL.md` files would need to be extracted, renamed to gerund-prefixed folders, and made tool-agnostic. The custom bash hooks (`.claude/hooks/`) would need to be re-implemented as generic pre-commit hooks or CI workflows.

12. **Relationship to Surge**:
Surge does not currently aggregate this, largely due to its custom structure. Surge could theoretically aggregate the core knowledge embedded in these skills if they were reformatted, but the bash hooks heavily rely on Claude Code's execution environment. The conflict lies in its rigid Claude-specific directory structure and non-standard distribution method.

13. **One-paragraph verdict**:
**Absorb**. The repository contains a wealth of granular, well-scoped Drupal AI instructions (20 distinct skills) and innovative ideas for closed-loop tool validation (the autonomous auto-linting feedback loop). However, because of its heavy single-tool lock-in with Claude Code and lack of standardised distribution, the best path forward is to extract (absorb) the core knowledge context from its `SKILL.md` files, translate them into the `ai_best_practices` gerund format, and adapt its concepts for post-generation linting into more generic, tool-agnostic agentic workflows.