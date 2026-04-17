# aldunchev-ai-fe-skills — Phase 2 LITE Analysis

**Tier**: 2 (LITE)
**Repo**: https://github.com/aldunchev/ai-fe-skills
**Last commit**: 2026-03-04
**Scope**: 1 skill (`drupal-figma-to-canvas-sdc`), 10 md files, 1 sh script
**License**: MIT (README); INDEX reports "none" at repo root

---

## Q1 — Problem solved

Converts Figma designs into production-ready Drupal Single Directory Components (SDC) for Drupal **Canvas** (page builder) projects using Tailwind CSS. Solves the manual, error-prone path from design handoff to schema-valid, Canvas-compatible, BEM-conforming, atom-composed Twig components. The skill enforces Canvas prop-type constraints (Canvas hides entire components if any prop uses an unsupported type), anti-pattern rules (hardcoded colors, invented spacing utilities, `!important`, missing `only` keyword, atom recreation), and atomic-design directory conventions (`01-atoms/`, `02-molecules/`, `03-organisms/`).

Highly specialized: Canvas + SDC + Tailwind + Figma — not generic Drupal theming.

## Q2 — Primary artefact type

**SKILL.md-based Agent Skill** with sub-agent orchestration. One SKILL.md at `drupal-figma-to-canvas-sdc/SKILL.md`, supporting assets:

- `references/` — 5 context files (planning.md, implementation.md, validation.md, project-context.md, shared-context.md) loaded by sub-agents per phase
- `assets/` — templates (component-plan.md, worked-example.md)
- `scripts/validate-antipatterns.sh` — bash script running 16 automatable anti-pattern checks (grep-based)
- `project-context.example.md` — user-customisable template for theme paths, tokens, atoms, build commands

Frontmatter: `name`, `description`, `argument-hint: <figma-url>`, `disable-model-invocation: true` (invocation is explicit-only via slash command).

## Q3 — Distribution model

**Manual git clone** into Claude Code skills directory:

```
git clone https://github.com/aldunchev/ai-fe-skills.git ~/.claude/skills/ai-fe-skills       # personal
git clone https://github.com/aldunchev/ai-fe-skills.git .claude/skills/ai-fe-skills         # project
```

Explicitly NOT Composer — no `composer.json`. Explicitly NOT an installable theme/module. README positions the repo as "Agent skills for frontend development" with cross-agent compatibility (Claude Code, Codex, Gemini CLI, Cursor, Windsurf) via the "cross-compatible Agent Skills format" (SKILL.md + YAML frontmatter).

Install path places it under `.claude/skills/` — not at project root as a `skills/` directory. No release tags; single default branch.

## Q4 — Standards conformance + skill-unit convention

**Anthropic Agent Skills spec**: conforms. YAML frontmatter with `name`, `description` present. `disable-model-invocation: true` is a known Claude Code flag gating autoload. `argument-hint` is also a documented Claude Code slash-command field. The skill is therefore slash-command-invoked only (not model-chosen).

**Skill-unit naming convention — independently detected from the repo itself**:

- Folder: `drupal-figma-to-canvas-sdc` — **kebab-case, domain-prefix (`drupal-`), source-to-target phrasing (`figma-to-canvas-sdc`)**
- Frontmatter `name` field matches folder exactly (`drupal-figma-to-canvas-sdc`)
- **NOT gerund-prefix. NOT verb-in-ing form.** The convention here is noun-phrase / platform-source-target.
- README forward-looks to additional skills for "Drupal, AEM, performance optimization" implying the same platform-prefixed pattern.

Direct conflict with ai_best_practices LOCKED decision #1 (gerund-prefix, verb-in-ing). A compliant rename would be something like `generating-drupal-sdc-from-figma` or `building-canvas-sdc-components`.

**Directory convention**: install target is `.claude/skills/ai-fe-skills/<skill-name>/` (a wrapper plus the skill folder). No `skills/` at project root. Conflict with LOCKED decision #2.

**Metadata**: no `drupal-version`, no `status`. No skill-specific metadata file (no `skills.yaml`). Frontmatter does not carry version/status — conflict with LOCKED decision #3.

## Q7 — Coverage (Drupal topics with file paths)

| Topic | Path |
|-------|------|
| Skill entry / orchestration | `drupal-figma-to-canvas-sdc/SKILL.md` |
| SDC directory mapping (atoms/molecules/organisms, numbered dirs) | `drupal-figma-to-canvas-sdc/references/shared-context.md` |
| Canvas prop-type constraints + schema compatibility | `drupal-figma-to-canvas-sdc/references/shared-context.md` |
| 12 "Golden Rules" anti-patterns | `drupal-figma-to-canvas-sdc/references/shared-context.md` |
| BEM naming | `drupal-figma-to-canvas-sdc/references/shared-context.md` |
| Planning phase playbook | `drupal-figma-to-canvas-sdc/references/planning.md` |
| Implementation playbook (generating `.component.yml`, `.twig`, `.pcss`, `.src.js`) | `drupal-figma-to-canvas-sdc/references/implementation.md` |
| Validation playbook (build, lint:css/js, twigcs, anti-pattern checks) | `drupal-figma-to-canvas-sdc/references/validation.md` |
| Project-specific tokens / atoms / paths (user-filled) | `drupal-figma-to-canvas-sdc/references/project-context.md` (+ `.example.md`) |
| 16 automated anti-pattern checks (grep-based) | `drupal-figma-to-canvas-sdc/scripts/validate-antipatterns.sh` |
| Plan template | `drupal-figma-to-canvas-sdc/assets/component-plan.md` |
| Worked input-to-output example | `drupal-figma-to-canvas-sdc/assets/worked-example.md` |

**Drupal surface covered**: SDC (schema + twig + optional pcss/js), Canvas page-builder constraints, atomic design directory structure, Twig `include ... with {...} only` composition, Tailwind token discipline, theme build / lint pipeline (Stylelint, ESLint, TwigCS).

**Not covered** (expected gaps given narrow scope): hooks, services/DI, config management, entity API, migrations, caching, access control, security, testing beyond anti-pattern greps, accessibility (though SKILL.md's success criteria mention "accessible, responsive, themeable" testing). Single-workflow skill, not a broad Drupal frontend library.

## Q8 — Quality signals

Positive:

- **Phased orchestration**: Plan -> user approval gate (AskUserQuestion) -> Implement -> Validate. Human-in-the-loop before generation.
- **Single-pass fallback mode**: for agents without sub-agent support (Codex, Cursor) — author thinking about cross-agent portability.
- **Concrete verification**: shell script runs 16 grep-based checks (project-specific patterns are variables at top of the script — editable per project); 2 manual checks flagged for human review.
- **Explicit scratchpad paths**: `.claude/scratchpads/component-plan-{name}.md`, `.claude/scratchpads/validation-report-{name}.md` — reproducible artefacts per run.
- **Bounded retries**: "max 3 attempts" for build/lint/anti-pattern auto-fix loops; then documents remaining errors for human fix.
- **Canvas-specific insight**: calls out that unsupported prop types silently hide the entire component in Canvas UI — genuine field knowledge, not generic theming advice.
- **Separation of concerns**: generic rules in `shared-context.md`, project-specific values in `project-context.md`. User fills `project-context.md` from the `.example.md`. Clean pattern.
- **Tight scope + `disable-model-invocation: true`**: skill only runs when user invokes; no accidental triggering.
- **Recent activity**: last commit 2026-03-04 with "Fix skill installation instructions" — maintained.

Negative / concerns:

- **Single skill**: README promises "Drupal, AEM, performance optimization" but only one skill shipped. Roadmap, not library.
- **No tests / evals / CI**: no `.github/`, no evals directory, no test fixtures.
- **No license file at repo root** (INDEX reports "none"); README says MIT. Distribution risk.
- **Highly coupled to one stack**: Drupal Canvas + SDC + Tailwind + specific token names. Will not help projects not using Canvas.
- **Sub-agent pattern is Claude-Code-specific**: "Explore", "general-purpose" agent types. The "single-pass mode" section acknowledges this but the primary path is CC-only.
- **No `drupal-version`**: unclear whether Canvas prerequisites imply Drupal 10.x, 11.x, or both. (Canvas module itself is D10+.)
- **One script, bash-only**: `validate-antipatterns.sh` assumes a Unix shell. Windows users need WSL.

## Q11 — Compatibility with ai_best_practices LOCKED decisions

| Decision | Repo state | Verdict |
|----------|-----------|---------|
| Skill naming: gerund-prefix, verb-in-ing | `drupal-figma-to-canvas-sdc` (noun phrase, source-to-target) | **Conflict** |
| Directory: `skills/` at project root | Install path `.claude/skills/ai-fe-skills/<skill>/` (CC-specific, nested) | **Conflict** |
| Metadata: minimal — `drupal-version` + `status` only | Frontmatter carries `name`, `description`, `argument-hint`, `disable-model-invocation`. No `drupal-version`, no `status`. | **Conflict** |
| Distribution: Composer-installable | Manual `git clone` into `.claude/skills/`. No `composer.json`. | **Conflict** |
| Scope: universal Drupal guidance | Narrowly scoped to Canvas + SDC + Tailwind + Figma | **Conflict** |

**Every one of the five LOCKED decisions conflicts.** Harvesting into ai_best_practices would require: rename skill, move to `skills/` at project root, rewrite frontmatter metadata, add `composer.json` with skills installer, and either accept the specialised scope as an exception or factor the universal pieces (SDC directory mapping, BEM, golden rules) out of the Canvas/Figma workflow.

However, the **content** (Canvas prop-type rules, SDC directory conventions, anti-pattern list, BEM reinforcement, shared-vs-project context split) is substantive and directly reusable. The conflicts are packaging, not substance.

## Q13 — Verdict

**HARVEST CONTENT, NOT PACKAGING.** Useful reference for an eventual `building-drupal-sdc-components` or `generating-canvas-components` skill in the ai_best_practices ecosystem, but do not adopt as-is. Specifically harvest:

1. The **12 Golden Rules anti-pattern list** (`shared-context.md`) — several are universal SDC rules (never recreate atoms, always use `only`, BEM naming, no `!important`, omit empty `slots:`).
2. The **Canvas prop-type compatibility matrix** — if ai_best_practices ever adds a Canvas skill, this is the core value.
3. The **shared-context.md vs project-context.md split pattern** — generic rules + user-filled project values. Strong pattern worth imitating with the LOCKED `drupal-version` + `status` metadata approach.
4. The **Plan/Implement/Validate phase orchestration** with explicit user approval gate — good template for any generator-type skill.
5. The **`validate-antipatterns.sh` grep-based verification approach** — lightweight, bashable, CI-runnable.

Do NOT adopt the skill name, directory layout, frontmatter schema, or distribution mechanism — all five conflict with LOCKED decisions. Scope is also too narrow to count as "universal Drupal guidance."

**Rating**: B- as a standalone skill; valuable mining source, not a direct fit.
