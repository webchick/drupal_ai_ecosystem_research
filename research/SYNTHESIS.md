# Ecosystem Synthesis

## 1. Landscape Map

| Repository | Artefact Types | Skill Count |
| :--- | :--- | :--- |
| `drupal-skill` | Skills (Claude Code plugins) | 3 |
| `Drupal-DDEV-Setup-Claude-Skill` | Claude Code plugin | 1 |
| `ai-fe-skills` | Skills | 1 |
| `drupal-canvas-skills` | Skills | 9 |
| `prompt_library` | Docs site / aggregator | N/A |
| `drupal-critic` | Skills, agents, aggregator | 1 (orchestrates 24 external) |
| `drupal-issue-hygiene-helper` | CLI tool | 0 |
| `drupal-coding-standards-skill` | Agent Skill | 1 |
| `drupalcon-chicago-26-ckeditor-ai-playground` | Drupal module + Skill | 1 |
| `drupal-intent-testing` | Agent skills + CLI tool | N/A |
| `drupal-contribute-fix` | Skill + CLI tool | 1 |
| `drupaltools-skills` | Skills + Agents | 27 |
| `claude-skill-drupal-module` | Skill / Claude plugin | 1 |
| `drupal-agentic-workflow` | Skills + Hooks | 20 |
| `drupal-agent-resources` | Aggregator (skills, agents, commands) | Multiple |
| `drupal-workflow` | Claude Code plugin | 19 |
| `drupal-claude-skills` | Aggregator (skills, agents) | Multiple |
| `aidev` | Drupal contrib module | 0 |
| `surge` | Composer plugin/CLI tool (Aggregator) | 0 |

## 2. Standards Conformance Map

| Repository | Format | SKILL.md | AGENTS.md | Multi-tool Compatible? |
| :--- | :--- | :--- | :--- | :--- |
| `drupal-skill` | Proprietary (Claude plugin) | Yes (custom YAML) | No | No |
| `Drupal-DDEV-Setup-Claude-Skill` | Proprietary (Claude native) | Yes | No | No |
| `ai-fe-skills` | agentskills.io | Yes | No | Yes |
| `drupal-canvas-skills` | agentskills.io | Yes | No | Yes |
| `prompt_library` | Proprietary (11ty frontmatter) | No | No | Yes |
| `drupal-critic` | Proprietary (Claude native) | Yes | No | No |
| `drupal-issue-hygiene-helper`| Proprietary (Symfony/PHP) | No | No | No |
| `drupal-coding-standards-skill`| agentskills.io | Yes | Yes | Yes |
| `drupalcon-chicago-26-ckeditor-ai-playground`| Proprietary (Custom markdown)| Yes | No | No |
| `drupal-intent-testing` | agentskills.io | Yes | No | Yes |
| `drupal-contribute-fix` | agentskills.io | Yes | No | Yes |
| `drupaltools-skills` | Mixed (skills: standard, agents: proprietary)| Yes | No | Yes (skills only) |
| `claude-skill-drupal-module` | Proprietary (Claude plugin via Composer)| Yes | No | No |
| `drupal-agentic-workflow` | Proprietary (Claude hooks) | Yes | No | No |
| `drupal-agent-resources` | Proprietary (via `agr` package manager)| Yes | No | No |
| `drupal-workflow` | Proprietary (Claude plugin) | Yes | No | No |
| `drupal-claude-skills` | Mixed | Yes | No | Yes (skills only) |
| `aidev` | Proprietary (Drupal module) | No | No | No |
| `surge` | agentskills.io templates | No | Yes | Yes |

## 3. Pattern Clusters

- **Flat Skill Dumps**: Repos providing standalone, un-orchestrated skill files (`ai-fe-skills`, `drupal-canvas-skills`).
- **Thick-Client Claude Plugins**: Deeply coupled to Claude Code with custom hooks, plugins, and slash commands (`drupal-skill`, `Drupal-DDEV-Setup-Claude-Skill`, `drupal-agentic-workflow`, `drupal-workflow`, `claude-skill-drupal-module`, `drupalcon-chicago-26-ckeditor-ai-playground`).
- **Aggregators / Registries**: Tools designed to pull and manage skills (`drupal-agent-resources` via `agr`, `surge` via Composer, `drupal-critic` via a manifest, `drupal-claude-skills` via `npx`/scripts).
- **Python / CLI Wrapped Skills**: Agent instructions delegating complex execution to Python or shell scripts (`drupal-intent-testing`, `drupal-contribute-fix`).
- **Reference / Docs Sites**: `prompt_library`.
- **PHP Applications / Drupal Modules**: `drupal-issue-hygiene-helper`, `aidev`.

## 4. Coverage Matrix

- **Frontend / UI / Canvas**: High coverage (`ai-fe-skills`, `drupal-canvas-skills`, `drupal-intent-testing`, `drupal-workflow`, `drupal-claude-skills`).
- **Backend / OOP / Hooks**: High coverage (`drupal-skill`, `prompt_library`, `drupaltools-skills`, `claude-skill-drupal-module`, `drupal-agentic-workflow`, `drupal-claude-skills`).
- **Coding Standards / Review**: High coverage (`drupal-critic`, `drupal-coding-standards-skill`, `drupal-agentic-workflow`, `drupal-workflow`, `drupal-claude-skills`).
- **Local Dev (DDEV)**: High coverage (`Drupal-DDEV-Setup-Claude-Skill`, `drupal-agent-resources`, `drupal-claude-skills`, `drupal-skill`).
- **Security**: Medium coverage (`drupal-critic`, `drupal-contribute-fix`, `drupal-agent-resources`, `drupal-claude-skills`).
- **Issue Queue / Contribution**: Medium coverage (`drupal-issue-hygiene-helper`, `drupal-contribute-fix`).
- **Gaps**: Extensive documentation on configuration management edge cases across different environments, multilingual specifics, deep Drupal Commerce architecture, and caching invalidation edge cases.

## 5. Overlap and Conflict Analysis

- **DDEV / Environment Setup**: Significant duplication exists for setting up DDEV. `Drupal-DDEV-Setup-Claude-Skill` (`.claude/skills/drupal-setup/skill.md`), `drupal-skill` (`drupal-tooling/SKILL.md`), `drupal-agent-resources` (`.claude/skills/ddev-expert/SKILL.md`), and `drupal-claude-skills` (`skills/drupal-ddev/SKILL.md`) all provide overlapping local dev context.
- **Coding Standards Enforcement**: There is an architectural conflict between dynamic routing and autonomous hooks. `drupal-coding-standards-skill` (`.claude/skills/drupal-coding-standards/standards-index.md`) uses context-efficient routing based on file extensions, whereas `drupal-agentic-workflow` uses brute-force bash hook interventions (`.claude/hooks/post-generation-lint.sh`) to autonomously lint.
- **Quality Gates**: Workflow enforcement is heavily fragmented. `drupal-claude-skills` uses specialized Claude agents as gates (`.claude/agents/quality-gate.md`), `drupal-agentic-workflow` uses pre-command bash scripts (`.claude/hooks/pre-bash-guard.sh`), and `drupal-workflow` employs an autopilot monitoring script (`scripts/autopilot-monitor.sh`).
- **Distribution Mechanisms**: Distribution methods conflict across aggregators. We see `npx skills add` (`drupaltools-skills`, `drupal-claude-skills`), custom `agr add` (`drupal-agent-resources`), and Composer integration (`surge`, `claude-skill-drupal-module`).

## 6. Best-in-Class Picks

- **Structural pattern**: `surge` (`src/Agents/templates/`) for its Composer-driven aggregation and dynamic template generation.
- **Eval approach**: `drupal-workflow` (`eval/eval-agents.py`, `eval/behavioral/`) for automated LLM-as-judge scoring.
- **Skill content**: `claude-skill-drupal-module` (`references/*.md`) for comprehensive API documentation, and `drupal-coding-standards-skill` (`.claude/skills/drupal-coding-standards/standards-index.md`) for context-efficient dynamic routing.
- **Agent definitions**: `drupal-claude-skills` (`.claude/agents/quality-gate.md`) for defining strict, explicit workflow gates.
- **Hooks / Interventions**: `drupal-agentic-workflow` (`.claude/hooks/post-generation-lint.sh`) for closed-loop autonomous linting.
- **Install story**: `surge` (`composer.json`) and `claude-skill-drupal-module` (`composer.json` leveraging `composer-installers-extender`) for seamlessly plugging into standard PHP workflows.
- **Compatibility**: `ai-fe-skills` (`drupal-figma-to-canvas-sdc/SKILL.md`) for pure adherence to the `agentskills.io` standard without tool lock-in.