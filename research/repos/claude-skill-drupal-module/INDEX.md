# INDEX for claude-skill-drupal-module
## File Tree (Depth 3)
```
.
./.git
./.github
./.github/workflows
./.github/workflows/check-versions.yml
./CHANGELOG.md
./composer.json
./ddev-commands
./ddev-commands/phpcbf
./ddev-commands/phpcs
./ddev-commands/phpstan
./ddev-commands/phpunit
./INDEX.md
./LICENSE.txt
./README.md
./references
./references/cache-api.md
./references/configuration-api.md
./references/database-api.md
./references/dependency-injection.md
./references/entity-api.md
./references/event-system.md
./references/form-api.md
./references/hooks.md
./references/plugin-api.md
./references/render-theming.md
./references/routing-system.md
./references/security.md
./references/testing-quality.md
./SKILL.md
./VERSIONS.md
```
## File Type Counts
```
  18 md
   1 yml
   1 txt
   1 json
   1 /ddev-commands/phpunit
   1 /ddev-commands/phpstan
   1 /ddev-commands/phpcs
   1 /ddev-commands/phpcbf
```
## Presence of key files/directories
- CLAUDE.md: Absent
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
- SKILL.md: Present
## First 200 lines of README
```
# Claude Code Skill: Drupal Module

A [Claude Code](https://claude.ai/code) skill that transforms Claude into a senior Drupal architect — generating production-ready, installable Drupal 11 modules using modern PHP 8.4+ syntax, proper dependency injection, and current Drupal 11 APIs.

## What it does

When invoked, this skill instructs Claude to:

- Generate complete, installable Drupal modules (all required files)
- Use PHP 8 attributes, not annotations
- Apply proper dependency injection (no `\Drupal::service()` in classes)
- Follow Drupal coding standards (2-space indent, PSR-4, PHPDoc)
- Include cache metadata, access checks, and translatable strings
- Run quality tools (`ddev phpcs`, `ddev phpstan`) and tests after every change
- Verify security: XSS, SQL injection, CSRF, access control

See [VERSIONS.md](VERSIONS.md) for Drupal/PHP/Symfony compatibility.

## Installation

### Option A: Composer (recommended for Drupal projects)

**Step 1** — Add the installer path to your project's `composer.json`:

```json
"extra": {
    "installer-paths": {
        ".claude/skills/{$name}": ["type:claude-skill"]
    }
}
```

> Requires [`oomphinc/composer-installers-extender`](https://packagist.org/packages/oomphinc/composer-installers-extender).
> Most Drupal projects already have this — check your `composer.json`.

**Step 2** — Require the skill:

```bash
composer require ablerz/claude-skill-drupal-module:dev-11.x
```

The skill installs to `.claude/skills/custom-drupal-module/` automatically.

**Updating:**

```bash
composer update ablerz/claude-skill-drupal-module
```

---

### Option B: Git clone (any project)

```bash
# Project-level (this project only)
git clone -b 11.x https://github.com/ablerz/claude-skill-drupal-module \
  .claude/skills/custom-drupal-module

# Global (all projects on this machine)
git clone -b 11.x https://github.com/ablerz/claude-skill-drupal-module \
  ~/.claude/skills/custom-drupal-module
```

**Updating:**

```bash
git -C .claude/skills/custom-drupal-module pull
# or globally:
git -C ~/.claude/skills/custom-drupal-module pull
```

## DDEV setup (required for quality commands)

The skill instructs Claude to run `ddev phpcs`, `ddev phpcbf`, `ddev phpstan`, and `ddev phpunit` — these are **custom DDEV commands** that must exist in your project's `.ddev/commands/web/` directory. They are not included with DDEV by default.

This repo ships ready-to-use command scripts in [`ddev-commands/`](ddev-commands/). Copy them into your project:

```bash
cp .claude/skills/custom-drupal-module/ddev-commands/* .ddev/commands/web/
chmod +x .ddev/commands/web/phpcs .ddev/commands/web/phpcbf \
         .ddev/commands/web/phpstan .ddev/commands/web/phpunit
ddev restart
```

> If you installed via git clone, substitute the path accordingly.

After this, `ddev phpcs`, `ddev phpcbf`, `ddev phpstan`, and `ddev phpunit` will work as expected.

---

## Usage

Once installed, invoke the skill in Claude Code using:

```
/custom-drupal-module
```

Or reference it in your `CLAUDE.md`:

```markdown
When working with Drupal custom modules, invoke the `custom-drupal-module` skill first.
```

## Drupal version support

| Branch | Drupal | PHP  |
|--------|--------|------|
| `11.x` | 11.x   | 8.4+ |
| `12.x` | 12.x   | TBD  |

See [VERSIONS.md](VERSIONS.md) for the full compatibility matrix.

## Staying current

This skill uses two official Drupal sources to stay accurate:

- **API reference**: [api.drupal.org/api/drupal/11.x](https://api.drupal.org/api/drupal/11.x)
- **Breaking changes**: [drupal.org/list-changes/drupal](https://www.drupal.org/list-changes/drupal?version=11.x)

A GitHub Actions workflow runs monthly and opens an issue if breaking changes are detected since the skill's `last_updated` date.

## Contributing

Pull requests welcome. When updating for a new Drupal version:

1. Branch from the previous version branch
2. Update all version strings in `SKILL.md` frontmatter
3. Update affected `references/*.md` files
4. Add a `CHANGELOG.md` entry
5. Update `VERSIONS.md`

## License

GPL-2.0-or-later — compatible with Drupal and the Drupal ecosystem.
```
## License
```
        GNU GENERAL PUBLIC LICENSE
```
## Last Commit Date
2026-02-10 14:59:02 +0100
## Skill Count
1 SKILL.md files found.
