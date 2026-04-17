# edutrul-drupal-ai — Structural Index

**Source URL**: https://github.com/edutrul/drupal-ai
**Clone URL used**: https://github.com/edutrul/drupal-ai
**Last commit**: 2026-04-15 10:51:20 -0500
**Last commit subject**: Update documentation.
**License**: LICENSE (MIT per README badge)
**Default branch**: refs/heads/main (inferred from `git log -1` success)

## File type counts

    104 md
      6 sh
      3 json
      1 gitignore

## Presence of key files/dirs

- CLAUDE.md: ✗ absent (CLAUDE.example.md present)
- AGENTS.md: ✗ absent (AGENTS.example.md present)
- README.md: ✓ present
- skills/ : ✗ absent
- .claude/ : ✓ present
- .claude/skills/ : ✓ present (34 skills here)
- agents/ : ✗ absent (located at .claude/agents/ — 10 agents)
- commands/ : ✗ absent (located at .claude/commands/ — 9 commands)
- hooks/ : ✗ absent (located at .claude/hooks/ — 2 hooks: session-resume.sh, session-start.sh)
- prompts/ : ✗ absent
- evals/ : ✗ absent
- composer.json: ✗ absent
- package.json: ✗ absent
- skills.yaml: ✗ absent
- .cursor*: ✗ absent (README claims Cursor compat — probably via AGENTS.md)
- .github/: ✗ absent
- .codex/ : ✓ present (multi-tool: Codex support)

## SKILL.md count

Number of SKILL.md files (case-sensitive): **35**
- 1 at repo root (`./SKILL.md`) — likely meta-skill
- 34 under `.claude/skills/` (one per Drupal topic — see README table)

### Paths (all 35)
```
./SKILL.md
./.claude/skills/ddev-expert/SKILL.md
./.claude/skills/docker-local/SKILL.md
./.claude/skills/drupal-access/SKILL.md
./.claude/skills/drupal-caching/SKILL.md
./.claude/skills/drupal-composer/SKILL.md
./.claude/skills/drupal-config/SKILL.md
./.claude/skills/drupal-contrib-mgmt/SKILL.md
./.claude/skills/drupal-debugging/SKILL.md
./.claude/skills/drupal-drush/SKILL.md
./.claude/skills/drupal-dtt/SKILL.md
./.claude/skills/drupal-entity-api/SKILL.md
./.claude/skills/drupal-events/SKILL.md
./.claude/skills/drupal-fields/SKILL.md
./.claude/skills/drupal-form-ajax/SKILL.md
./.claude/skills/drupal-form-alter/SKILL.md
./.claude/skills/drupal-form-api/SKILL.md
./.claude/skills/drupal-form-validation/SKILL.md
./.claude/skills/drupal-hooks/SKILL.md
./.claude/skills/drupal-javascript/SKILL.md
./.claude/skills/drupal-kernel/SKILL.md
./.claude/skills/drupal-menus/SKILL.md
./.claude/skills/drupal-migrations/SKILL.md
./.claude/skills/drupal-paragraphs/SKILL.md
./.claude/skills/drupal-plugins/SKILL.md
./.claude/skills/drupal-queries/SKILL.md
./.claude/skills/drupal-render/SKILL.md
./.claude/skills/drupal-routes/SKILL.md
./.claude/skills/drupal-search-api/SKILL.md
./.claude/skills/drupal-security/SKILL.md
./.claude/skills/drupal-services/SKILL.md
./.claude/skills/drupal-state/SKILL.md
./.claude/skills/drupal-taxonomy/SKILL.md
./.claude/skills/drupal-twig/SKILL.md
./.claude/skills/drupal-unit/SKILL.md
```

## File tree (depth 3)
```
.
./AGENTS.example.md
./.claude
./.claude/agents
./.claude/agents/code-reviewer.md
./.claude/agents/done-gate.md
./.claude/agents/drupal-backend-dev.md
./.claude/agents/drupal-contributor.md
./.claude/agents/drupal-frontend-dev.md
./.claude/agents/drupal-reviewer.md
./.claude/agents/drupal-site-builder.md
./.claude/agents/drupal-test-writer.md
./.claude/agents/quality-gate.md
./.claude/agents/researcher.md
./.claude/commands
./.claude/commands/code-review.md
./.claude/commands/config-export.md
./.claude/commands/create-pr.md
./.claude/commands/drush-check.md
./.claude/commands/module-scaffold.md
./.claude/commands/performance-check.md
./.claude/commands/ready-pr-in-review.md
./.claude/commands/review-pr.md
./.claude/commands/security-audit.md
./.claude/data
./.claude/data/mappings.example.json
./CLAUDE.example.md
./.claude/hooks
./.claude/hooks/session-resume.sh
./.claude/hooks/session-start.sh
./.claude/rules
./.claude/rules/docblocks.md
./.claude/rules/drupal.md
./.claude/rules/frontend.md
./.claude/rules/phpcs.md
./.claude/rules/php.md
./.claude/rules/testing.md
./.claude/rules/tooling.md
./.claude/rules/workflow.md
./.claude/settings.json
./.claude/settings.local.example.json
./.claude/skills
./.claude/skills/ddev-expert
./.claude/skills/docker-local
./.claude/skills/drupal-access
./.claude/skills/drupal-caching
./.claude/skills/drupal-composer
./.claude/skills/drupal-config
./.claude/skills/drupal-contrib-mgmt
./.claude/skills/drupal-debugging
./.claude/skills/drupal-drush
./.claude/skills/drupal-dtt
./.claude/skills/drupal-entity-api
./.claude/skills/drupal-events
./.claude/skills/drupal-fields
./.claude/skills/drupal-form-ajax
./.claude/skills/drupal-form-alter
./.claude/skills/drupal-form-api
./.claude/skills/drupal-form-validation
./.claude/skills/drupal-hooks
./.claude/skills/drupal-javascript
./.claude/skills/drupal-kernel
./.claude/skills/drupal-menus
./.claude/skills/drupal-migrations
./.claude/skills/drupal-paragraphs
./.claude/skills/drupal-plugins
./.claude/skills/drupal-queries
./.claude/skills/drupal-render
./.claude/skills/drupal-routes
./.claude/skills/drupal-search-api
./.claude/skills/drupal-security
./.claude/skills/drupal-services
./.claude/skills/drupal-state
./.claude/skills/drupal-taxonomy
./.claude/skills/drupal-twig
./.claude/skills/drupal-unit
./.codex
./.codex/README.md
./LICENSE
./README.md
```

## README first 200 lines
See `README.md` in repo (retrieved via `head -80`). Self-description: "A production-tested AI toolkit for Drupal 11 development — compatible with Claude Code, OpenAI Codex, Cursor, and GitHub Copilot." Dual purpose: (1) active Drupal 11 / DDEV / Acquia Cloud project config, (2) reusable `.claude/` drop-in for any Drupal project. Badge row claims MIT, Drupal 11, Claude Code, Codex, skills.sh listed.
