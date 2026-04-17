# Research: Drupal AI Tooling Landscape Synthesis

## Context

The Drupal AI Best Practices initiative (drupal.org/project/ai_best_practices,
owned by webchick, created 26 Mar 2026) is collecting pointers to repos trying
to solve overlapping problems: agent skills, contribution helpers, AI workflow
integrations, prompt libraries, testing harnesses.

Goal: produce a spec for ai_best_practices that identifies the best pieces of
each, where they overlap, where they diverge, and what a consolidated approach
should look like.

## Existing state you must know before starting

ai_best_practices has already made some design decisions (see the issue queue
at drupal.org/project/ai_best_practices/issues). Do NOT re-litigate these —
the spec must build on them:

- **Skill naming**: gerund-prefix, verb-in-ing form (e.g.
  `writing-automated-tests`, `avoiding-security-vulnerabilities`,
  `creating-merge-requests`). Set in issue #3581836.
- **Directory**: `skills/` at project root. Follows agentskills.io convention.
- **Metadata**: Minimal. Probably just `drupal-version` + `status`
  (draft/stable/contested). Explicitly reject `last-reviewed` as duplicating Git.
- **Distribution**: Composer-installable package (see README).
- **Scope**: universal guidance across Drupal projects, not project-specific.

The adjacent ecosystem context (verify by fetching, don't assume):

- **Surge** (drupal.org/project/surge) is a Composer-plugin aggregator that
  pulls skills from multiple sources into `.claude/skills/` and generates
  AGENTS.md. It is tool-agnostic. Treat as likely distribution partner, not
  competitor.
- **ai_skills** (drupal.org/project/ai_skills) is marked UNSUPPORTED and has
  redirected users to ai_best_practices. Skip deep analysis — fetch only to
  extract skill content worth absorbing.
- **agentskills.io** is the emerging open standard for skill format. 30+ tools
  support it (Claude Code, Cursor, Codex, OpenCode, etc.). AGENTS.md is the
  corresponding universal context-file standard.
- **Proposal #3565489** on the ai module queue proposed first-class skill
  support in Drupal core/contrib (composer-based scaffolding, per-module skill
  folders). Read it — it frames several architectural debates.

## Repos to research

Tier 1 — direct scope overlap (deep analysis):
- https://www.drupal.org/project/surge (infrastructure/aggregator — special role)
- https://www.drupal.org/project/aidev
- https://github.com/grasmash/drupal-claude-skills
- https://github.com/madsnorgaard/drupal-agent-resources
- https://github.com/gkastanis/drupal-workflow
- https://github.com/gxleano/drupal-agentic-workflow
- https://github.com/ablerz/claude-skill-drupal-module
- https://github.com/drupaltools/skills (if it exists — verify; may be stale link)

Tier 2 — specialised/narrower (lighter analysis):
- https://github.com/scottfalconer/drupal-intent-testing
- https://github.com/scottfalconer/drupal-contribute-fix
- https://github.com/Simply007/drupalcon-chicago-26-ckeditor-ai-playground
- https://github.com/Lullabot/prompt_library (look specifically at Drupal-
  relevant prompts; repo is broader)
- https://github.com/ivanboring/drupal-issue-hygiene-helper
- https://github.com/ronaldtebrake/drupal-coding-standards-skill
- https://github.com/zivtech/drupal-critic
- https://github.com/jamieaa64/Drupal-DDEV-Setup-Claude-Skill
- https://github.com/drupal-canvas/skills
- https://github.com/Omedia/drupal-skill
- https://github.com/aldunchev/ai-fe-skills

Tier 3 — read-only / scan:
- https://www.drupal.org/project/drupal_ai (different scope: AI-for-sites, not
  AI-for-developing-Drupal — confirm and flag if out of scope for this research)
- https://www.drupal.org/project/drupal_devkit (VERIFY THIS EXISTS — searches
  suggest the link in the issue may be wrong)
- https://github.com/AJV009/awesome-drupal-ai (directory — use as index, not target)
- https://zivtech.github.io/zivtech-demos/drupal-ai-skills-landscape.html
- https://skills.sh/?q=drupal

Special case — dead but historically informative:
- https://www.drupal.org/project/ai_skills (unsupported, redirected to
  ai_best_practices; fetch once, extract any skill content worth absorbing,
  then skip)

## Workflow

Phase 1 — Acquisition (mechanical, do first)

1. Create `research/repos/` directory.
2. For each Tier 1 and Tier 2 entry:
   - GitHub → `git clone --depth 1` into `research/repos/<slug>`
   - drupal.org project → clone from `https://git.drupalcode.org/project/<name>.git`
     (e.g. `git.drupalcode.org/project/surge.git`). The drupal.org URLs are
     human-facing; the git remotes are on drupalcode.org.
   - If the git clone fails or the drupal.org project does not exist, log it
     in `research/acquisition-failures.md` and move on. Do NOT fabricate
     content for missing repos.
3. For each cloned repo, generate a deterministic structural index:
   - File tree (depth 3, excluding .git, node_modules, vendor)
   - File type counts
   - Presence/absence of: `CLAUDE.md`, `AGENTS.md`, `skills/`, `.claude/skills/`,
     `agents/`, `commands/`, `hooks/`, `.claude/`, `prompts/`, `evals/`,
     `composer.json`, `package.json`, `skills.yaml`, `SKILL.md` files
   - First 200 lines of README
   - License
   - Last commit date (use `git log -1 --format=%ci`)
   - Skill count (count of `SKILL.md` files)
4. Write `research/repos/<slug>/INDEX.md` with the above. This is the ground
   truth for Phase 2.

Do not skip Phase 1. The deterministic index is ground truth; the semantic
analysis in Phase 2 cannot be trusted without it.

Phase 2 — Per-repo analysis

Spawn sub-agents in batches of 3 (not all parallel — context management). For
each Tier 1 repo, spawn with this brief:

> Analyse the repo at `research/repos/<slug>`. You have INDEX.md as ground
> truth. Produce `research/repos/<slug>/ANALYSIS.md` answering these
> questions in order. If a question is not applicable, say so — do not
> invent content. Cite specific file paths for every claim.
>
> 1. **What problem does it solve?** One paragraph, in the author's framing
>    (quote or paraphrase the README).
> 2. **Primary artefact type**: skills / agents / commands / hooks / prompts /
>    module / CLI tool / docs / aggregator / other. Be specific.
> 3. **Distribution model**: Drupal contrib module, Claude Code plugin, npm
>    package, Composer package, standalone git repo, docs site? Does it
>    install via `agr`, `skills.sh`, `composer require`, `git clone`, or
>    something else?
> 4. **Standards conformance**: Does it use agentskills.io-format SKILL.md?
>    AGENTS.md? Proprietary format? Multi-tool compatible (Claude/Cursor/
>    Codex/Gemini) or single-tool?
> 5. **Architectural pattern**: How does it structure AI guidance? Flat skill
>    dump, routing layer + selective load, semantic index, 3-layer
>    deterministic-then-semantic, skills-manifest, agents-with-tool-use,
>    other? Be specific about how context is loaded at runtime.
> 6. **Naming convention**: gerund-prefix (writing-tests), noun (testing),
>    hyphenated, other? Does it align with ai_best_practices' gerund choice
>    or diverge?
> 7. **Coverage**: which Drupal topics? (entity API, form API, render API,
>    testing, security, performance, multisite, decoupled, DDEV, coding
>    standards, contribution workflow, etc.) List concretely — one line per
>    covered topic with the file that covers it.
> 8. **Quality signals**: last commit date, issue count, stars/watchers, tests,
>    eval harness, CI, versioning discipline, active maintainer.
> 9. **Notable innovations**: anything genuinely novel that other tools in
>    this landscape don't have? Be concrete.
> 10. **Weaknesses / gaps**: be direct. Outdated content? Missing topics?
>     Drupal-version lock-in? Single-tool lock-in? Abandoned?
> 11. **Compatibility with ai_best_practices' decisions**: naming convention,
>     directory, metadata, scope. What would need to change to merge it in?
> 12. **Relationship to Surge**: does Surge aggregate this? Could it? Any
>     conflict?
> 13. **One-paragraph verdict**: should ai_best_practices **absorb** (pull
>     content in), **reference** (link out to), **collaborate** (joint
>     maintenance), or **ignore** this?
>
> Rules: quote file paths for all claims. No hand-waving. "Confident but
> wrong" is the default failure mode for this kind of analysis — if you are
> not sure, flag it. If a repo is abandoned (last commit >12 months) say so
> in question 8 and de-emphasise the rest.

For Tier 2 repos: same brief, but questions 1–4, 7, 8, 11, 13 only.

For Tier 3: one paragraph in `research/tier3.md` per entry, no sub-agent.

Phase 3 — Cross-repo synthesis

After all ANALYSIS.md files exist, produce `research/SYNTHESIS.md`. Do NOT
re-summarise each repo. Instead:

1. **Landscape map** — a table: rows = repos, columns = artefact types
   (skills / agents / commands / hooks / prompts / eval / module / aggregator).
   Marks show what each repo provides. Include skill count per repo.
2. **Standards conformance map** — who uses agentskills.io SKILL.md? AGENTS.md?
   Proprietary? This determines mergeability.
3. **Pattern clusters** — group repos by architectural approach. Derive the
   clusters from the Phase 2 analyses; do not assume a fixed taxonomy.
4. **Coverage matrix** — rows = Drupal topics (from the union of coverage
   lists), columns = repos. Shows who covers what. Identify the
   topics-no-one-covers (gaps ai_best_practices can fill) and the
   topics-everyone-covers (candidates for absorb-and-consolidate).
5. **Overlap and conflict analysis** — where do tools duplicate each other?
   Where would combining cause conflicts (two skills giving contradictory
   advice on the same topic)? Flag specific examples with file paths.
6. **Best-in-class picks per dimension**:
   - Best structural/routing pattern (how skills load on demand)
   - Best eval/testing approach
   - Best per-topic skill content (which specific SKILL.md files are
     high-quality enough to absorb verbatim)
   - Best agent definitions
   - Best hooks/quality gates
   - Best distribution/install story
   - Best multi-tool compatibility approach

For every best-in-class pick, cite the specific file path that justifies it.
Picks must be defensible from the Phase 2 analyses alone — if two repos are
close, say so and pick on evidence, not preference.

Phase 4 — Spec draft

Write `research/SPEC.md` — a proposal for ai_best_practices to post in its
issue queue. Structure:

1. Problem statement (why consolidation matters — brief, one paragraph)
2. Current ai_best_practices decisions recap (naming, structure, distribution)
3. Proposed architecture — how ai_best_practices absorbs best-in-class picks
   while preserving existing design decisions
4. **Per-repo disposition table** — 3 columns: repo | recommendation (absorb /
   reference / collaborate / ignore) | specific action items
5. **Relationship with Surge** — explicitly: is ai_best_practices a content
   source that Surge aggregates, or does it overlap with Surge? Take a
   position.
6. **Migration/compatibility story** — for existing users of the various
   ecosystem tools
7. **Open questions** for discussion in the issue queue
8. **Out of scope** — be explicit

Keep it under 2500 words. Discussion starter, not final design.

## Ground rules

- Phase 1 is mechanical. Do not skip it.
- Per-repo claims must cite file paths. "The README says X" is not enough;
  "`skills/entity-api/SKILL.md` claims X at line 42" is.
- Synthesis references the per-repo analyses, not re-derived from raw repos.
- If a repo is abandoned (>12 months), flag and de-prioritise.
- If drupal.org project and GitHub fork both exist, note both; evaluate the
  more active one.
- Apply the same rubric to every repo. Verdicts must be grounded in the
  evidence from Phase 2, not in which repo is more familiar or prominent.
- Do not re-litigate ai_best_practices' existing decisions (gerund naming,
  skills/ directory, minimal metadata). The spec builds on them.
- If a link in Tier 3 leads to a non-AI project or 404, document that and
  move on. Do not invent content for missing repos.

## Deliverables

- `research/repos/<slug>/INDEX.md` × N (deterministic)
- `research/repos/<slug>/ANALYSIS.md` × N (semantic, Tier 1 full, Tier 2 lite)
- `research/tier3.md`
- `research/acquisition-failures.md` (if any)
- `research/SYNTHESIS.md`
- `research/SPEC.md`

Start with Phase 1. Confirm the clone list and directory structure before
proceeding to Phase 2. Report back after Phase 1 with the acquisition-failures
list, so I can sanity-check before spending context on analysis.
