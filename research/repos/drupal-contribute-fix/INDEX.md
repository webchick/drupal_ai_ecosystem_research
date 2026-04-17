# drupal-contribute-fix Index

## Repo Facts

- Path: /Users/webchick/Documents/Codex/2026-04-17-research-drupal-ai-tooling-landscape-synthesis-2/research/repos/drupal-contribute-fix
- Last commit date: 2026-03-03 10:13:13 -0700
- Skill count (SKILL.md): 1

## Presence / Absence

- CLAUDE.md: no
- AGENTS.md: no
- skills/: no
- .claude/skills/: no
- agents/: no
- commands/: no
- hooks/: no
- .claude/: no
- prompts/: no
- evals/: no
- composer.json: no
- package.json: no
- skills.yaml: no
- Any SKILL.md files: yes

## File Tree (Depth 3)

~~~text
.
./.gitignore
./INDEX.md
./LICENSE
./README.md
./SKILL.md
./examples
./examples/sample-report.md
./lib
./lib/__init__.py
./lib/baseline_repo.py
./lib/drupalorg_api.py
./lib/drupalorg_urls.py
./lib/issue_matcher.py
./lib/issue_queue_integration.py
./lib/patch_packager.py
./lib/report_writer.py
./lib/security_detector.py
./lib/validator.py
./references
./references/core-testing.md
./references/hack-patterns.md
./references/issue-status-codes.md
./references/patch-conventions.md
./requirements.txt
./scripts
./scripts/contribute_fix.py
./tests
./tests/test_contribute_fix_test_command.py
./tests/test_drupalorg_urls.py
./tests/test_issue_queue_integration.py
./tests/test_patch_packager.py
./tests/test_report_writer_mr_workflow.py
~~~

## File Type Counts

~~~text
.md	8
.py	16
.txt	1
[dotfile-no-ext]	1
[no-ext]	1
~~~

## README (First 200 Lines)

Source: README.md

~~~text
# drupal-contribute-fix

![Drupal](https://img.shields.io/badge/Drupal-Contribution-0678BE)
![Agent Skill](https://img.shields.io/badge/Agent_Skill-Compatible-green)
![License](https://img.shields.io/badge/license-GPL--2.0%2B-blue)
![Python](https://img.shields.io/badge/python-3.8%2B-blue)

**Turn local Drupal fixes into effortless, maintainer-friendly contributions.**

AI scales code generation, but it shouldn't scale noise.

We want to empower AI Agents to fix Drupal bugs, while protecting maintainers from
a flood of duplicate or low-quality contributions. This tool bridges the gap,
transforming the Agent from a "local hacker" into a **responsible open-source contributor**.

### Our Mission: High Signal, Zero Noise
To ensure contributions are helpful rather than overwhelming, this skill enforces three strict rules:
1. **Targeted:** Searches Drupal.org first. If a fix exists, we stop and recommend using it. No duplicate effort.
2. **High-Quality:** Runs PHP lint by default; runs PHPCS if available; flags hack patterns.
3. **Maintainer-First:** Never auto-posts. Generates clean artifacts for **you** to review.

---

## 📖 Table of Contents

- [Why Use This?](#why-use-this)
- [What This Will NOT Do](#what-this-will-not-do)
- [How It Works](#how-it-works)
- [What You Get](#what-you-get)
- [Quick Start](#quick-start)
- [DDEV + drupalorg-cli Setup (Recommended)](#ddev--drupalorg-cli-setup-recommended)
- [Workflow Modes](#workflow-modes)
- [Options](#options)
- [Exit Codes (Gatekeeper Behavior)](#exit-codes-gatekeeper-behavior)
- [For AI Agent Developers](#for-ai-agent-developers)

---

## Why Use This?

**Stop your AI from "hacking" core.**

| :x: Without this Skill | :white_check_mark: With `drupal-contribute-fix` |
| :--- | :--- |
| **Duplicate Work:** Agent ignores existing MRs/patches. | **Upstream-aware:** Searches Drupal.org and surfaces existing fixes. |
| **Tech Debt:** Fixes are buried in `vendor/` or `core/`. | **Standardized:** Generates local `.diff` review artifacts in `diffs/`. |
| **Maintainer Burnout:** Spammy, low-quality issues. | **Maintainer-friendly:** Warns on risky patterns and keeps human review in the loop. |
| **Lost Fixes:** Local work vanishes on `composer update`. | **Preserved Work:** Artifacts are saved for future MR follow-up. |
| **No Validation:** Errors slip through. | **Quality Gates:** Runs PHP lint and PHPCS (if available). |

---

## What This Will NOT Do

**This skill is designed to be helpful without creating churn.**

| :no_entry_sign: Never | :white_check_mark: Instead |
|:---|:---|
| Auto-post to Drupal.org | Generates files for **you** to review and paste |
| Create issues automatically | Searches existing issues; you decide what to file |
| Push to git.drupalcode.org | Outputs local artifacts only (comment + `.diff`) |
| Bypass your review | Every artifact requires human approval before submission |
| Spam maintainers | Stops when existing MR/patch found; encourages testing over duplicating |

### The "No Noise" Guarantee
This tool never auto-posts to Drupal.org or pushes code automatically. It only generates
local artifacts for you to review and submit.

**The `--force` flag should be rare.** Use it only when:
- You've reviewed the existing MR/patch and confirmed your fix is meaningfully different
- You're providing a reroll for a different version
- The existing fix doesn't apply to your Drupal version

When using `--force`, always explain in your issue comment why a local `.diff` artifact was needed.

---

## How It Works

```mermaid
graph TD
    A[🔍 Local Fix Detected] --> B{Search Drupal.org}
    B -- MR/Patch Exists --> C[🛑 STOP & DOWNLOAD]
    C --> D[Test Existing Fix]
    B -- No Fix Found --> E{Check Dev Branch}
    E -- Fixed in Dev --> F[🛑 STOP & UPGRADE]
    E -- Bug Exists in Dev --> H{Hack Detection}
    H -- Clean Fix --> I[✅ GENERATE MR ARTIFACTS + DIFF]
    H -- Hacky Fix --> K[⚠️ WARN USER]
```

*Note: Dev-branch checks are currently a manual step; the tool does not auto-verify them yet.*

---

## What You Get

```
.drupal-contribute-fix/
├── UPSTREAM_CANDIDATES.json           # Search results cache (shared)
├── 3345678-fix-metatag-build/         # Known issue with slug
│   ├── REPORT.md                      # Analysis & next steps
│   ├── ISSUE_COMMENT.md               # Copy/paste this to drupal.org
│   └── diffs/
│       └── metatag-fix-3345678.diff   # Local review artifact
└── unfiled-update-module-check/       # New issue needed
    ├── REPORT.md
    ├── ISSUE_COMMENT.md
    └── diffs/
        └── project-fix-new.diff
```

**Directory naming:** `{nid}-{slug}/` for existing issues, `unfiled-{slug}/` for new issues.

---

## Quick Start

### Prerequisites

- Python 3.8+
- Git
- Internet access to drupal.org API
- DDEV (recommended for running `drupalorg-cli`)
- PHP 8.1+ in the runtime where `drupalorg-cli` executes

### Installation

```bash
# Clone from your preferred location
git clone <repository-url>
cd drupal-contribute-fix
```

## DDEV + drupalorg-cli Setup (Recommended)

This skill now recommends `drupalorg-cli` for issue-fork/MR/pipeline execution.
If your host PHP is older, run `drupalorg-cli` inside DDEV.

Install a global DDEV command:

```bash
mkdir -p ~/.ddev/commands/web
cat > ~/.ddev/commands/web/drupalorg <<'EOF'
#!/usr/bin/env bash
## Description: Run drupalorg-cli inside the web container
## Usage: drupalorg [args]
## ProjectTypes: drupal,drupal11,drupal10,drupal9,drupal8,drupal7,backdrop,php
## ExecRaw: true
set -euo pipefail
PHAR="/mnt/ddev-global-cache/drupalorg-cli/drupalorg.phar"
URL="https://github.com/mglaman/drupalorg-cli/releases/latest/download/drupalorg.phar"
mkdir -p "$(dirname "$PHAR")"
if [ ! -x "$PHAR" ]; then
  curl -fsSL "$URL" -o "$PHAR"
  chmod +x "$PHAR"
fi
exec php "$PHAR" "$@"
EOF
chmod +x ~/.ddev/commands/web/drupalorg
```

Optional shell alias:

```bash
alias drupalorg='ddev drupalorg'
```

Verify in a DDEV project directory:

```bash
ddev restart
ddev drupalorg --version
```

### Usage

**Search only (preflight):**
```bash
python3 scripts/contribute_fix.py preflight \
  --project metatag \
  --keywords "TypeError MetatagManager" \
  --out .drupal-contribute-fix
```

Tip: Drupal.org's `api-d7` endpoint does **not** support a full-text `text=` filter (it returns HTTP 412). For manual keyword searching, use the Drupal.org UI search:

```text
https://www.drupal.org/project/issues/search/<project>?text=<keywords>
```

## Companion Tool: drupal-issue-queue (optional)

For deeper triage (filters by status/priority/category/version/component/tag) and issue/thread summaries via `api-d7`, use the companion tool `drupal-issue-queue` (GitHub repo: `scottfalconer/drupal-issue-queue`).

Common examples (run from the `drupal-issue-queue` directory):

```bash
# Summarize an issue (Markdown)
python scripts/dorg.py issue <nid-or-url> --format md

~~~

## License

Source: LICENSE

~~~text
SPDX-License-Identifier: GPL-2.0-or-later

This project is licensed under the GNU General Public License v2.0 or later.

You should have received a copy of the GNU General Public License along with
this program. If not, see <https://www.gnu.org/licenses/gpl-2.0.html>.

~~~
