# aidev Repo Analysis

1. **What problem does it solve?** 
According to `README.md`, it aims to "Build Drupal systems using natural language with the help of AI." Specifically, it currently "has API functions to gather and preprocess source code" to be sent to an AI.

2. **Primary artefact type**: 
Drupal contrib module. It acts as a backend context-gathering utility (defined by `type: module` in `aidev.info.yml` and provides a PHP service via `aidev.services.yml` and `src/Source.php`).

3. **Distribution model**: 
Drupal contrib module via Composer. The `composer.json` declares it as `"type": "drupal-module"` and `"name": "drupal/aidev"`, and `README.md` directs users to `https://drupal.org/project/aidev`.

4. **Standards conformance**: 
None. `INDEX.md` explicitly states that `SKILL.md`, `AGENTS.md`, and AI tool configuration folders (like `.claude/`) are "Absent". It relies on a proprietary PHP array structure to define include/exclude rules (`README.md`).

5. **Architectural pattern**: 
Context aggregator via a Drupal backend service. The module uses a PHP service (`aidev.services.yml` routing to `src/Source.php`) that accepts an array of modifiers (`mention`, `exclude`, `include`) at runtime to gather and filter project source code before presumably passing it to an AI (`README.md`).

6. **Naming convention**: 
Not applicable. The repository contains "0 SKILL.md files" (`INDEX.md`), so there is no skill naming convention to evaluate against the `ai_best_practices` gerund standard. The module itself uses a standard noun abbreviation (`aidev.info.yml`).

7. **Coverage**: 
None. The module does not cover specific Drupal development topics (e.g., Entity API, Form API). It is strictly a generic file and directory source code aggregator (`README.md`).

8. **Quality signals**: 
Abandoned. The last commit was `2024-04-01` (`INDEX.md`). The file tree in `INDEX.md` shows a complete lack of tests, CI pipelines, or eval harnesses. There are only 10 PHP files in total. 

9. **Notable innovations**: 
Providing a Drupal plugin manager (`src/SourceModifierPluginManager.php` and `src/Plugin/SourceModifier/`) to dynamically alter context-gathering rules from within the Drupal backend is an interesting, albeit highly specific, approach compared to standard external CLI scrapers.

10. **Weaknesses / gaps**: 
Abandoned and incomplete. As stated in `README.md`, it "At the moment has API functions to gather and preprocess source code", meaning it stops short of actually generating code or interfacing with LLMs. It is heavily locked into the Drupal PHP environment and requires developers to write custom boilerplate to use it.

11. **Compatibility with ai_best_practices' decisions**: 
Fundamentally incompatible. `ai_best_practices` is built on markdown-based declarative skills, whereas this is a programmatic PHP utility (`INDEX.md` shows no markdown files beyond README/INDEX). There is nothing to merge without completely discarding the module's architecture.

12. **Relationship to Surge**: 
Surge solves a similar problem (context aggregation), but as an external CLI tool, whereas `aidev` does it as an internal Drupal service (`aidev.services.yml`). Surge does not aggregate this repo, and they operate in entirely different environments, so there is no conflict.

13. **One-paragraph verdict**: 
**Ignore**. This project is an abandoned, incomplete PHP-based experiment for aggregating source code context from within a Drupal environment (`README.md`). Because it provides no discrete skills, agents, or actionable prompts (`INDEX.md`), there is nothing of value to absorb into or reference from `ai_best_practices`.