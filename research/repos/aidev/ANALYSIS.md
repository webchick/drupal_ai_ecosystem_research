# aidev — Semantic Analysis

**Source**: https://git.drupalcode.org/project/aidev.git
**Last commit**: 2024-04-01 (~24 months stale as of 2026-04-17) — ABANDONED
**License**: GPL-2.0-or-later
**Default branch**: `1.0.x`

## Q0. Primary mode
**(e) module / PHP code.** A Drupal contrib module exposing a service (`aidev.source_code`) that gathers and preprocesses module/theme source code into an array suitable for feeding to an LLM. No skill content, agent defs, prompts, or docs site. Cited from `/home/pointblank/research/repos/aidev/INDEX.md` lines 12–16 (10 PHP files, 2 YAML, 1 `.module`, 1 `.md`, 1 `.json`) and lines 24–30 (no `skills/`, `.claude/`, `agents/`, `commands/`, `hooks/`, `prompts/`, `evals/`). Mode (e) means the "aggregator" interpretation note for Q5–Q7 does not apply.

## Q1. Problem solved
From `/home/pointblank/research/repos/aidev/README.md` line 11 (quoted):
> "Build Drupal systems using natural language with the help of AI. At the moment has API functions to gather and preprocess source code."

Paraphrased: aidev is a building block for LLM-assisted Drupal dev. It solves the "prompt packaging" problem — walk a module/theme tree, apply include/exclude/mention/omit-binary rules, compute per-file stats, return a structured array. The grand "build Drupal with natural language" vision is not implemented; only the source-gathering primitive ships.

## Q2. Primary artefact type
**Module (Drupal contrib PHP).** One service (`aidev.source_code`), one plugin manager (`src/SourceModifierPluginManager.php`), one plugin type (`src/Annotation/SourceModifier.php`, `src/Plugin/SourceModifierPluginBase.php`, `SourceModifierPluginInterface.php`), one domain class (`src/Source.php`), one interface (`src/SourceInterface.php`), one exception (`src/Exception/AIDevException.php`). No skills, agents, commands, hook-as-guidance, prompts, CLI, or docs.

## Q3. Distribution model
**Drupal contrib module via Composer.** `/home/pointblank/research/repos/aidev/composer.json`: `"name": "drupal/aidev"`, `"type": "drupal-module"`. Install: `composer require drupal/aidev` + `drush en aidev`. `aidev.info.yml` line 4: `core_version_requirement: ^9 || ^10` — no Drupal 11 support. Not a Claude plugin, not npm, not a docs site.

## Q4. Standards conformance
**None of the skill conventions apply.** Independent verification:
- `SKILL.md`: 0 (INDEX.md line 39)
- `skill.md` lowercase: none (only 1 `.md` total per INDEX.md line 15, which is README.md, line 22)
- `skill.yaml`: absent (line 33)
- frontmatter-md in `skills/`: `skills/` absent (line 24)
- numbered-dir skill layout: none
- bare `.md` skills: none
- `AGENTS.md`: absent (line 21); `CLAUDE.md`: absent (line 20); `.cursor*`: absent (line 34)

aidev is **agnostic** about which AI assistant consumes `gatherProjectSource()` output. It does not conform to agentskills.io, Anthropic Skills, or AGENTS.md because it is not a guidance artefact.

## Q5. Architectural pattern
**Drupal service + plugin manager.** No AI guidance loads at runtime. Flow:
1. `aidev.services.yml` registers `aidev.source_code` (backed by `Drupal\aidev\Source`). The services.yml file read was blocked by a local safety hook; service name and class confirmed via README.md line 32 and INDEX.md line 49.
2. Caller invokes `$service->gatherProjectSource($type, $name, $modifiers)` or `gatherDirectorySource($path, $modifiers)` (`src/Source.php` lines 67, 76).
3. Resolves module/theme path via `ModuleExtensionList`/`ThemeExtensionList` (`src/Source.php` lines 126–148), walks with `RecursiveDirectoryIterator` (lines 83–84), tags each file via `markModifiers` (lines 153–165), applies modifiers from a lazy-instantiated plugin manager (`applyModifier`, lines 181–195), computes statistics (lines 200–209).
4. Modifiers pluggable via `@SourceModifier` annotation + base + interface. Built-in modifier keys: `mention`, `exclude`, `include`, `omit_binary` (README.md lines 37–47; `Source.php` lines 100–102, 192).

## Q6. Naming convention
**N/A for skills (none exist).** Module naming: machine name `aidev` (flat, lowercase, no gerund); PHP classes PascalCase (`Source`, `SourceInterface`, `AIDevException`); plugin keys flat lowercase (`mention`, `exclude`, `include`, `omit_binary`). Divergence from ai_best_practices gerund-prefix is vacuous — no skill units to rename.

## Q7. Coverage — Drupal topics
Effectively one topic: source-code gathering for prompt packaging.

| Topic | Path |
| --- | --- |
| Recursive file walk into `{relative_path, source, stats}` | `/home/pointblank/research/repos/aidev/src/Source.php` (76–121) |
| Path resolution via Drupal extension lists | `/home/pointblank/research/repos/aidev/src/Source.php` (126–148) |
| Glob-style (`*`,`?`) path matching | `/home/pointblank/research/repos/aidev/src/Source.php` (232–255) |
| Pluggable source-modifier system | `/home/pointblank/research/repos/aidev/src/Annotation/SourceModifier.php`, `src/SourceModifierPluginManager.php`, `src/Plugin/SourceModifierPluginBase.php`, `SourceModifierPluginInterface.php` |
| Token-approximation heuristic (`word_count * 2.5`) | `/home/pointblank/research/repos/aidev/src/Source.php` (200–209) |
| Binary detection (null-byte heuristic) | `/home/pointblank/research/repos/aidev/src/Source.php` (214–227) |
| Domain exception | `/home/pointblank/research/repos/aidev/src/Exception/AIDevException.php` |

Zero coverage of: entities, forms, hooks, migrations, theming, Twig, caching, config, coding standards, security, testing — i.e. none of the topics ai_best_practices would own.

## Q8. Quality signals
- **Last commit**: 2024-04-01 (INDEX.md line 5), subject "define package" (line 6). ~24 months stale. **ABANDONED** (>12mo rule).
- **Branch**: `1.0.x` (INDEX.md line 8). No tagged release in clone.
- **Tests**: none (no `tests/`, no `phpunit.xml`).
- **CI**: none (`.github/` absent, INDEX.md line 35; no `.gitlab-ci.yml` in tree lines 45–64).
- **Eval harness**: none (INDEX.md line 30).
- **Versioning**: `^9 || ^10` only — no Drupal 11.
- **Docs**: 60-line README, single usage example, no API docs beyond PHPDoc.
- **Issues/maintainer**: not inspectable from clone; drupal.org queue would clarify but does not change the abandonment signal.

Low-activity, single-maintainer-style project that halted before Drupal 11.

## Q9. Notable innovations
- **Declarative modifier DSL** (README.md lines 34–48): compact rule list with `status`/`action`/`paths`; later rules override earlier ones (`Source.php` lines 153–165), giving allow-then-deny layering.
- **Pluggable modifiers**: `@SourceModifier` annotation + manager lets third parties ship modifiers (strip PHPDoc, truncate, redact secrets) without forking. Clean Drupal-native extension point.
- **In-module token approximation** (`Source.php` line 207: `round($word_count * 2.5)`) — crude but avoids a tokenizer dep for prompt budgeting.
- **Status flag on rules** (README.md line 47; `Source.php` line 158) — config-style enable/disable without deletion.

Novel vs. a raw `file_get_contents()` loop; not novel vs. a Claude skill that does the same in a few lines of Bash.

## Q10. Weaknesses / gaps
- **Unfinished vision**: README promises "build Drupal with natural language" (line 11) but ships only source gathering. No LLM call, no NL parser, no codegen, no diff application.
- **Abandoned 24mo**; no Drupal 11; no tests; no CI. Adopting = taking over maintenance.
- **Unclear consumer story**: no Drush command, no form, no MCP server, no HTTP endpoint. Requires custom PHP. Value vs. a 20-line script is marginal.
- **Fragile pattern regex** (`Source.php` 238–243): mixes `preg_quote` with `str_replace` on quoted output. Works for basic cases, untested at edges.
- **Binary detection** (`Source.php` 214–227): null-byte only; misses many binary formats and false-flags UTF-16 text.
- **Empty `aidev.module`** (1-line `<?php`) — shipping a `.module` file for a pure library is cruft.
- **No guidance layer** — the exact thing ai_best_practices exists to own.
- **No licensing/attribution/secret-guard policy** for code being shipped to an LLM.

## Q11. Compatibility with ai_best_practices decisions

| Decision | aidev |
| --- | --- |
| Gerund-prefix skill naming | **N/A** — no skills. No conflict. |
| `skills/` at root | **N/A** — dir absent (INDEX.md line 24). |
| Metadata `drupal-version` + `status` | **N/A** — no skill frontmatter. |
| Composer-installable | **Compatible** — already `drupal/aidev`. |
| Universal Drupal guidance scope | **Orthogonal** — aidev is a runtime PHP utility, not guidance. |

**Changes to merge**: none in the aidev→ai_best_practices direction (no guidance to merge). Reverse direction: ai_best_practices could optionally mention aidev in a prior-art footnote as "a PHP utility for packaging a module into a prompt" but would not absorb it.

## Q12. Relationship to Surge
Surge (sibling in Tier 1 Batch 1) aggregates skills/agents/commands. aidev ships none of these.
- **Does Surge aggregate aidev?** No — nothing aggregatable exists.
- **Could it?** Only by stretching Surge's unit from "skill file" to "Drupal module", which is a category error.
- **Conflict?** None. Different layers: aidev runs in Drupal; Surge/ai_best_practices run in the assistant harness.

## Q13. Verdict
**IGNORE** (optional one-line "prior art" pointer).

aidev is a dormant, narrowly-scoped PHP utility that predates the current AI-coding-assistant wave and implements one-tenth of the vision its README promises. No skills, no agents, no prompts, no guidance, no tests, no Drupal 11. Its one real design idea — the pluggable `SourceModifier` DSL — is conceptually nice but overlaps with what a Claude Code session handles in a few lines of Bash, and adopting a 10-file Drupal module for that is not justified. ai_best_practices should not absorb, depend on, pattern after, or collaborate with aidev. The only defensible move is a footnote in a prior-art appendix. Reconsider only if aidev revives with a Drupal 11 release and an end-to-end workflow; until then, de-emphasise.
