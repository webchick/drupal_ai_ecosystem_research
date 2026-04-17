# prompt_library Index

## Repo Facts

- Path: /Users/webchick/Documents/Codex/2026-04-17-research-drupal-ai-tooling-landscape-synthesis-2/research/repos/prompt_library
- Last commit date: 2026-04-15 09:49:40 -0700
- Skill count (SKILL.md): 0

## Presence / Absence

- CLAUDE.md: yes
- AGENTS.md: no
- skills/: yes
- .claude/skills/: no
- agents/: yes
- commands/: no
- hooks/: no
- .claude/: yes
- prompts/: yes
- evals/: no
- composer.json: no
- package.json: yes
- skills.yaml: no
- Any SKILL.md files: no

## File Tree (Depth 3)

~~~text
.
./.claude
./.claude/settings.local.json
./.cursor
./.cursor/rules
./.cursor/rules/core.mdc
./.cursor/rules/github-issue-creation.mdc
./.cursor/rules/memory-bank.mdc
./.cursor/rules/project-guidelines.mdc
./.cursor/rules/prompt-library-requirements.mdc
./.eleventy.js
./.eleventyignore
./.github
./.github/ISSUE_TEMPLATE
./.github/ISSUE_TEMPLATE/agent-submission.yml
./.github/ISSUE_TEMPLATE/bug_report.md
./.github/ISSUE_TEMPLATE/config.yml
./.github/ISSUE_TEMPLATE/documentation_update.md
./.github/ISSUE_TEMPLATE/feature_request.md
./.github/ISSUE_TEMPLATE/performance_issue.md
./.github/ISSUE_TEMPLATE/project-config-submission.yml
./.github/ISSUE_TEMPLATE/prompt-submission.yml
./.github/ISSUE_TEMPLATE/resource-submission.yml
./.github/ISSUE_TEMPLATE/rule-submission.yml
./.github/ISSUE_TEMPLATE/skill-submission.yml
./.github/ISSUE_TEMPLATE/workflow-state-submission.yml
./.github/PULL_REQUEST_TEMPLATE.md
./.github/copilot-instructions.md
./.github/workflows
./.github/workflows/deploy.yml
./.github/workflows/slack_submit.yml
./.gitignore
./.tugboat
./.tugboat/config.yml
./CLAUDE.md
./INDEX.md
./README.md
./_data
./_data/search-index.js
./_includes
./_includes/base.njk
./_includes/content-type-styles.njk
./_includes/content-type.njk
./_includes/discipline.njk
./_includes/search.njk
./_layouts
./_layouts/base.njk
./_layouts/content-type.njk
./_layouts/discipline.njk
./_layouts/markdown.njk
./agents
./agents/index.njk
./assets
./assets/css
./assets/css/styles.css
./assets/images
./assets/images/prompt_library.png
./assets/js
./assets/js/main.js
./assets/js/theme.js
./content-strategy
./content-strategy/agents
./content-strategy/agents/content-optimization.md
./content-strategy/agents/index.njk
./content-strategy/index.njk
./content-strategy/project-configs
./content-strategy/project-configs/index.njk
./content-strategy/prompts
./content-strategy/prompts/index.njk
./content-strategy/rules
./content-strategy/rules/index.njk
./content-strategy/rules/lullabot-voice-and-tone-styleguide.md
./content-strategy/skills
./content-strategy/skills/humanizer.md
./content-strategy/skills/index.njk
./content-strategy/skills/slack-markdown-formatter
./content-strategy/skills/slack-markdown-formatter.md
./contributing.njk
./design
./design/agents
./design/agents/index.njk
./design/index.njk
./design/project-configs
./design/project-configs/index.njk
./design/prompts
./design/prompts/index.njk
./design/rules
./design/rules/index.njk
./design/skills
./design/skills/index.njk
./design/skills/nano-banana-prompt.md
./design/skills/pencil-designer
./design/skills/pencil-designer.md
./development
./development/agents
./development/agents/code-review-assistant.md
./development/agents/drupal-backend-specialist.md
./development/agents/drupal-frontend-engineer.md
./development/agents/github-assistant.md
./development/agents/index.njk
./development/agents/module-readme-maintainer.md
./development/agents/testing-qa-engineer.md
./development/index.njk
./development/project-configs
./development/project-configs/11ty-setup.md
./development/project-configs/drupal-setup.md
./development/project-configs/index.njk
./development/project-configs/pre_action_prompt.mdc.txt
./development/prompts
./development/prompts/adr.md
./development/prompts/ai-code-review.md
./development/prompts/drupal-code-review.md
./development/prompts/index.njk
./development/resources
./development/resources/basic-prompting.md
./development/resources/drupal-and-ddev-links.md
./development/resources/index.njk
./development/rules
./development/rules/code-quality.md
./development/rules/drupal-standards.md
./development/rules/drupal.md
./development/rules/index.njk
./development/skills
./development/skills/cloudflare-tunnel
./development/skills/cloudflare-tunnel.md
./development/skills/github-wiki
./development/skills/github-wiki.md
./development/skills/gws-cli.md
./development/skills/htmx-expert.md
./development/skills/index.njk
./development/skills/resolve-composer-conflicts.md
./development/skills/tugboat-cli
./development/skills/tugboat-cli.md
./help.njk
./index.njk
./llms.txt
./memory-bank
./memory-bank/activeContext.md
./memory-bank/productContext.md
./memory-bank/progress.md
./memory-bank/projectbrief.md
./memory-bank/systemPatterns.md
./memory-bank/techContext.md
./package-lock.json
./package.json
./project-management
./project-management/agents
./project-management/agents/index.njk
./project-management/agents/meeting-facilitator.md
./project-management/index.njk
./project-management/project-configs
./project-management/project-configs/index.njk
./project-management/prompts
./project-management/prompts/idea-crucible.md
./project-management/prompts/index.njk
./project-management/prompts/meeting-action-items.md
./project-management/prompts/meeting-notes-extraction.md
./project-management/prompts/project-journal-entry.md
./project-management/prompts/readable-zoom-transcripts.md
./project-management/prompts/summarize-this.md
./project-management/prompts/voice-guide.md
./project-management/rules
./project-management/rules/index.njk
./project-management/skills
./project-management/skills/index.njk
./project_config.md
./prompts
./prompts/index.njk
./quality-assurance
./quality-assurance/agents
./quality-assurance/agents/index.njk
./quality-assurance/project-configs
./quality-assurance/project-configs/index.njk
./quality-assurance/prompts
./quality-assurance/prompts/index.njk
./quality-assurance/prompts/qa-test-checklist.md
./quality-assurance/rules
./quality-assurance/rules/index.njk
./quality-assurance/skills
./quality-assurance/skills/index.njk
./renovate.json
./resources
./resources/index.njk
./rules
./rules/index.njk
./sales-marketing
./sales-marketing/agents
./sales-marketing/agents/index.njk
./sales-marketing/index.njk
./sales-marketing/project-configs
./sales-marketing/project-configs/index.njk
./sales-marketing/prompts
./sales-marketing/prompts/create-natm-from-rfp.md
./sales-marketing/prompts/index.njk
./sales-marketing/rules
./sales-marketing/rules/index.njk
./sales-marketing/rules/no-corrective-contrast-pattern.md
./sales-marketing/skills
./sales-marketing/skills/index.njk
./sales-marketing/skills/seo-expert
./sales-marketing/skills/seo-expert.md
./skills
./skills/index.njk
./test.njk
./workflow_state.md
~~~

## File Type Counts

~~~text
.css	1
.js	4
.json	4
.md	73
.mdc	5
.njk	54
.png	1
.py	10
.sh	5
.txt	2
.yml	11
[dotfile-no-ext]	2
~~~

## README (First 200 Lines)

Source: README.md

~~~text
# Prompt Library

A collection of AI prompts, rules (guidelines for development environments), project configurations, and workflow states across different disciplines. Built with 11ty and hosted on GitHub Pages.

![Screenshot of the Prompt Library showing the Development AI Prompts page](assets/images/prompt_library.png)

## Features

- Clean, modern design
- Responsive layout
- Easy navigation
- Search functionality
- Content categorization by discipline
- Markdown support

## Getting Started

### Prerequisites

- Node.js (v16 or higher)
- npm or yarn
- Git

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/prompt-library.git
cd prompt-library
```

2. Install dependencies
```bash
npm install
```

3. Start the development server
```bash
npm start
```

4. Build for production
```bash
npm run build
```

## Project Structure

```
├── _data/              # Global data files
├── _includes/          # Includes and partials
├── _layouts/           # Page templates
│   ├── base.njk        # Base layout
│   ├── discipline.njk  # Discipline-specific layout
│   └── content-type.njk # Content type layout
├── assets/             # Static assets
│   ├── css/           # Stylesheets
│   ├── js/            # JavaScript files
│   └── images/        # Image assets
├── development/        # Development discipline content
│   ├── prompts/       # Development prompts
│   ├── rules/  # Development rules
│   ├── project-configs/ # Development project configs
│   └── workflow-states/ # Development workflow states
├── project-management/ # Project Management discipline content
│   ├── prompts/
│   ├── rules/
│   ├── project-configs/
│   └── workflow-states/
├── sales-marketing/    # Sales & Marketing discipline content
│   ├── prompts/
│   ├── rules/
│   ├── project-configs/
│   └── workflow-states/
├── content-strategy/   # Content Strategy discipline content
│   ├── prompts/
│   ├── rules/
│   ├── project-configs/
│   └── workflow-states/
├── design/            # Design discipline content
│   ├── prompts/
│   ├── rules/
│   ├── project-configs/
│   └── workflow-states/
├── quality-assurance/        # Quality Assurance discipline content
│   ├── prompts/        # Quality Assurance prompts and checklists
│   ├── rules/   # Quality Assurance-specific rules and guidelines for maintaining consistency
│   ├── project-configs/ # Quality Assurance tool or process configurations
│   └── workflow-states/ # Quality Assurance workflow documentation
├── .github/           # GitHub configuration
│   └── workflows/     # GitHub Actions workflows
├── .eleventy.js       # 11ty configuration
├── .gitignore
├── package.json
├── README.md
└── llms.txt           # AI context file (auto-generated)
```

## Content Organization

The library is organized by disciplines and content types:

### Disciplines
- Development
- Project Management
- Sales & Marketing
- Content Strategy
- Design
- Quality Assurance

### Content Types
- Prompts: AI prompts for various use cases
- Rules: Guidelines for development environments
- Project Configs: Project configuration templates
- Workflow States: Process and workflow documentation

Each discipline contains all content types, allowing for specialized content within each field.

## Contributing

Content suggestions can also be submitted programmatically via GitHub Actions. This involves sending a `repository_dispatch` event with the type `slack-prompt-submission` to the GitHub API endpoint for this repository (`/repos/Lullabot/prompt_library/dispatches`). The event's `client_payload` must include the content, necessary metadata (author, invoker, permalink), and a pre-configured shared secret for validation. Successful dispatch triggers a workflow that creates a GitHub issue with the submitted content for review. See the workflow file `.github/workflows/slack_submit.yml` and the associated pull request (#40) for payload details and setup instructions.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

- [Submit a Prompt](https://github.com/Lullabot/prompt_library/issues/new?template=prompt-submission.yml) - Share AI prompts for various use cases
- [Submit a Rule](https://github.com/Lullabot/prompt_library/issues/new?template=rule-submission.yml) - Contribute guidelines for development environments
- [Submit a Project Config](https://github.com/Lullabot/prompt_library/issues/new?template=project-config-submission.yml) - Share project configuration templates
- [Submit a Workflow State](https://github.com/Lullabot/prompt_library/issues/new?template=workflow-state-submission.yml) - Contribute process and workflow documentation

## License

This project is licensed under the ISC License.

## AI Context File

The `llms.txt` file is an auto-generated comprehensive snapshot of the entire project, designed to provide AI assistants with complete context about the codebase. This file contains all source code, documentation, configuration files, and templates compressed into a single file that can be easily consumed by language models.

### When to Use
- Providing full project context to AI assistants for code reviews
- Getting architectural guidance and implementation suggestions
- Debugging complex issues that span multiple files
- Understanding the complete project structure and dependencies

### Note
This file is automatically generated and should not be edited manually. It's updated whenever the project structure or files change significantly.

## Acknowledgments

- [11ty](https://www.11ty.dev/)
- [GitHub Pages](https://pages.github.com/) 
~~~

## License

No top-level license file found.
