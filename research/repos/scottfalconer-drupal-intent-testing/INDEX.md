# scottfalconer-drupal-intent-testing — Structural Index

**Source URL**: https://github.com/scottfalconer/drupal-intent-testing
**Clone URL used**: https://github.com/scottfalconer/drupal-intent-testing
**Last commit**: 2026-02-02 13:22:19 -0700
**Last commit subject**: Rename Legal Tone label example
**License**: LICENSE
**Default branch**: refs/heads/main

## File type counts

     16 py
      3 txt
      3 md
      1 /LICENSE
      1 gitignore

## Presence of key files/dirs

- CLAUDE.md: ✗ absent
- AGENTS.md: ✗ absent
- README: ✓ present (README.md)
- skills/ : ✗ absent
- .claude/ : ✗ absent
- .claude/skills/ : ✗ absent
- agents/ : ✗ absent
- commands/ : ✗ absent
- hooks/ : ✗ absent
- prompts/ : ✗ absent
- evals/ : ✗ absent
- composer.json: ✗ absent
- package.json: ✗ absent
- skills.yaml: ✗ absent
- .cursorrules / .cursor/ : ✗ absent
- .github/ : ✗ absent

## SKILL.md count

Number of SKILL.md files: 1

Paths:

```
./SKILL.md
```

## File tree (depth 3)

```
.
./LICENSE
./README.md
./references
./references/drupal_patterns.md
./requirements.txt
./scripts
./scripts/collectors.py
./scripts/compare_runs.py
./scripts/explore.py
./scripts/__init__.py
./scripts/intent
./scripts/intent/__init__.py
./scripts/intent/manifest.py
./scripts/intent_test.py
./scripts/intent/validate_manifest.py
./scripts/judge_intent.py
./scripts/test_scenarios
./scripts/test_scenarios/basic_content_creation.txt
./scripts/test_scenarios/canvas_ai_context_label.txt
./SKILL.md
./tests
./tests/__init__.py
./tests/test_collectors.py
./tests/test_compare_runs.py
./tests/test_explore.py
./tests/test_intent_manifest.py
./tests/test_intent_test.py
./tests/test_judge_intent.py
```

## README first 200 lines

Source: README.md

```
# 🕵️ Drupal Intent Testing

> **"Does this actually do what we meant?"**

This repository contains **agent skills** for UI-first verification of Drupal applications. It allows an AI agent to drive a real browser, performing the kind of semi-random, exploratory verification a human QA tester would do—but automated.

## 🧠 The Philosophy

This is **intentionally not a replacement** for Drupal’s standard PHPUnit, Kernel, or FunctionalJavascript tests. It complements them by validating **UX**, **Integration Glue**, and **End-to-End Intent**.

| Traditional Testing (PHPUnit) | Intent Testing (This Repo) |
| :--- | :--- |
| Checks if the code executes without error. | Checks if the user experience makes sense. |
| Validates internal logic. | Validates "Integration Glue" between modules. |
| Rigid and specific. | Exploratory, semantic, and flexible. |

**The Goal:** Verify that when we build a feature (like a new content type or AI integration), the actual workflow functions as intended in the browser.

## ⚡ Why `agent-browser`?

These skills are built for the **`agent-browser`** runtime, making them uniquely suited for AI workflows:

*   **CLI-First:** Works directly inside CLI agents (Claude Code, GitHub Copilot, Cursor) because it operates as a shell tool.
*   **No Vision Model Needed:** Uses the browser's **Accessibility Tree** and deterministic element references. It "reads" the page like a screen reader rather than relying on expensive or flaky computer vision.
*   **Visual Evidence:** While it navigates via text/code, it captures **real rendering screenshots** to provide an audit trail of what the user actually saw.

## 📂 Included Patterns

The repository includes templates for common "Intent" workflows.

### 1. The "Writer" Intent (`basic_content.agent`)
*   **The Intent:** "I want to verify that a basic user can log in and publish content without errors."
*   **What it validates:**
    *   Authentication flows.
    *   Database write permissions.
    *   The "Add Content" form UI stability.
    *   Success feedback loops (e.g., seeing the "Node has been created" message).

### 2. The "Builder" Intent (`canvas_ai_context.agent`)
*   **The Intent:** "I want to verify that backend configuration changes actually propagate to the frontend editor interface."
*   **What it validates:**
    *   **Integration Glue:** Checks the connection between Admin Configuration and the Content Editor UI.
    *   **Propagation:** Proves that complex modules (like *Canvas AI*, *Views*, or *Webform*) are correctly exposing their settings to end-users.

## 🚀 Usage

### Prerequisites
*   A running Drupal instance (Local, Dev, or Sandbox).
*   The `agent-browser` tool installed.
*   User credentials (provide via CLI args or `DRUPAL_TEST_USER` / `DRUPAL_TEST_PASS`).

### Running a Skill
Pass the skill file to your agent runner:

```bash
# Verify basic system health
agent-run skills/basic_content.agent

# Verify module configuration logic
agent-run skills/canvas_ai_context.agent
```

## 🔁 Agent-in-the-Loop Workflow (Claude Code / Codex)

This repo is built around a **tight feedback loop** where the agent explores, captures evidence, and you (or the agent) decide the next step. A typical loop looks like:

1. **Snapshot** the current UI (accessibility tree).
2. **Act** (click, fill, navigate).
3. **Wait** for UI stability.
4. **Checkpoint** (snapshot + screenshot + console/errors).
5. **Decide** next step based on evidence.

### One-line request (agent writes the test for you)

If you say “test with drupal-intent-testing,” the agent should **author the verification artifact itself** (scenario or manifest) from your intent, then run it.

Example prompt you can paste into Claude Code or Codex:

```text
Make this change and test it with drupal-intent-testing. You must define the test artifact yourself.

Change: After saving the layout, the Hero component should render on the LEFT side of the screen.
Base URL: https://SITE
Credentials: DRUPAL_TEST_USER / DRUPAL_TEST_PASS are set (safe to mutate).
Component selector: [data-testid="hero"] (use if present; otherwise find a reliable selector).
Success criteria: after the change, the component's bounding rect is in the left half of the viewport.
```

The agent should then:
- infer the intent,
- generate a scenario script or manifest,
- run baseline/modified (if applicable),
- and report evidence + verdict.

### Example: “Does this result in a component ending up on the left of the screen?”

Because `agent-browser` is accessibility-tree driven (no vision model), you verify layout by **capturing layout metrics** with `eval` and storing them as evidence.

#### Example prompt you can paste into Claude Code or Codex

```text
Goal: Verify whether the target component ends up on the left side of the screen after I perform the layout change.

Context:
- Site URL: https://SITE/node/123
- The component has selector: [data-testid="hero"] (adjust if needed)
- Use agent-browser commands only.

Instructions:
1) Open the page and wait for network idle.
2) Capture a “before” screenshot and snapshot in test_outputs/.
3) Perform the UI action that should move the component to the left (use semantic locators).
4) Wait for network idle.
5) Run a DOM eval that returns bounding client rect + whether it is on the left half of the viewport.
   Use this eval (or equivalent):
   (() => {
     const el = document.querySelector('[data-testid="hero"]');
     if (!el) return {found:false};
     const r = el.getBoundingClientRect();
     return {found:true, left:r.left, right:r.right, width:r.width, viewport:window.innerWidth, is_left: r.left < (window.innerWidth/2)};
   })()
6) Capture an “after” screenshot and snapshot in test_outputs/.
7) Summarize: report is_left, bounding rect values, and any console/Drupal errors.
```

Interpretation:
* `is_left: true` means the component’s left edge is in the left half of the viewport.
* You can tighten this check (e.g., `r.right <= window.innerWidth/2`) depending on the layout.

#### If you want a repeatable script

Create a scenario script (e.g., `scripts/test_scenarios/left_layout_check.txt`) and run compare mode:

```bash
python3 scripts/compare_runs.py \\
  --url "https://SITE" \\
  --script scripts/test_scenarios/left_layout_check.txt \\
  --output-dir test_outputs \\
  --between-cmd "ddev snapshot restore intent-baseline"
```

This generates a **baseline vs modified** report with snapshots, screenshots, and any `eval` payloads you record.

## ⚠️ Safety & Developer Notes

Exploratory testing is destructive by nature.

*   **Destructive Actions:** The agent will create content, change configurations, and click buttons. Do not run on Production without strict guardrails.
*   **CKEditor / Body Fields:** Standard Drupal replaces the "Body" textarea with a Rich Text Editor. If the agent cannot find label "Body", you may need to instruct it to click the "Source" button in the editor toolbar first.
```
