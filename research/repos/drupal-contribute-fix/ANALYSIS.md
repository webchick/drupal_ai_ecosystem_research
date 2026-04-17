# Repository Analysis: drupal-contribute-fix

1. **What problem does it solve?** 
The project aims to transform an AI agent from a "local hacker" into a "responsible open-source contributor." It empowers AI agents to fix Drupal bugs locally while protecting upstream maintainers from a flood of duplicate or low-quality automated contributions. It achieves this by first searching Drupal.org for existing MRs or patches, running local validation (PHP lint, PHPCS), and generating local artifacts for human review rather than auto-posting to the issue queue (based on `README.md`).

2. **Primary artefact type**: 
**Skill** and **CLI tool**. It includes an agentskills.io-format `SKILL.md` file designed to be consumed by agents, which acts as a wrapper around a Python CLI entry point (`scripts/contribute_fix.py`).

3. **Distribution model**: 
**Standalone git repo**. The `README.md` instructs users to install it via `git clone <repository-url>`.

4. **Standards conformance**: 
It strictly follows the agentskills.io format with a `SKILL.md` file ("Agent Skills specification by Anthropic" as per `README.md`). It does not use `AGENTS.md` or `CLAUDE.md` (as noted in `INDEX.md`), making it primarily single-tool/Anthropic oriented by default, though the underlying Python CLI is universally accessible.

7. **Coverage**: 
- **Contribution workflow**: `scripts/contribute_fix.py`, `lib/drupalorg_api.py`, `lib/patch_packager.py` (Searches drupal.org, formats MR comments, and generates review artifacts).
- **Coding standards**: `lib/validator.py` (Runs PHP lint and PHPCS, referenced in `README.md`).
- **Security**: `lib/security_detector.py` (Flags security issues locally during artifact generation).
- **DDEV**: `README.md` (Documents DDEV setup instructions for running `drupalorg-cli`).

8. **Quality signals**: 
- **Last commit date**: 2026-03-03 (as reported by `INDEX.md` and `git log -1`).
- **Issue count / stars**: Not verifiable locally, but the remote is `scottfalconer/drupal-contribute-fix`.
- **Tests**: Present (`tests/` directory contains tests like `tests/test_issue_queue_integration.py`).
- **CI**: Absent (no `.github/workflows` found).
- **Versioning discipline**: None (no git tags found).
- **Active maintainer**: Maintained by `scottfalconer`.

11. **Compatibility with ai_best_practices' decisions**: 
To be merged in, it would require significant adaptation. It is a full Python application with its own `requirements.txt`. It would need to be placed in a dedicated `tools/` or `skills/` subdirectory, its dependencies would need to be integrated or clearly isolated, and it would need additional metadata (like `AGENTS.md` and `CLAUDE.md`) to align with broader multi-agent compatibility goals.

13. **One-paragraph verdict**: 
`ai_best_practices` should **reference** this repository. It is a highly opinionated, complex Python tool (comprising multiple modules and test suites) that effectively enforces the contribution best practices the community wants to see—specifically preventing duplicate MRs and enforcing linting before posting. Absorbing it directly would bloat the best practices repository with significant Python logic and maintenance overhead, so linking out to it as a recommended external workflow tool for agent developers is the most sensible path.