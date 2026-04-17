# Tier 3 — Read-only / Scan

One paragraph per entry, per the original spec. Evidence-based; flagged where the entry turned out to be out of scope or misnamed in the original spec.

---

## drupal.org/project/drupal_ai — EXISTS but is an empty placeholder (created 2026-04-16)

The drupal.org project page (`https://www.drupal.org/project/drupal_ai`, HTTP 200) exists; the git repository (`https://git.drupalcode.org/project/drupal_ai`) was created 2026-04-16 but has **no commits, no README, no branches** ("The repository for this project is empty"). `git ls-remote` returns zero refs. Project is one day old as of this research (today: 2026-04-17) and has no published scope yet. **Cannot be analysed — nothing to analyse.** Related but distinct: `drupal.org/project/ai` (slug: `ai`, without the `drupal_` prefix) DOES exist with code (`refs/heads/1.0.x`) and is the AI-for-sites module (chatbots, content suggestions, LLM integrations inside Drupal) — out of scope per the original spec's framing. Recommend re-checking `drupal_ai` once it publishes; for now, de-prioritise.

---

## drupal.org/project/drupal_devkit — EXISTS and is MAJOR. **Candidate for Tier 1 promotion — flagged for user decision before Phase 3 synthesis.**

`git ls-remote https://git.drupalcode.org/project/drupal_devkit.git` returns `main` + `worktree-phase-1.5-marketplace`; last commit **2026-04-17 03:38** (today — actively live-developed). Peek clone at `/tmp/drupal_devkit-peek`. README self-describes as: "Cross-harness Drupal AI coding toolkit. A **marketplace of marketplaces** for Drupal AI skills, built as the **reference implementation of `ai_best_practices`**" (README.md:3-5). Ships **36 bundled Drupal skills + a DDEV add-on + 3-layer eval harness (Gemma / Haiku / Opus)**; total skill count including bundled dependencies is **223 SKILL.md files**. Supports **8 Tier 1 AI coding harnesses** (Claude Code, Copilot CLI, Codex, Cursor, Gemini CLI, Kiro, OpenCode, Hermes) with dedicated emitters per harness and a `drupal-marketplace.json` conformance ladder (L0 heuristic → L3 eval coverage). Registered default marketplace sources include `ai_best_practices/ai_best_practices` itself (plugin `main`, ref `1.0.x`, 2 skills + 4 agents per README) and `drupal-canvas-plugin` (3 plugins, 25 skills). Same maintainer (AJV009) as `awesome-drupal-ai`. **This is the central integration point for the Drupal AI tooling landscape and almost certainly deserves full Tier 1 analysis — not a Tier 3 paragraph.** Reporting to user for decision.

---

## github.com/AJV009/awesome-drupal-ai — curated index, actively maintained

Curated "awesome" list (same maintainer, AJV009, as drupal_devkit). Catalogs "65+ modules · 15+ skill repos · 18+ DDEV plugins · 15+ MCP servers · 80+ skills" across 11 categories: Agent Skills & Repos, DDEV Plugins, MCP Servers, Drupal.org AI Modules, IDE & Editor Configurations, CLI Tools & Frameworks, Drupal Recipes for AI, Community Resources, Specifications & Standards, Cross-CMS Patterns. Each entry has maturity ratings (★★★★★ to ★) and brief descriptions. README last-updated March 2026; 12 commits, has CONTRIBUTING.md. **Use as an index**, not an analysis target. Serves the same role for this research as a map serves for a road trip: consult it, don't analyse it. Confirms our clone list is representative (we captured ~15 of the 15+ skill repos it indexes). No further action.

---

## zivtech.github.io/zivtech-demos/drupal-ai-skills-landscape.html — community landscape evaluation (Drupal AI Initiative, 27 Mar 2026)

Standalone HTML page by zivtech (Drupal agency) presenting a community landscape analysis under the Drupal AI Initiative banner. Core thesis: **"the biggest problem facing contributors isn't a missing skill" — it's fragmentation** across 40+ skills in scattered repos, without guidance on which to choose. Recommends a curated index mapping skills to quality tiers. Names: scottfalconer×4 (contribution workflow, UX intent testing, issue queue triage), madsnorgaard/drupal-agent-resources (security review, migration tools), grasmash/drupal-claude-skills (config management, OWASP security, Search API), jamieaa64/Drupal-DDEV-Setup (project lifecycle), zivtech/a11y-meta-skills (only accessibility skills in the ecosystem), ablerz/claude-skill-drupal-module (auto-updating via GitHub Actions), nonzod/drupaldev-claude-skill (multi-language coding standards), zivtech/drupal-meta-skills (architecture planning + code review). Proposes **Tier 1 standard skills** baseline: contribute-fix, intent-testing, accessibility pair. **Use as input to Phase 3 synthesis** — it's the existing landscape analysis that ai_best_practices must build on. Two names not in our Tier 1/2 clone list: `nonzod/drupaldev-claude-skill` and `zivtech/a11y-meta-skills` + `zivtech/drupal-meta-skills` (zivtech-drupal-critic is already cloned — critic appears to have been consolidated into drupal-meta-skills per our Tier 2 analysis). **Gap flagged for user**: should we also clone the two missing zivtech meta-skill repos and nonzod? They appear in the landscape but not in our research set.

---

## skills.sh/?q=drupal — NO Drupal-specific skills listed

Community-driven platform (`npx skillsadd <owner/repo>` install model) showing a leaderboard of 260 skills ranked by install count. Search for "drupal" returns **zero results** in the visible listing. Directory is user-submitted (GitHub-style owner/repo), dominated by Vercel, Microsoft, Google, Firebase, anthropics entries. Confirms that at the time of writing, the broader (tool-agnostic) Agent Skills ecosystem has **no prominent Drupal-specific listings** — the Drupal AI tooling scene is currently Drupal-native (drupal.org, Drupal vendors) rather than propagating outward. Worth revisiting in 6 months; for now, a factual negative result.
