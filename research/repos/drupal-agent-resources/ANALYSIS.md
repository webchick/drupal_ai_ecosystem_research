# Analysis of drupal-agent-resources

1. **What problem does it solve?**
The project aims to "set a high standard for how AI coding agents interact with Drupal, by encoding deep Drupal expertise into reusable resources that guide agents toward correct, secure, and maintainable code from the start." It provides reusable resources to help agents navigate Drupal's mature APIs, coding standards, and architectural conventions (`README.md`).

2. **Primary artefact type**
It is an **aggregator** of Claude Code resources, specifically containing **skills**, **agents**, and **commands** (`README.md`, `.claude/skills/`, `.claude/agents/`, `.claude/commands/`).

3. **Distribution model**
It functions as a standalone git repo designed to be consumed by the `agr` package manager. It installs via `agr` commands (e.g., `agr add madsnorgaard/drupal-agent-resources/drupal-expert`) which directly downloads the resources into the user's local `.claude` directory (`README.md`).

4. **Standards conformance**
It uses the `SKILL.md` format with YAML frontmatter for its skills (e.g., `.claude/skills/drupal-expert/SKILL.md`). It is **single-tool compatible**, explicitly built as "Reusable Claude Code resources" (`README.md`). It does not use `AGENTS.md` (`INDEX.md`).

5. **Architectural pattern**
It uses a **routing layer + selective load** pattern via the `agr` package manager. Instead of a flat skill dump, it acts as a package registry where developers selectively load specific skills, agents, or commands (e.g., `agr add .../drupal-expert`). At runtime, context is loaded natively through Claude Code's agent-with-tool-use and slash command architectures (`README.md`).

6. **Naming convention**
It uses **hyphenated nouns** (e.g., `drupal-expert`, `drupal-security`, `module-scaffold`, `drupal-reviewer`). This **diverges** from `ai_best_practices`' gerund-prefix choice (`README.md`, `INDEX.md`).

7. **Coverage**
- **General Drupal 10/11 Development** (hooks, services, caching, testing): `.claude/skills/drupal-expert/SKILL.md`
- **Security** (XSS, SQL injection, access bypass): `.claude/skills/drupal-security/SKILL.md` (referenced in `README.md`)
- **Migrations** (D7-to-D10, CSV imports, plugins): `.claude/skills/drupal-migration/SKILL.md` (referenced in `README.md`)
- **DDEV Local Development**: `.claude/skills/ddev-expert/SKILL.md` (referenced in `README.md`)
- **Docker Local Development**: `.claude/skills/docker-local/SKILL.md` (referenced in `README.md`)
- **Code Review** (standards, performance, DI): `.claude/agents/drupal-reviewer.md`
- **Site Health Checks**: `.claude/commands/drush-check.md`
- **Module Scaffolding**: `.claude/commands/module-scaffold.md`
- **Configuration Export**: `.claude/commands/config-export.md`
- **Security Auditing**: `.claude/commands/security-audit.md`
- **Performance Analysis**: `.claude/commands/performance-check.md`

8. **Quality signals**
- **Last commit date**: 2026-04-14 (per `INDEX.md` and `git log`).
- **CI/CD**: Uses GitHub Actions for validation (`.github/workflows/validate.yml`).
- **Versioning**: Strong versioning discipline with `CHANGELOG.md` and `VERSIONING.md` present.
- **Tests/Evals**: No formal evaluation harness or automated tests for the prompts (`INDEX.md` confirms `evals/: Absent`).

9. **Notable innovations**
The packaging and distribution via `agr` is novel, allowing granular, a la carte installation of skills rather than forcing developers to load a monolithic context file. Additionally, its use of Claude Code's **slash commands** (`/module-scaffold`, `/security-audit`) provides actionable, workflow-driven AI assistance directly in the terminal, which goes beyond passive knowledge retrieval.

10. **Weaknesses / gaps**
- **Single-tool lock-in**: It is heavily tied to Claude Code and the `agr` package manager, making it unusable out-of-the-box for Cursor, Copilot, or Gemini users.
- **Missing Evals**: Lack of a formal evaluation harness to test prompt efficacy.

11. **Compatibility with ai_best_practices' decisions**
It conflicts on multiple fronts:
- **Naming**: Uses hyphenated nouns instead of gerunds.
- **Directory structure**: Uses `.claude/skills/` instead of `skills/`.
- **Scope**: Includes Claude-specific agents and commands, whereas `ai_best_practices` leans tool-agnostic.
To merge it in, the skills would need to be extracted from `.claude/skills/`, renamed to gerunds (e.g., `writing-drupal-modules`), and the Claude-specific commands/agents would either need to be generalized or dropped.

12. **Relationship to Surge**
Surge does not currently aggregate this because it is locked into Claude Code's structure and the `agr` ecosystem. Surge could theoretically aggregate the underlying `SKILL.md` files, but it would conflict with the repo's intended distribution model via `agr`.

13. **One-paragraph verdict**
**Reference**. The repository contains excellent, deep Drupal knowledge and showcases an innovative approach to distributing AI context via a package manager (`agr`) and Claude-specific slash commands. However, its strict lock-in to Claude Code and `agr` makes it incompatible with the tool-agnostic goals of `ai_best_practices`. We should reference it as a state-of-the-art example of Claude Code integration, and potentially collaborate with the author to extract the core Drupal knowledge into tool-agnostic skills, rather than absorbing the repository wholesale.