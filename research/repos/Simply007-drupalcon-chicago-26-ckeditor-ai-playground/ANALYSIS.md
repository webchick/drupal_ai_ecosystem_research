# ANALYSIS — Simply007-drupalcon-chicago-26-ckeditor-ai-playground

**Tier**: 2 LITE
**Source**: https://github.com/Simply007/drupalcon-chicago-26-ckeditor-ai-playground
**Last commit**: 2026-04-13
**Scope evaluated**: single demo repo artefact from DrupalCon Chicago 2026 Lightning Talk by Ondrej Chrastina

---

## Q1. Problem solved

Demonstrates how to "vibe-code" a Drupal custom module that extends CKEditor 5 with a custom plugin, using Claude Code and two guidance assets (`SKILL.md` + `PROMPT.md`). The concrete problem addressed is the **DLL bundling gotcha**: raw ES modules fail in Drupal CKEditor 5 because the integration expects a UMD bundle exporting to `CKEditor5.{namespace}` (fail mode: `Uncaught SyntaxError: Cannot use import statement outside a module` — `Article.md:61`, `SKILL.md:177-189`).

Citations:
- `/home/pointblank/research/repos/Simply007-drupalcon-chicago-26-ckeditor-ai-playground/README.md:86-127`
- `/home/pointblank/research/repos/Simply007-drupalcon-chicago-26-ckeditor-ai-playground/Article.md:1-48`
- `/home/pointblank/research/repos/Simply007-drupalcon-chicago-26-ckeditor-ai-playground/OUTLINE.md:1-78`

## Q2. Primary artefact type

**Working Drupal module + a single ad-hoc `SKILL.md` guidance document + a `PROMPT.md` template.** Not a skill library, not a collection — it is a **reference/demo repository** that ships one runnable example (`ckeditor5_timestamp`) alongside prose guidance for Claude Code to recreate similar plugins.

Module artefacts:
- `/home/pointblank/research/repos/Simply007-drupalcon-chicago-26-ckeditor-ai-playground/ckeditor5_timestamp.info.yml`
- `/home/pointblank/research/repos/Simply007-drupalcon-chicago-26-ckeditor-ai-playground/ckeditor5_timestamp.ckeditor5.yml`
- `/home/pointblank/research/repos/Simply007-drupalcon-chicago-26-ckeditor-ai-playground/ckeditor5_timestamp.libraries.yml`
- `/home/pointblank/research/repos/Simply007-drupalcon-chicago-26-ckeditor-ai-playground/src/Plugin/CKEditor5Plugin/` (PHP plugin class)
- `/home/pointblank/research/repos/Simply007-drupalcon-chicago-26-ckeditor-ai-playground/js/ckeditor5_plugins/timestamp/` + `/home/pointblank/research/repos/Simply007-drupalcon-chicago-26-ckeditor-ai-playground/js/build/timestamp.js`

AI-guidance artefacts:
- `/home/pointblank/research/repos/Simply007-drupalcon-chicago-26-ckeditor-ai-playground/SKILL.md` (single file)
- `/home/pointblank/research/repos/Simply007-drupalcon-chicago-26-ckeditor-ai-playground/PROMPT.md`

## Q3. Distribution model

**Manual copy into a Drupal install.** No `composer.json`, no `drupal.org` project listing, no installer. Instructions explicitly direct the user to `cp -r ckeditor5_timestamp /path/to/drupal/web/modules/custom/` (`README.md:102-106`). The SKILL/PROMPT pair is designed to be hand-copied into a user's project or Claude Code memory (`PROMPT.md:103-105` — "Copy SKILL.md to your project or Claude Code memory").

No Composer-based distribution path exists. INDEX confirms `composer.json: absent`.

## Q4. Standards conformance + independent skill-unit convention detection

**Independent detection** (running `ls` + reading `SKILL.md`):

- **Count**: exactly **one** `SKILL.md` at repo root (INDEX line 42-48; confirmed by tree).
- **Filename convention**: uppercase `SKILL.md` (not `skill.md`, not `skill.yaml`).
- **Naming of the skill inside**: `# SKILL: Extending CKEditor 5 with Custom Plugins in Drupal` (`SKILL.md:1`) — a **sentence-style title**. "Extending" is a gerund in grammatical form, but there is no slug, no directory, no frontmatter.
- **No YAML frontmatter** — the file is pure Markdown with H1/H2 headings. No `description`, `drupal-version`, `status`, or other metadata fields.
- **No directory wrapper** — the SKILL file lives at the repo root, not under `skills/<name>/SKILL.md`. `skills/` directory is **absent** (INDEX line 26).
- **No `allowed-tools`, no `license`, no schema reference.**

Standards conformance: this repo **predates / ignores** the Anthropic Agent Skills packaging convention (directory + frontmatter). It is a one-off conference demo asset, not a publishable skill unit.

## Q7. Coverage — Drupal topics with file paths

Very narrow. Single-topic.

| Topic | File | Notes |
|---|---|---|
| Drupal module scaffolding (`.info.yml`) | `SKILL.md:98-106`, `ckeditor5_timestamp.info.yml` | Minimal `name`/`type`/`description`/`package`/`core_version_requirement` template |
| CKEditor 5 plugin registration | `SKILL.md:108-122`, `ckeditor5_timestamp.ckeditor5.yml` | Plugin def, toolbar item, `elements: false` |
| Drupal JS libraries API | `SKILL.md:124-132`, `ckeditor5_timestamp.libraries.yml` | `core/ckeditor5` dependency, `{ minified: true }` |
| CKEditor 5 JS plugin class (ES module source) | `SKILL.md:134-173`, `js/ckeditor5_plugins/timestamp/` | ButtonView, componentFactory, `model.change` |
| **CKEditor 5 DLL/UMD bundling** (the core insight) | `SKILL.md:175-189`, `js/build/timestamp.js`, `webpack.config.js` | The unique Drupal-specific gotcha |
| PHP plugin class (`CKEditor5PluginDefault`) | `SKILL.md:191-208`, `src/Plugin/CKEditor5Plugin/Timestamp.php` | Minimal passthrough subclass |
| Drush enablement + cache rebuild | `SKILL.md:240-244`, `README.md:109-114` | `drush en` + `drush cr` |
| Text-format/toolbar configuration | `README.md:116-122` | Admin workflow only, no code |
| Troubleshooting (3 common errors) | `SKILL.md:228-248` | Import-statement, plugin-not-found, button not appearing |
| MCP tooling references (Context7, WebFetch) | `SKILL.md:34-50`, `OUTLINE.md:151-154` | Mentions tools, doesn't provide skill |

**Not covered**: entities, services/DI, hooks, forms, routing, access, caching, configuration management, migrations, tests, coding standards, Twig, security, performance, multisite, upgrade paths. The repo is single-purpose: *one* plugin, *one* editor integration, *one* gotcha.

## Q8. Quality signals

**Positive**
- Working, runnable module — not just prose. Verifiable via `drush en ckeditor5_timestamp`.
- Grounded in a real failure mode (DLL bundling) that genuinely trips up real Drupal developers.
- Clear provenance: named author (Ondrej Chrastina / CKEditor booth), named technical reviewer (Wojtek Kukowski, maintainer of CKEditor Drupal integration) — `OUTLINE.md:17-19`, `Article.md:11`.
- Correct `core_version_requirement: '^10.1 || ^11'` — realistic.
- Narrates its own development process honestly, including the bug encountered (`OUTLINE.md:58-78`).

**Negative / neutral**
- Zero automated tests, zero CI — `.github/` exists but nothing in it suggests CI configuration was exercised.
- `package-lock.json` present (165 KB) but no `package.json` build script documented in SKILL.md — the bundling story is prescriptive, not reproducible.
- Single-SKILL repo: no structure, no taxonomy, no versioning of the guidance.
- `SKILL.md` contains a **massive minified UMD blob** (`SKILL.md:188`) inline as a template — fragile, not maintainable, not parameterised. Expecting Claude to produce that from placeholder substitution is optimistic.
- No metadata, no frontmatter, no machine-readable contract — impossible to ingest programmatically.
- License file present but shallow — `LICENSE` is 264 bytes, likely MIT stub.
- Last commit is titled `Create drupal-ai-infographics.md` — housekeeping, not substantive work.

## Q11. Compatibility with ai_best_practices decisions

| Decision | Repo | Compatible? |
|---|---|---|
| Skill naming: gerund-prefix, verb-in-ing | Single file `SKILL.md`, H1 "Extending CKEditor 5 with Custom Plugins in Drupal" — coincidentally uses a gerund ("Extending") in prose form, but **no slug**, no directory name to check | Partial — prose style is close, no canonical slug exists |
| Directory: `skills/` at project root | `skills/` **absent**; single root-level `SKILL.md` | **Incompatible** |
| Metadata: minimal — `drupal-version` + `status` | **No frontmatter, no metadata at all** | **Incompatible** — must be added from scratch |
| Distribution: Composer-installable | No `composer.json` | **Incompatible** — pure `cp -r` workflow |
| Scope: universal Drupal guidance | Scope is narrow and specific (CKEditor 5 plugin authoring), not universal | **Partial** — would fit as a *single* skill within a universal library, not as a library itself |

**Net**: the repo does **not** align with any of the five locked decisions, but it also doesn't conflict with them — it would need to be repackaged wholesale. The *content* inside `SKILL.md` is the only reusable asset, and it would become one skill slug (e.g. `authoring-ckeditor5-plugin`) inside a larger `skills/` tree.

## Q13. Verdict

**Reference, not content.** As the caller anticipated, this is a DrupalCon Chicago 2026 demo artefact with high narrative value and low toolkit value. It contributes:

1. **One genuinely useful nugget** — the DLL/UMD bundling gotcha (`SKILL.md:175-189`) is the kind of hard-won specific knowledge that belongs in any "authoring-ckeditor-plugin" skill. Worth lifting verbatim.
2. **A working sample module** — useful as a fixture/example for a skill, not as a skill itself.
3. **A conference talk framing** — persuasive evidence that vibe-coding Drupal modules works, but no reusable scaffolding for a universal ai_best_practices distribution.

**Recommendation**: Do not adopt structurally. When building the CKEditor-plugin-authoring skill (if that scope makes the cut), borrow the DLL explanation and the file-layout template as *source material* for one gerund-named skill, and cite this repo as prior art. Otherwise skip.

**Tier 2 LITE rating**: low-medium value. One insight, zero reusable scaffolding.
