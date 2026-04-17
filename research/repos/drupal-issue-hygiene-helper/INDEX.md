# INDEX for drupal-issue-hygiene-helper
## File Tree (Depth 3)
```
.
./.env.example
./.git
./.gitignore
./CLAUDE.md
./composer.json
./composer.lock
./INDEX.md
./issue.php
./README.md
./src
./src/Command
./src/Command/CheckIssuesCommand.php
./src/Command/GiveSuggestionsCommand.php
./src/Command/InteractiveCommand.php
./src/Command/Traits
./src/Command/UpdateIssuesCommand.php
./src/Service
./src/Service/AIService.php
./src/Service/DrupalApiService.php
./src/Service/IssueChecker.php
./src/State
./src/State/StateHandler.php
./state
./state/.gitkeep
```
## File Type Counts
```
  10 php
   3 md
   1 lock
   1 json
   1 gitkeep
   1 gitignore
   1 example
```
## Presence of key files/directories
- CLAUDE.md: Present
- AGENTS.md: Absent
- skills/: Absent
- .claude/skills/: Absent
- agents/: Absent
- commands/: Absent
- hooks/: Absent
- .claude/: Absent
- prompts/: Absent
- evals/: Absent
- composer.json: Present
- package.json: Absent
- skills.yaml: Absent
- SKILL.md: Absent
## First 200 lines of README
```
# Drupal Issue Hygiene Helper

CLI tool to help maintain Drupal.org issue queues by analyzing issues and suggesting improvements.

## Installation

```bash
composer install
cp .env.example .env
# Edit .env with your OpenAI API key and project IDs
```

## Configuration

```env
OPENAI_API_KEY=your_key
DRUPAL_PROJECT_IDS='{"AI": 3346420, "YourProject": 1234567}'
```

## Usage

Run interactively:
```bash
php issue.php
```

Or run commands directly:
```bash
php issue.php update-issues --project=AI        # Fetch issues from Drupal.org
php issue.php give-suggestions --project=AI     # Analyze and create suggestions
php issue.php check-issues --project=AI         # Review pending suggestions
```

## What it checks

- Patch/MR uploaded but status still "Active"
- Failing CI on "Needs Review" issues
- Stale issues (no activity for 5+ days)
- Unanswered questions (2+ weeks)
- Bug reports lacking details (AI)
- Missing test instructions (AI)
- RTBC with unresolved discussions (AI)
- Feature requests without use cases (AI)

## Requirements

- PHP 8.2+
- Chrome/Chromium (for scraping)
- OpenAI API key (for AI-based checks)

## Note
**This whole tool is vibe-coded. Since it doesn't write directly to Drupal.org, it is safe to run and test without fear of causing harm. However, please be mindful of API usage and respect Drupal.org's guidelines when implementing suggestions.**
```
## License
```
No LICENSE found.
```
## Last Commit Date
2026-04-07 08:51:34 +0200
## Skill Count
0 SKILL.md files found.
