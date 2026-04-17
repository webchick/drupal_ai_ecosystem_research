# Analysis: prompt_library

1. **What problem does it solve?**  
This repo is a broad publishing library for AI prompts, rules, project configs, workflow states, and agent definitions across multiple disciplines, not just Drupal. `README.md` frames it as an 11ty-backed collection of reusable AI guidance, while the Drupal-specific slice lives under `development/` in files like `development/prompts/drupal-code-review.md`, `development/rules/drupal-standards.md`, `development/rules/drupal.md`, and `development/resources/drupal-and-ddev-links.md`.

2. **Primary artefact type**  
Prompts, rules, agents, and docs site content. The main artefacts are Markdown files rendered into a static site via `README.md`, `development/prompts/drupal-code-review.md`, `development/rules/drupal-standards.md`, `development/rules/drupal.md`, and `development/agents/drupal-backend-specialist.md`.

3. **Distribution model**  
Standalone GitHub repo plus GitHub Pages site. `README.md` describes local install via `npm install`, `npm start`, and `npm run build`, and `REPO_METADATA.md` records the homepage as `https://lullabot.github.io/prompt_library/`. This is not distributed as a Composer package or Drupal contrib project.

4. **Standards conformance**  
Low for ai_best_practices mergeability. `INDEX.md` records no `AGENTS.md` and zero `SKILL.md` files. The repo does have `CLAUDE.md`, `.cursor/rules/*.mdc`, `llms.txt`, and discipline-specific `agents/` and `skills/` content, but it is not primarily using the agentskills.io `skills/<name>/SKILL.md` library structure.

7. **Coverage**  
- Drupal code review checklist and review prompt: `development/prompts/drupal-code-review.md`  
- Drupal coding standards, dependency injection, hooks, logging, JSON handling: `development/rules/drupal-standards.md`  
- Drupal core rules, theme rules, testing rules, and Cursor-style `.mdc` patterns: `development/rules/drupal.md`  
- Drupal and DDEV reference links plus AI-doc-context guidance: `development/resources/drupal-and-ddev-links.md`  
- Drupal-focused agent roles: `development/agents/drupal-backend-specialist.md`, `development/agents/drupal-frontend-engineer.md`, `development/agents/testing-qa-engineer.md`

8. **Quality signals**  
- Last commit date: `INDEX.md` records `2026-04-15 09:49:40 -0700`.  
- Issue count: `REPO_METADATA.md` records 5 open issues.  
- Stars/watchers: `REPO_METADATA.md` records 0 stars and 4 watchers.  
- CI: `INDEX.md` shows `.github/workflows/deploy.yml` and `.github/workflows/slack_submit.yml`.  
- Versioning discipline: lightweight; no releases/changelog are evident in the indexed top level.  
- Maintainer signal: active and recent, with clear site-generation and submission workflows in `README.md` and `.github/ISSUE_TEMPLATE/`.

11. **Compatibility with ai_best_practices' decisions**  
Partial at best. The Drupal content is reusable, but the repo is broader than Drupal, broader than skills, and broader than universal project guidance. To merge cleanly, any adopted material would need to be extracted from `development/prompts/` and `development/rules/`, rewritten into gerund-named skills under `skills/`, and stripped of Cursor- or site-specific framing from files like `development/rules/drupal.md` and `development/resources/drupal-and-ddev-links.md`.

13. **One-paragraph verdict**  
**Reference**. `prompt_library` is useful as a source of Drupal-flavored prompt text and rule phrasing, especially `development/prompts/drupal-code-review.md` and `development/rules/drupal-standards.md`, but it is not a Drupal-best-practices skill library and should not be merged wholesale. ai_best_practices can selectively absorb ideas or snippets while treating this repo primarily as adjacent prompt-library prior art.
