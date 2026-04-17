# drupal_devkit — Structural Index

**Source URL**: https://git.drupalcode.org/project/drupal_devkit (copied from /tmp/drupal_devkit-peek/)
**Clone URL used**: copied via `cp -a /tmp/drupal_devkit-peek/ /home/pointblank/research/repos/drupal_devkit` (preserved existing .git)
**Last commit**: 2026-04-17 03:38:12 +0530
**Last commit subject**: docs: update all docs for Phase 1.5 (resolve conflicts, take worktree)
**License**: LICENSE (present)
**Default branch**: refs/heads/main

## File type counts

```
    955 md
    180 py
     40 json
     37 sh
     18 png
      6 txt
      6 sync-metadata
      3 yml
      3 html
      1 yaml
      1 toml
      1 /tests/fixtures/plugin-fixture/hooks/session-start
      1 /plugins/drupal-core/hooks/session-start
      1 mdc
      1 lock
      1 /LICENSE
      1 gitkeep
      1 gitignore
      1 gitattributes
      1 /ddev/commands/host/claude
```

## Presence of key files/dirs

- CLAUDE.md: ✓ present
- AGENTS.md: ✓ present
- README: ✓ present (README.md)
- skills/ : ✓ present
- .claude/ : ✗ absent (note: `.claude-plugin/` directory is present — plugin marketplace config, not the standard Claude Code `.claude/` dir)
- .claude/skills/ : ✗ absent
- agents/ : ✗ absent (note: `plugins/drupal-core/agents/` exists)
- commands/ : ✗ absent (note: `ddev/commands/` exists)
- hooks/ : ✗ absent (note: `plugins/drupal-core/hooks/` exists)
- prompts/ : ✗ absent
- evals/ : ✓ present
- composer.json: ✗ absent
- package.json: ✗ absent (note: `plugins/drupal-core/package.json` exists)
- skills.yaml: ✗ absent
- .cursorrules / .cursor/ : ✗ absent (note: `plugins/drupal-core/.cursor-plugin/` exists)
- .github/ : ✓ present

## SKILL.md count

Number of SKILL.md files (case-sensitive): **223**

Lowercase `skill.md` count: 0 (none — not flagged)

Note: >30 paths, so not listing all. The 223 count includes 5 harness-specific rendered copies (under `build/claude-code/`, `build/codex/`, `build/copilot-cli/`, `build/cursor/`, `build/gemini/`) plus the canonical source copies under `plugins/drupal-core/skills/` and `skills/using-drupal-devkit/`. Unique canonical skills: 37 (36 in `plugins/drupal-core/skills/` + 1 in `skills/using-drupal-devkit/`).

## File tree (depth 3)

```
.
./AGENTS.md
./ATTRIBUTION.md
./build
./build/claude-code
./build/claude-code/drupal-core
./build/claude-code/drupal-devkit
./build/codex
./build/codex/drupal-core
./build/codex/drupal-devkit
./build/contextfiles
./build/contextfiles/claude-code
./build/contextfiles/codex
./build/contextfiles/copilot-cli
./build/contextfiles/cursor
./build/contextfiles/gemini
./build/copilot-cli
./build/copilot-cli/drupal-core
./build/copilot-cli/drupal-devkit
./build/cursor
./build/cursor/drupal-core
./build/cursor/drupal-devkit
./build/gemini
./build/gemini/drupal-core
./build/gemini/drupal-devkit
./CHANGELOG.md
./CLAUDE.md
./.claude-plugin
./.claude-plugin/marketplace.json
./.claude-plugin/plugin.json
./community-registry.json
./CONTRIBUTING.md
./ddev
./ddev/commands
./ddev/commands/host
./ddev/install.yaml
./ddev/scripts
./ddev/scripts/bootstrap-container-claude.sh
./ddev/scripts/prompt-api-keys.sh
./docs
./docs/drupal-org-description.html
./docs/drupal-org-issue-template.html
./docs/drupal-org-submission-guidelines.html
./docs/source-spec-v1.md
./docs/superpowers
./docs/superpowers/plans
./docs/superpowers/specs
./docs/testing-community-registry.md
./drupal-marketplace.json
./evals
./evals/compare.py
./evals/drupal-security-patterns
./evals/drupal-security-patterns/evals.json
./evals/drupal-testing
./evals/drupal-testing/evals.json
./evals/LICENSE-compare.py
./evals/runs
./evals/runs/dev-days-demo-slide.md
./evals/runs/.gitkeep
./install.sh
./LICENSE
./plugins
./plugins/drupal-core
./plugins/drupal-core/agents
./plugins/drupal-core/AGENTS.md
./plugins/drupal-core/.claude-plugin
./plugins/drupal-core/.codex
./plugins/drupal-core/.codex-plugin
./plugins/drupal-core/.cursor-plugin
./plugins/drupal-core/gemini-extension.json
./plugins/drupal-core/GEMINI.md
./plugins/drupal-core/hooks
./plugins/drupal-core/.mcp.json
./plugins/drupal-core/package.json
./plugins/drupal-core/skills
./presets
./presets/canvas-dev.json
./presets/drupal-quickstart.json
./pyproject.toml
./README.md
./schemas
./schemas/drupal-marketplace-v1.json
./scripts
./scripts/migrate-frontmatter.py
./scripts/portability-audit.py
./skills
./skills/using-drupal-devkit
./skills/using-drupal-devkit/SKILL.md
./src
./src/drupal_devkit
./src/drupal_devkit/cli.py
./src/drupal_devkit/commands
./src/drupal_devkit/config.py
./src/drupal_devkit/eval_runner
./src/drupal_devkit/generator
./src/drupal_devkit/__init__.py
./src/drupal_devkit/installer
./src/drupal_devkit/__main__.py
./src/drupal_devkit/marketplace
./src/drupal_devkit/presets
./src/drupal_devkit/schemas
./tests
./tests/conftest.py
./tests/eval_runner
./tests/eval_runner/__init__.py
./tests/eval_runner/test_claude_cli_runner.py
./tests/eval_runner/test_grader.py
./tests/eval_runner/test_harness.py
./tests/eval_runner/test_runners_mock.py
./tests/fixtures
./tests/fixtures/plugin-fixture
./tests/generator
./tests/generator/__init__.py
./tests/generator/test_build_integration.py
./tests/generator/test_bumper.py
./tests/generator/test_cli.py
./tests/generator/test_emitter_claude.py
./tests/generator/test_emitter_codex.py
./tests/generator/test_emitter_contextfiles.py
./tests/generator/test_emitter_copilot.py
./tests/generator/test_emitter_cursor.py
./tests/generator/test_emitter_gemini.py
./tests/generator/test_generate_plugin.py
./tests/generator/test_loader.py
./tests/generator/test_meta_plugin.py
./tests/generator/test_smoke_install_parsing.py
./tests/generator/test_transformer.py
./tests/generator/test_validator.py
./tests/__init__.py
./tests/installer
./tests/installer/__init__.py
./tests/installer/test_cli_install.py
./tests/installer/test_ddev.py
./tests/installer/test_detector.py
./tests/installer/test_doctor.py
./tests/installer/test_flow.py
./tests/installer/test_targets_claude.py
./tests/installer/test_targets_codex.py
./tests/installer/test_targets_copilot.py
./tests/installer/test_targets_cursor.py
./tests/installer/test_targets_gemini.py
./tests/installer/test_targets_runtime.py
./tests/install_sh
./tests/install_sh/test_install_sh.bats
./tests/marketplace
./tests/marketplace/conftest.py
./tests/marketplace/__init__.py
./tests/marketplace/test_cache.py
./tests/marketplace/test_cli_marketplace.py
./tests/marketplace/test_cli_plugin.py
./tests/marketplace/test_install.py
./tests/marketplace/test_integration.py
./tests/marketplace/test_loader.py
./tests/marketplace/test_manifest.py
./tests/marketplace/test_presets.py
./tests/marketplace/test_state.py
./tests/marketplace/test_sync.py
./tests/standardization
./tests/standardization/audit-findings.md
./tests/standardization/fixtures
./tests/standardization/test_migrate_frontmatter.py
./tests/standardization/test_portability_audit.py
./uv.lock
./.version-bump.json
```

## README first 200 lines

Source: README.md

```
# drupal-devkit

**Cross-harness Drupal AI coding toolkit.** A marketplace of marketplaces
for Drupal AI skills, built as the reference implementation of
[`ai_best_practices`](https://git.drupalcode.org/project/ai_best_practices).

Subscribe to multiple git-based skill sources, enable/disable plugins per
harness, and install to **8 Tier 1 AI coding harnesses** from a single
CLI: Claude Code, Copilot CLI, Codex, Cursor, Gemini CLI, Kiro, OpenCode,
and Hermes.

Ships 36 bundled Drupal skills, a DDEV add-on, a universal curl-bash
installer, and a 3-layer eval harness (Gemma / Haiku / Opus).

---

## Install

### 1. Universal one-liner

```bash
curl -sSL https://git.drupalcode.org/project/drupal_devkit/-/raw/main/install.sh | bash
```

Detects your environment and installed harnesses, installs
[uv](https://github.com/astral-sh/uv) if missing, installs the
`drupal-devkit` Python package, registers the default marketplace
sources, and installs the `drupal-quickstart` preset for Claude Code.

After install, run interactively to add more harnesses:

```bash
drupal-devkit install --preset drupal-quickstart
```

### 2. DDEV add-on

```bash
ddev add-on get AJV009/ddev-drupal-devkit
```

Installs `drupal-devkit` on the host, optionally bootstraps Claude Code
inside the DDEV web container, and registers host commands: `ddev ai`,
`ddev ai-devkit`, `ddev claude`.

### 3. Manual install

```bash
uv tool install drupal-devkit --from "git+https://git.drupalcode.org/project/drupal_devkit.git"
```

Then run `drupal-devkit install` for the interactive installer.

---

## Interactive install

Running `drupal-devkit install` with no flags starts the interactive
installer:

```
Detected harnesses:
  1) * claude-code (claude)
  2)   codex (codex)
  3)   copilot-cli (copilot)
  4)   cursor (agent)
  5)   gemini (gemini)
  6)   hermes (hermes)
  7)   kiro (kiro-cli)
  8)   opencode (opencode)

Install to (e.g. 1,2,3 or 'all') [1]:

Available plugins:
  1) * drupal-devkit/drupal-core (36 skills, 1 agent)
  2) * ai_best_practices/ai_best_practices (2 skills, 4 agents)
  3) * drupal-canvas-plugin/drupal-canvas (7 skills)
  4) * drupal-canvas-plugin/migrate-drupal-canvas (9 skills)
  5) * drupal-canvas-plugin/migrate-drupal-canvas-source (9 skills)

Install plugins (e.g. 1,2,3 or 'all') [all]:
```

Select harnesses and plugins by number (comma-separated) or type `all`.
Claude Code is pre-selected as default.

### Non-interactive flags

```bash
# Specific harnesses (comma-separated)
drupal-devkit install --harness claude-code,gemini,kiro

# Preset bundle (skips plugin selector)
drupal-devkit install --preset drupal-quickstart

# Both
drupal-devkit install --preset drupal-quickstart --harness claude-code,gemini

# Skip all prompts (defaults to claude-code)
drupal-devkit install --yes
drupal-devkit install --preset drupal-quickstart --yes
```

---

## CLI reference

```
drupal-devkit install    [--preset NAME] [--harness H1,H2] [--yes] [--global]
drupal-devkit uninstall  [--global] [--yes]
drupal-devkit doctor
drupal-devkit build      [--plugin NAME] [--harness NAME]
drupal-devkit marketplace {add,list,refresh,remove}
drupal-devkit plugin     {list,search,info,enable,disable}
drupal-devkit eval       <skill> [--layer all|l1|l2|l3] [--trials N]
drupal-devkit bump       {major|minor|patch}
drupal-devkit version
```

- **`install`** — interactive harness + plugin selector. With `--preset`,
  installs a predefined bundle. Default is local (project directory);
  `--global` installs to global harness directories.
- **`uninstall`** — removes devkit-installed files from current directory.
  `--global` removes from global harness dirs + clears state.
- **`doctor`** — status report: detected harnesses, registered
  marketplaces, enabled plugins, sync status.
- **`build`** — regenerate `build/<harness>/<plugin>/` from source tree.
- **`marketplace`** — manage git-based skill sources (add/remove/refresh).
- **`plugin`** — list/search/info/enable/disable marketplace plugins.
- **`eval`** — run eval cases against a skill.
- **`bump`** — lockstep version bump across all manifest files.

---

## Marketplace architecture

drupal-devkit is a **marketplace of marketplaces**: it subscribes to
multiple git-based skill sources and lets users enable/disable plugins
per harness.

```
marketplace (git repo)
  -> plugin (group of related skills)
    -> skill (single SKILL.md + references/)
```

### Registered sources (defaults)

| Source | Ref | Description |
|---|---|---|
| **drupal-devkit** | main | 36 bundled Drupal 11+ skills |
| **ai_best_practices** | 1.0.x | Community Drupal AI guidance (testing, docs) |
| **drupal-canvas-plugin** | 1.x | Canvas + migration skills (3 plugins, 25 skills) |

### drupal-marketplace.json

Sources can ship a `drupal-marketplace.json` manifest to define plugin
groupings, custom paths, and metadata. Without a manifest (Level 0),
all skills are grouped into one plugin named after the source directory.

Conformance levels:
- **L0** (Heuristic): no manifest needed, auto-discovery from `skills/`
- **L1** (Manifest): `drupal-marketplace.json` with plugin grouping
- **L2** (Full metadata): license, maintainer, descriptions
- **L3** (Shared eval): eval coverage specifications

### Presets

```bash
drupal-devkit install --preset drupal-quickstart   # drupal-core + ai_best_practices
drupal-devkit install --preset canvas-dev          # drupal-core + all 3 canvas plugins + ai_best_practices
```

Custom presets: drop JSON files in `~/.config/drupal-devkit/presets/`.

---

## Supported harnesses

All 8 harnesses are Tier 1 with dedicated emitters, install targets, and
context file generation.

| Harness | CLI | Plugin dir (local) | Context file | Native skills |
|---|---|---|---|---|
| **Claude Code** | `claude` | `.claude/plugins/` | `AGENTS.md` | — |
| **Copilot CLI** | `copilot` | `.github/copilot/plugins/` | `AGENTS.md` | — |
| **Codex** | `codex` | `.agents/plugins/` | `AGENTS.md` | — |
| **Cursor** | `agent` | `.cursor/plugins/` | `.cursor/rules/drupal-devkit.mdc` | — |
| **Gemini CLI** | `gemini` | `.gemini/extensions/` | `GEMINI.md` | — |
| **Kiro** | `kiro-cli` | `.kiro/plugins/` | `AGENTS.md` | `.kiro/skills/` |
| **OpenCode** | `opencode` | `.opencode/plugins/` | `AGENTS.md` | `.opencode/skills/` |
| **Hermes** | `hermes` | `.hermes/plugins/` | `AGENTS.md` | `.hermes/skills/drupal/` |

Kiro, OpenCode, and Hermes also get skills copied into their native skill
directories for auto-discovery. Hermes uses category-organized skills
under a `drupal/` subdirectory.

### Per-harness generation

The generator handles per-harness quirks:
```
