# Drupal AI Tooling Landscape Synthesis

Note: the matrices below cover the **19 Tier 1 / Tier 2 repos with `ANALYSIS.md` files**. Tier 3 items are treated separately in `research/tier3.md`.

## 1. Landscape map

Legend: `✓` = clearly present, `~` = partial/nonstandard, `-` = absent or not a primary artefact.

| Repo | Skills | Agents | Commands | Hooks | Prompts | Eval | Module | Aggregator | Skill count |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| surge | - | - | - | - | - | - | ✓ | ✓ | 0 |
| aidev | - | - | - | - | - | - | ✓ | - | 0 |
| drupal-claude-skills | ✓ | ✓ | - | - | - | - | - | - | 9 |
| drupal-agent-resources | ✓ | ✓ | ✓ | - | - | - | - | - | 5 |
| drupal-workflow | ✓ | ✓ | ✓ | ✓ | - | ✓ | - | - | 19 |
| drupal-agentic-workflow | ✓ | - | - | ✓ | - | - | - | - | 20 |
| claude-skill-drupal-module | ✓ | - | - | - | - | - | ✓ | - | 1 |
| drupaltools-skills | ✓ | ✓ | - | - | - | - | - | - | 27 |
| drupal-intent-testing | ✓ | - | - | - | - | ✓ | - | - | 1 |
| drupal-contribute-fix | ✓ | - | - | - | - | ✓ | - | - | 1 |
| drupalcon-chicago-26-ckeditor-ai-playground | ~ | - | - | - | - | - | - | - | 1 |
| prompt_library | - | ✓ | - | - | ✓ | - | - | - | 0 |
| drupal-issue-hygiene-helper | - | - | ✓ | - | - | - | - | - | 0 |
| drupal-coding-standards-skill | ✓ | - | - | - | - | - | ✓ | - | 1 |
| drupal-critic | ✓ | ✓ | - | - | - | ✓ | - | - | 1 |
| Drupal-DDEV-Setup-Claude-Skill | ~ | - | - | - | - | - | - | - | 0 |
| drupal-canvas-skills | ✓ | - | - | - | - | - | - | - | 9 |
| omedia-drupal-skill | ✓ | - | - | - | - | - | - | - | 3 |
| ai-fe-skills | ✓ | - | - | - | - | ~ | - | - | 1 |

High-level read: there is only one clear **aggregator/integration layer** (`surge`), a handful of **broad skill libraries** (`drupal-claude-skills`, `drupaltools-skills`, `omedia-drupal-skill`, `drupal-canvas-skills`), and a growing cluster of **workflow systems** that bundle skills with agents/commands/hooks/evals (`drupal-workflow`, `drupal-agentic-workflow`, `drupal-agent-resources`, `drupal-critic`).

## 2. Standards conformance map

| Repo | Root `skills/` + `SKILL.md` | Non-root / proprietary skill layout | `AGENTS.md` | Explicit multi-tool posture | Notes |
|---|---|---|---|---|---|
| surge | - | - | ✓ | ✓ | Tool-agnostic delivery/generation layer |
| aidev | - | - | - | - | Pre-skills-era module/tooling |
| drupal-claude-skills | ✓ | `.claude/agents/` layer | ✓ | Partial | Mergeable content, Claude-shaped agents |
| drupal-agent-resources | - | `.claude/skills/` | - | Partial | Strong content, layout divergence |
| drupal-workflow | ✓ | `.claude-plugin/` marketplace layer | - | Partial | Standards-ish skills, Claude/plugin-centric runtime |
| drupal-agentic-workflow | - | `.claude/skills/` + `.claude/hooks/` | - | Low | Claude-specific |
| claude-skill-drupal-module | - | Root `SKILL.md` | - | Low | Composer-distributed but single-skill |
| drupaltools-skills | ✓ | `agents/` alongside skills | - | Moderate | Structurally close to target |
| drupal-intent-testing | - | Root `SKILL.md` | - | Low | Harness-specific |
| drupal-contribute-fix | - | Root `SKILL.md` | - | Moderate | Narrow but portable enough |
| drupalcon playground | - | Root `SKILL.md` | - | Low | Demo/worked example |
| prompt_library | - | Site rules/prompts/agents | - | Moderate | Not a skill library |
| drupal-issue-hygiene-helper | - | none | - | - | CLI, not skills |
| drupal-coding-standards-skill | - | `.claude/skills/` | ✓ | Moderate | Strong pattern, deprecated wrapper |
| drupal-critic | - | `.claude/skills/` + agent | - | Low | Reviewer-specific |
| Drupal-DDEV-Setup-Claude-Skill | - | `.claude/skills/` with lowercase `skill.md` | - | Low | Nonstandard casing/layout |
| drupal-canvas-skills | ✓ | - | - | High | Cleanest standards-native packaging |
| omedia-drupal-skill | - | top-level skill dirs + Claude plugin marketplace | - | Low | Good content, proprietary packaging |
| ai-fe-skills | - | top-level skill dir | - | High | Strong multi-tool intent, narrow scope |

The mergeability boundary is clear: repos already using root `skills/` with standard `SKILL.md` files are easier to absorb. Everything under `.claude/skills/` or plugin-marketplace layouts adds conversion work even when the content is good.

## 3. Pattern clusters

### A. Aggregation and delivery layers

- `surge`: Composer/plugin aggregator that scans sources, installs skills, and generates `AGENTS.md` (`research/repos/surge/src/Skills/SkillsAggregator.php`, `research/repos/surge/src/Agents/Command/AgentsGenerateCommand.php`).

### B. Flat or moderately modular skill libraries

- `drupal-claude-skills`: broad curated skill set plus optional agents (`research/repos/drupal-claude-skills/skills/`).
- `drupaltools-skills`: largest root-`skills/` library in the set, with companion agents (`research/repos/drupaltools-skills/skills/`, `research/repos/drupaltools-skills/agents/`).
- `omedia-drupal-skill`: three broad specialization skills (`research/repos/omedia-drupal-skill/drupal-backend/SKILL.md`, `drupal-frontend/SKILL.md`, `drupal-tooling/SKILL.md`).
- `drupal-canvas-skills`: narrowly focused but structurally clean root-`skills/` library (`research/repos/drupal-canvas-skills/skills/`).

### C. Layered workflow systems

- `drupal-workflow`: skill library plus agents, commands, hooks, policy scripts, and a large eval harness (`research/repos/drupal-workflow/skills/`, `agents/`, `commands/`, `hooks/hooks.json`, `eval/`).
- `drupal-agentic-workflow`: skill bundle with prompt hooks and post-generation enforcement (`research/repos/drupal-agentic-workflow/.claude/skills/`, `.claude/hooks/`).
- `drupal-agent-resources`: smaller mixed bundle of skills, commands, and one reviewer agent (`research/repos/drupal-agent-resources/.claude/skills/`, `.claude/commands/`, `.claude/agents/drupal-reviewer.md`).
- `drupal-critic`: review-specialized orchestration that routes into pinned external skills (`research/repos/drupal-critic/.claude/skills/drupal-critic/references/external-skills-manifest.yaml`, `skill-routing-map.md`).

### D. Single-skill or narrow workflow specialists

- `claude-skill-drupal-module`
- `drupal-contribute-fix`
- `drupal-intent-testing`
- `drupal-coding-standards-skill`
- `Drupal-DDEV-Setup-Claude-Skill`
- `ai-fe-skills`

### E. Adjacent but non-library tooling/docs

- `aidev`
- `drupal-issue-hygiene-helper`
- `prompt_library`
- `drupalcon-chicago-26-ckeditor-ai-playground`

## 4. Coverage matrix

Legend: `✓` = strong coverage, `~` = partial/narrow coverage, `-` = not a meaningful topic.

### Repos 1-10

| Topic | sur | aid | dcs | dar | dwf | daw | csm | dts | dit | dcf |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Coding standards | - | - | ✓ | ~ | ✓ | ~ | ✓ | ✓ | - | - |
| Security | - | - | ✓ | ✓ | ✓ | ✓ | ✓ | ~ | - | ~ |
| Testing / eval | - | - | - | - | ✓ | ~ | ✓ | ~ | ✓ | ✓ |
| Contribution / issue queue | - | - | ✓ | - | - | - | - | ✓ | - | ✓ |
| DDEV / Drush / env | - | - | ✓ | ✓ | ~ | ✓ | ~ | ✓ | - | - |
| Backend / module APIs | - | ~ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | - | - |
| Frontend / Twig / theming | - | - | ~ | - | - | ✓ | ~ | - | - | - |
| Config / deploy workflow | - | - | ✓ | - | ✓ | ✓ | ✓ | - | - | - |
| Canvas / SDC / components | - | - | ✓ | - | - | - | - | - | ✓ | - |
| Review / quality gate | - | - | ✓ | ✓ | ✓ | ✓ | - | ~ | ✓ | ✓ |

### Repos 11-19

| Topic | dcp | plb | dih | dcs2 | dcr | dds | dca | oms | afe |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Coding standards | - | ✓ | - | ✓ | ~ | - | - | ✓ | - |
| Security | - | ✓ | - | - | ✓ | - | - | - | - |
| Testing / eval | - | - | - | - | ✓ | - | - | - | ✓ |
| Contribution / issue queue | - | - | ✓ | - | ✓ | - | - | - | - |
| DDEV / Drush / env | - | ✓ | - | - | - | ✓ | - | ✓ | - |
| Backend / module APIs | - | ~ | - | - | - | ✓ | - | ✓ | - |
| Frontend / Twig / theming | ✓ | - | - | - | - | - | - | ✓ | ~ |
| Config / deploy workflow | - | - | - | - | - | ✓ | - | ~ | - |
| Canvas / SDC / components | ✓ | - | - | - | - | - | ✓ | - | ✓ |
| Review / quality gate | - | ✓ | ✓ | ✓ | ✓ | - | - | - | ✓ |

Repo key: `sur` surge, `aid` aidev, `dcs` drupal-claude-skills, `dar` drupal-agent-resources, `dwf` drupal-workflow, `daw` drupal-agentic-workflow, `csm` claude-skill-drupal-module, `dts` drupaltools-skills, `dit` drupal-intent-testing, `dcf` drupal-contribute-fix, `dcp` drupalcon-chicago-26-ckeditor-ai-playground, `plb` prompt_library, `dih` drupal-issue-hygiene-helper, `dcs2` drupal-coding-standards-skill, `dcr` drupal-critic, `dds` Drupal-DDEV-Setup-Claude-Skill, `dca` drupal-canvas-skills, `oms` omedia-drupal-skill, `afe` ai-fe-skills.

### What everyone covers

- Coding standards
- Basic Drupal backend/module guidance
- DDEV/Drush/tooling
- Review/quality guidance

These are the strongest **absorb-and-consolidate** candidates.

### What is under-covered or fragmented

- Multisite and multi-environment deployment discipline
- Decoupled/headless workflows outside `drupal-at-your-fingertips`
- Accessibility as a first-class Drupal-wide skill rather than a subtopic
- Performance beyond caching
- Contribution etiquette/issue queue skills that are both portable and well-tested
- Task-oriented skill decomposition around concrete work units instead of role labels

These are good candidates for new `ai_best_practices` skills rather than more merging.

## 5. Overlap and conflict analysis

### Heavy overlap

- **Coding standards** are duplicated across `research/repos/drupal-coding-standards-skill/.claude/skills/drupal-coding-standards/SKILL.md`, `research/repos/drupal-workflow/skills/drupal-coding-standards/SKILL.md`, `research/repos/prompt_library/development/rules/drupal-standards.md`, and `research/repos/omedia-drupal-skill/drupal-backend/SKILL.md`.
- **DDEV/Drush/tooling** repeats across `research/repos/drupal-claude-skills/skills/drupal-ddev/SKILL.md`, `research/repos/drupal-agent-resources/.claude/skills/ddev-expert/SKILL.md`, `research/repos/omedia-drupal-skill/drupal-tooling/SKILL.md`, and `research/repos/Drupal-DDEV-Setup-Claude-Skill/.claude/skills/drupal-setup/skill.md`.
- **Contribution workflow** overlaps across `research/repos/drupal-contribute-fix/SKILL.md`, `research/repos/drupal-claude-skills/skills/drupal-contrib-mgmt/SKILL.md`, `research/repos/drupaltools-skills/skills/drupaltools-contrib-validator/SKILL.md`, and `research/repos/drupal-issue-hygiene-helper/src/Service/IssueChecker.php`.
- **Canvas/component guidance** overlaps across `research/repos/drupal-canvas-skills/skills/canvas-component-definition/SKILL.md`, `research/repos/ai-fe-skills/drupal-figma-to-canvas-sdc/SKILL.md`, and `research/repos/drupal-claude-skills/skills/drupal-canvas/SKILL.md`.

### Structural conflicts if merged naively

- **Directory conflict**: root `skills/` (`research/repos/drupaltools-skills/skills/`, `research/repos/drupal-canvas-skills/skills/`, `research/repos/drupal-workflow/skills/`) versus `.claude/skills/` (`research/repos/drupal-agent-resources/.claude/skills/`, `research/repos/drupal-agentic-workflow/.claude/skills/`, `research/repos/drupal-coding-standards-skill/.claude/skills/`).
- **Naming conflict**: product/topic labels such as `drupal-expert`, `drupal-tooling`, `drupal-coding-standards`, `drupal-setup`, `drupal-frontend`, and `drupal-backend` diverge from `ai_best_practices`’ gerund decision. This affects slash-command discoverability and collision risk.
- **Metadata conflict**: `drupal-workflow` intentionally carries richer metadata and lifecycle machinery than `ai_best_practices` wants; its analyses already flagged the mismatch between its model and the minimal metadata decision.
- **Tool-lock conflict**: marketplace/plugin layouts in `research/repos/drupal-workflow/.claude-plugin/plugin.json` and `research/repos/omedia-drupal-skill/.claude-plugin/marketplace.json` are not appropriate as the canonical package layout for a neutral Drupal content source.

### Potential guidance conflicts

- `research/repos/prompt_library/development/rules/drupal.md` pushes a specific modern-OOP style set including `final` classes and `#[Hook]`-style guidance, while broader cross-version skills like `research/repos/omedia-drupal-skill/drupal-backend/SKILL.md` are written to span Drupal 8-11+. That is not a hard contradiction, but it is a version-skew risk if guidance is merged without version framing.
- `research/repos/Drupal-DDEV-Setup-Claude-Skill/.claude/skills/drupal-setup/skill.md` assumes project-setup automation and reset flows that are inappropriate as universal baseline guidance; merging it into general DDEV advice would blur the line between portable best practice and project-specific scaffolding.

## 6. Best-in-class picks

### Best structural / routing pattern

**Pick: `drupal-workflow`**  
Why: it has the clearest full-stack architecture for selective loading and staged execution: skills, agents, commands, hooks, policies, and evals all reinforce one another instead of acting as a flat dump. The strongest evidence is in `research/repos/drupal-workflow/skills/discover/SKILL.md`, `research/repos/drupal-workflow/docs/AUTOPILOT_SPEC.md`, and `research/repos/drupal-workflow/scripts/task-classifier.sh`.  
Close second: `research/repos/drupal-coding-standards-skill/.claude/skills/drupal-coding-standards/standards-index.md` for simpler deterministic file-type routing.

### Best eval / testing approach

**Pick: `drupal-workflow`**  
Why: it is the only repo that combines skill content with a real eval suite spanning behavioral evals, static checks, agent eval runners, and hook integration tests. See `research/repos/drupal-workflow/eval/behavioral/drupal-security-patterns/evals.json`, `research/repos/drupal-workflow/eval/eval-skills.py`, and `research/repos/drupal-workflow/eval/eval-hooks-integration.sh`.  
Close second: `research/repos/drupal-intent-testing/scripts/compare_runs.py` and `tests/` for browser-driven intent verification.

### Best per-topic skill content to absorb

- **Contribution workflow**: `research/repos/drupal-contribute-fix/SKILL.md`
- **Coding-standards routing**: `research/repos/drupal-coding-standards-skill/.claude/skills/drupal-coding-standards/SKILL.md` plus `standards-index.md`
- **Module-development reference pack**: `research/repos/claude-skill-drupal-module/SKILL.md` with `research/repos/claude-skill-drupal-module/references/entity-api.md`, `form-api.md`, `hooks.md`, `security.md`, and `testing-quality.md`
- **Large general-purpose Drupal knowledge pack**: `research/repos/drupal-claude-skills/skills/drupal-at-your-fingertips/SKILL.md` with its topical references tree

These are the strongest candidates for direct absorption or close adaptation.

### Best agent definitions

**Pick: `drupal-critic`**  
Why: the reviewer agent is narrowly scoped, explicitly read-only, and paired with a structured rubric and routing map, which is a stronger safety profile than generic “expert” agents. Evidence: `research/repos/drupal-critic/.claude/agents/drupal-critic.md`, `research/repos/drupal-critic/.claude/skills/drupal-critic/references/drupal-review-rubric.md`, `audience-activation-matrix.md`, and `skill-routing-map.md`.  
Close second: `research/repos/drupal-workflow/agents/drupal-reviewer.md`.

### Best hooks / quality gates

**Pick: `drupal-workflow`**  
Why: it has the most complete gate system, not just a single post-generation hook. Evidence: `research/repos/drupal-workflow/hooks/hooks.json`, `research/repos/drupal-workflow/scripts/teammate-quality-gate.sh`, `scripts/php-lint-on-save.sh`, and `scripts/block-sensitive-files.sh`.  
Close second: `research/repos/drupal-agentic-workflow/.claude/hooks/post-generation-lint.sh` and `pre-bash-guard.sh`.

### Best distribution / install story

**Pick: `surge`**  
Why: among the analyzed repos, it is the clearest package that separates content sources from install/delivery concerns and already knows how to aggregate multiple sources and generate `AGENTS.md`. Evidence: `research/repos/surge/src/Skills/SkillsAggregator.php`, `src/Skills/Source/ComposerSource.php`, `src/Skills/Source/ModuleSource.php`, and `src/Agents/Command/AgentsGenerateCommand.php`.

### Best multi-tool compatibility approach

**Pick: `drupal-canvas-skills`**  
Why: it uses the cleanest root-`skills/` packaging, standard `SKILL.md` files, and a neutral install path via `npx skills add`. Evidence: `research/repos/drupal-canvas-skills/README.md` and the skill tree under `research/repos/drupal-canvas-skills/skills/`.  
Close second: `research/repos/ai-fe-skills/drupal-figma-to-canvas-sdc/SKILL.md`, which is narrower but explicitly multi-tool aware.

## Bottom line

The landscape is not short on Drupal AI guidance; it is short on **convergence**. The clearest split is:

- `surge` owns **distribution/aggregation**
- `ai_best_practices` should own **canonical Drupal-wide content**
- specialized repos can remain **reference implementations or feeders**

The best consolidated approach is therefore not “pick one winner repo.” It is: absorb the strongest reusable skill content, adopt the strongest routing/eval patterns, keep distribution separate, and refuse to inherit vendor-specific layout and metadata decisions that conflict with the package direction already chosen for `ai_best_practices`.
