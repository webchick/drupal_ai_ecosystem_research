# Analysis: drupal-agent-resources

1. **What problem does it solve?**  
This repo packages reusable Drupal development resources for Claude Code so teams can install Drupal-specific skills, an agent, and slash commands through the `agr` package manager instead of hand-rolling their own agent context. `README.md` frames it as a standard-setting resource pack for Drupal 10/11 development with DDEV and Docker environments.

2. **Primary artefact type**  
Mixed resource pack: skills, one agent, and slash commands. The concrete artefacts are `.claude/skills/*/SKILL.md`, `.claude/agents/drupal-reviewer.md`, and `.claude/commands/*.md`.

3. **Distribution model**  
Standalone GitHub repo distributed through `agr add ...` / `agrx ...`. `README.md` documents installation via the external `agent-resources` package manager rather than Composer or `npx skills`.

4. **Standards conformance**  
Partial. The skills themselves use `SKILL.md` with `name` and `description` frontmatter in `.claude/skills/*/SKILL.md`, which is close to agentskills.io format, but the repo organizes everything under `.claude/` and depends on `agr` as a proprietary installer (`README.md`). There is no `AGENTS.md`, and the agent/command layers are Claude-specific.

5. **Architectural pattern**  
Flat curated pack of installable resources. `README.md` separates resources into skills, one review agent, and slash commands, but there is no routing/index layer beyond `agr`'s resource naming. Runtime behavior is driven by whichever resources the user installs individually.

6. **Naming convention**  
Mostly noun/domain names with `drupal-` prefixes, not gerunds: `drupal-expert`, `drupal-security`, `drupal-migration`, `ddev-expert`, `docker-local`, plus command names like `module-scaffold` and `config-export` in `README.md` and the `.claude/commands/` filenames.

7. **Coverage**  
- General Drupal development rules: `.claude/skills/drupal-expert/SKILL.md`  
- Security review: `.claude/skills/drupal-security/SKILL.md`  
- Migration work: `.claude/skills/drupal-migration/SKILL.md`  
- DDEV local development: `.claude/skills/ddev-expert/SKILL.md`  
- Docker-based local development: `.claude/skills/docker-local/SKILL.md`  
- Drupal code review: `.claude/agents/drupal-reviewer.md`  
- Module scaffolding: `.claude/commands/module-scaffold.md`  
- Config export workflow: `.claude/commands/config-export.md`  
- Security audit workflow: `.claude/commands/security-audit.md`  
- Performance checks: `.claude/commands/performance-check.md`  
- Drush/site health checks: `.claude/commands/drush-check.md`

8. **Quality signals**  
- Last commit date: `INDEX.md` records `2026-04-14 10:44:24 +0200`.  
- Issue count: `REPO_METADATA.md` records 1 open issue.  
- Stars/watchers: `REPO_METADATA.md` records 40 stars and 1 watcher.  
- Tests: no dedicated test suite is present in `INDEX.md`.  
- Eval harness: none found; no `evals/` directory in `INDEX.md`.  
- CI: `.github/workflows/validate.yml` is present, so there is at least one validation workflow.  
- Versioning discipline: good; `README.md` points to `VERSIONING.md` and `CHANGELOG.md`, both present in `INDEX.md`.  
- Active maintainer signal: `REPO_METADATA.md` shows activity updated and pushed on 14 April 2026.

9. **Notable innovations**  
Its interesting contribution is packaging multiple resource types behind one install namespace. `README.md` treats skills, agents, and commands as first-class peer artefacts, which is broader than most pure skill libraries, and `.github/workflows/validate.yml` suggests some effort to validate the pack systematically.

10. **Weaknesses / gaps**  
It is still heavily Claude-shaped despite using `SKILL.md`. Everything lives under `.claude/`, commands are slash-command resources rather than portable skills, and there is no AGENTS.md or cross-tool install story beyond `agr` in `README.md`. Coverage is also relatively narrow compared with bigger libraries: five skills and one agent.

11. **Compatibility with ai_best_practices' decisions**  
Partially compatible. The skill content is potentially absorbable, but the structure would need normalization from `.claude/skills/` to root `skills/`, and the names would need migration to gerund-prefix form. The agent and command layers are outside ai_best_practices' current core scope unless that project later adopts optional workflow helpers.

12. **Relationship to Surge**  
Surge could likely consume the skill layer if it were mirrored into a standard `skills/` directory, but in its current form the repo is more of a parallel installer ecosystem. There is no inherent conflict, but the packaging conventions differ.

13. **One-paragraph verdict**  
**Reference** with selective content absorption. The repo has credible, recent Drupal guidance and a useful review-agent concept, but its delivery model is too tied to `agr` and `.claude/` conventions to become a direct foundation for ai_best_practices. The best move is to mine the strongest skill content, especially `drupal-expert` and `drupal-security`, while treating the resource-pack structure as adjacent rather than canonical.
