# Analysis: drupal-issue-hygiene-helper

1. **What problem does it solve?**  
This repo is a CLI helper for maintaining Drupal.org issue queues by fetching issues, checking them against a mix of deterministic and AI-based heuristics, and generating suggested follow-up actions. `README.md` positions it around queue hygiene checks such as stale issues, failing CI, unanswered questions, missing test instructions, and feature requests without use cases, while `src/Service/IssueChecker.php` and `src/Service/DrupalApiService.php` implement the actual queue-analysis logic.

2. **Primary artefact type**  
CLI tool. The entry point is `issue.php`, command handlers live under `src/Command/`, and the main logic sits in `src/Service/IssueChecker.php`, `src/Service/AIService.php`, and `src/Service/DrupalApiService.php`.

3. **Distribution model**  
Standalone Composer-installed PHP repo. `README.md` instructs users to run `composer install`, configure `.env`, and use `php issue.php` or subcommands like `update-issues`, `give-suggestions`, and `check-issues`. This is not packaged as a skill library or Drupal contrib module.

4. **Standards conformance**  
None for skills standards. `INDEX.md` records no `AGENTS.md`, no `skills/`, no `.claude/skills/`, and zero `SKILL.md` files. The repo has a `CLAUDE.md`, but the runtime model is a custom CLI rather than agentskills.io-compatible skills.

7. **Coverage**  
- Drupal.org issue fetching and pagination: `src/Service/DrupalApiService.php`  
- Deterministic queue hygiene checks for statuses, CI, stale issues, and unanswered questions: `src/Service/IssueChecker.php`  
- AI-assisted suggestion generation: `src/Service/AIService.php`, `src/Command/GiveSuggestionsCommand.php`  
- Project-specific issue queue syncing: `src/Command/UpdateIssuesCommand.php`, `README.md`  
- Interactive review workflow for suggestions: `src/Command/InteractiveCommand.php`, `src/Command/CheckIssuesCommand.php`

8. **Quality signals**  
- Last commit date: `INDEX.md` records `2026-04-07 08:51:34 +0200`.  
- Issue count: `REPO_METADATA.md` records 0 open issues.  
- Stars/watchers: `REPO_METADATA.md` records 1 star and 0 watchers.  
- Tests: none are visible in `INDEX.md`.  
- CI: none is visible in `INDEX.md`.  
- Versioning discipline: minimal; no changelog or release files are present.  
- Maintainer signal: active very recently, but small and explicitly experimental; `README.md` calls the tool “vibe-coded.”

11. **Compatibility with ai_best_practices' decisions**  
Low. The repo is contribution-workflow tooling, not a universal skills package. Any merge would require extracting its guidance into one or more gerund-named contribution skills under `skills/`, but the stronger value is likely conceptual: it demonstrates which Drupal.org queue problems are frequent enough to automate, not how to structure a shared best-practices library.

13. **One-paragraph verdict**  
**Reference**. `drupal-issue-hygiene-helper` is adjacent ecosystem tooling with useful contribution-hygiene heuristics, especially in `src/Service/IssueChecker.php`, but it is not a merge candidate for ai_best_practices' core skill library. It should inform contribution-workflow guidance and possibly future automation ideas, while remaining outside the main consolidated content package.
