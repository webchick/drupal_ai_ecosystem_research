# Drupal Intent Testing - Repository Analysis

**1. What problem does it solve?**
This repository provides "agent skills for UI-first verification of Drupal applications," allowing an AI agent to drive a real browser to perform automated "semi-random, exploratory verification" similar to a human QA tester (`README.md`). It intentionally complements standard tests (like PHPUnit) by focusing on validating "UX, Integration Glue, and End-to-End Intent" (e.g., verifying that backend configuration changes actually propagate to the frontend interface) without requiring an expensive or flaky vision model (`README.md`).

**2. Primary artefact type**
It is primarily a collection of **agent skills and a CLI tool** (built with Python). It provides agent runbook instructions (`SKILL.md`), Python execution harnesses (`scripts/compare_runs.py`, `scripts/intent_test.py`, `scripts/explore.py`), and test scenario templates (`scripts/test_scenarios/`) to orchestrate the external `agent-browser` tool (`INDEX.md`).

**3. Distribution model**
It is distributed as a **standalone git repo**. Users (or agents) are expected to clone the repository, install the prerequisite Node.js package globally (`npm install -g agent-browser`), install Python dependencies (`requirements.txt`), and execute the Python CLI scripts directly from the repository's file path (`SKILL.md`, `README.md`).

**4. Standards conformance**
It conforms to the `agentskills.io` format, providing a `SKILL.md` file with standard YAML frontmatter including `name`, `description`, `license`, `compatibility`, `metadata`, and `allowed-tools` (`SKILL.md`). It does not use `AGENTS.md` or `CLAUDE.md` (`INDEX.md`). It is explicitly **multi-tool compatible**, designed for CLI agents such as "Claude Code, Codex, Copilot, Cursor" (`SKILL.md`, `README.md`).

**7. Coverage**
- **Content Creation:** Validates authentication, database write permissions, and success feedback loops like "Node has been created" (`README.md`, `scripts/test_scenarios/basic_content_creation.txt`).
- **Configuration Propagation (Integration Glue):** Verifies backend admin settings correctly expose to frontend complex modules like Canvas AI (`README.md`, `scripts/test_scenarios/canvas_ai_context_label.txt`).
- **AI Agents Explorer:** Asserts against AI tool payloads and final answers (`SKILL.md`).
- **UI Layout Metrics:** Captures and verifies DOM evaluations like bounding client rects to ensure correct layout rendering (`README.md`).
- **Console & Drupal Errors:** Asserts the absence of JS console errors and Drupal alert/status messages (`SKILL.md`).

**8. Quality signals**
- **Last commit date:** 2026-02-02 (based on local `git log`).
- **Issue count / Stars:** Unknown (local repository with no remote tracking information).
- **Tests:** High coverage signal; includes a dedicated `tests/` directory with multiple Python test files (`tests/test_collectors.py`, `tests/test_compare_runs.py`, `tests/test_intent_manifest.py`, etc.) (`INDEX.md`).
- **Eval harness:** Contains a built-in evaluation judge for intent manifests (`scripts/judge_intent.py` and `scripts/intent_test.py`) (`INDEX.md`).
- **CI:** Absent; no `.github/` workflows or CI pipeline configuration files exist (`INDEX.md`).
- **Versioning discipline:** `SKILL.md` metadata defines `version: "0.2"`, but no git tags exist in the repository to formally mark releases.
- **Active maintainer:** Metadata lists author as `drupal-ai` (`SKILL.md`).

**11. Compatibility with ai_best_practices' decisions**
- **Naming convention / Directory:** The repository is clearly named (`drupal-intent-testing`), but its root directory structure mixes Python tooling (`scripts/`), documentation (`README.md`), and tests (`tests/`) without standard packaging (like `package.json` or `composer.json` beyond `requirements.txt`) (`INDEX.md`).
- **Metadata:** It adheres to the standard `SKILL.md` metadata format.
- **Scope:** It introduces an entirely separate testing paradigm and Python-based runtime harness rather than simple agent configurations.
- **What needs to change:** To be merged, its Python dependencies would need to be formally packaged (e.g., `pyproject.toml` or integrated via an npm wrapper), and the agent runbooks might need to be isolated into a dedicated `skills/` directory to separate the agent instructions from the Python runtime source code.

**13. One-paragraph verdict**
`ai_best_practices` should **reference** this repository. It introduces a highly specialized, innovative testing paradigm ("Intent Testing") that bridges the gap between traditional QA and autonomous AI agents using the external `agent-browser` dependency and a custom Python execution harness. Because it is a standalone CLI testing utility rather than a simple set of prompts or a Drupal module, absorbing it directly would bloat a best practices repository with heavy Python tooling. Instead, it should be maintained independently as the recommended toolchain for exploratory UI testing, with `ai_best_practices` linking out to it and defining how agents should leverage its intent manifest format.