# Analysis of prompt_library

1. **What problem does it solve?** 
According to `README.md`, it provides "A collection of AI prompts, rules (guidelines for development environments), project configurations, and workflow states across different disciplines." It solves the problem of organizing, categorizing, and sharing these AI assets by building them into a searchable static site built with 11ty and hosted on GitHub Pages.

2. **Primary artefact type**: 
Docs site / aggregator (an 11ty static site acting as a central library for prompts, rules, and agents).

3. **Distribution model**: 
Standalone git repo and Docs site (GitHub Pages). It is installed via `git clone`, followed by `npm install` and `npm start` for local development, or browsed directly on the web. It also exposes an auto-generated `llms.txt` for AI context.

4. **Standards conformance**: 
Proprietary format. The repository relies on custom Markdown files with Eleventy (11ty) YAML frontmatter (e.g., `layout: "markdown.njk"`, `discipline: "development"`) rather than standard formats. As noted in `INDEX.md`, it does not use the `agentskills.io` `SKILL.md` or `AGENTS.md` standards. It is multi-tool compatible, providing general prompts, a global `llms.txt`, and specific rules for Cursor (`.cursor/rules/*.mdc`).

7. **Coverage**: 
- Core coding standards & OOP hook patterns (`development/rules/drupal.md`)
- Twig, front-end theming, and Single-Directory Components (`development/rules/drupal.md`, `development/agents/drupal-frontend-engineer.md`)
- PHPUnit testing patterns (`development/rules/drupal.md`)
- Custom module, database schema, and API development (`development/agents/drupal-backend-specialist.md`)
- Drupal-specific code review (`development/prompts/drupal-code-review.md`)
- DDEV integration and resources (`development/resources/drupal-and-ddev-links.md`)

8. **Quality signals**: 
- **Last commit date**: 2026-04-15 (future-dated in git log).
- **Issue count**: Active activity implied by recent merge commit for PR #133.
- **Stars/watchers**: Not verifiable locally, but it is an organizational repo (`Lullabot/prompt_library`).
- **Tests**: None (`package.json` test script returns an error).
- **Eval harness**: None.
- **CI**: Present via GitHub Actions (`.github/workflows/deploy.yml` and `slack_submit.yml`).
- **Versioning discipline**: None (no git tags found).
- **Active maintainer**: Yes, active merge commits from Lullabot maintainers (e.g., Jerad Bitner).

11. **Compatibility with ai_best_practices' decisions**: 
Incompatible out of the box. The naming convention and directory structure are organized by broad disciplines (e.g., `development/`, `sales-marketing/`) rather than functional AI tools. The metadata relies on 11ty frontmatter instead of `AGENTS.md` or `SKILL.md` schemas. The scope is extremely broad, covering project management and design alongside development. To merge this content in, the Drupal-specific files would need to be extracted, stripped of their static-site frontmatter, and reformatted into the standard formats.

13. **One-paragraph verdict**: 
ai_best_practices should **absorb** the Drupal-specific content and **ignore** the rest. While the repository is an excellent organizational documentation site for Lullabot's diverse AI workflows, its 11ty-based architecture and broad non-technical scope make it unsuitable for direct collaboration or referencing. The high-quality Drupal rules (`development/rules/drupal.md`) and specialized agents (`development/agents/drupal-backend-specialist.md`) should be manually ported into standard `AGENTS.md` and `.cursor/rules` files for inclusion.