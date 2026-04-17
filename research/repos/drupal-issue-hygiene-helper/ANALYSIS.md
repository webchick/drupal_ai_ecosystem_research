1. **What problem does it solve?**
It is a "CLI tool to help maintain Drupal.org issue queues by analyzing issues and suggesting improvements" (`README.md`). It automates the process of identifying issues with common hygiene problems (like failing CI tests, missing test instructions, or unanswered questions) to help maintainers triage more efficiently (`README.md`).

2. **Primary artefact type**:
CLI tool. It is a standalone PHP command-line application invoked via `php issue.php` (`README.md`), built using Symfony Console (`composer.json`, `CLAUDE.md`).

3. **Distribution model**:
Standalone git repo. It is distributed via source and requires users to manually run `composer install` and copy/edit a `.env` file for configuration (`README.md`).

4. **Standards conformance**:
Proprietary format. It does not use `agentskills.io` formats; there is no `SKILL.md` or `AGENTS.md` (`INDEX.md`). It is a single-tool application hardcoded to use the OpenAI API via the `symfony/ai-platform` component (`composer.json`, `CLAUDE.md`).

7. **Coverage**:
- Drupal.org issue queue maintenance (identifying stale issues, needs review, RTBC status) (`README.md`)
- Contribution workflow (checking MRs, patches, and CI test statuses) (`README.md`)
- Drupal.org API consumption and headless web scraping (`CLAUDE.md`)

8. **Quality signals**:
- **Last commit date**: April 7, 2026 (based on git history).
- **Issue count**: 0 open issues (GitHub API).
- **Stars/Watchers**: 1 star, 1 watcher (GitHub API).
- **Tests**: None (no test directory or test files exist).
- **Eval harness**: None.
- **CI**: None (no `.github` or other CI workflows are present in the directory structure shown in `INDEX.md`).
- **Versioning discipline**: None apparent (standalone script, author notes the "whole tool is vibe-coded" in `README.md`).
- **Active maintainer**: Marcus Johansson (`composer.json`).

11. **Compatibility with ai_best_practices' decisions**:
It is fundamentally incompatible with the project's standard formats. The directory uses a custom PHP application structure (`src/`, `state/`) rather than the expected `skills/` or `agents/` directories (`INDEX.md`). There is no standard metadata (no `SKILL.md`). To merge its capabilities, the hardcoded PHP logic in `src/Service/IssueChecker.php` and the prompts referenced in `CLAUDE.md` would need to be rewritten as a declarative `SKILL.md` prompt that utilizes standard agent tools (like Playwright for browsing) instead of custom PHP web scraping.

13. **One-paragraph verdict**:
The `ai_best_practices` repository should **absorb** the core domain knowledge from this project while ignoring its codebase. The specific heuristics it uses—such as identifying RTBC issues with unresolved discussions, flagging bug reports without detailed steps, or catching feature requests without use cases (`README.md`)—are highly valuable and should be extracted into a standard markdown-based skill (e.g., an issue triage skill). However, maintaining a bespoke PHP/Symfony CLI tool that manually scrapes Drupal.org via Headless Chromium (`CLAUDE.md`) falls outside the architectural scope of providing portable, standard agent workflows.
