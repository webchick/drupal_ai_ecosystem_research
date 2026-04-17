# surge — Structural Index

**Source URL**: https://git.drupalcode.org/project/surge.git
**Clone URL used**: https://git.drupalcode.org/project/surge.git
**Last commit**: 2026-04-04 09:45:28 +0200
**Last commit subject**: feat: #3583105 Update the default directory for skills
**License**: none
**Default branch**: refs/heads/1.0.x

## File type counts

     33 md
     28 php
      1 xml
      1 json
      1 gitignore
      1 dist

## Presence of key files/dirs

- CLAUDE.md: ✗ absent
- AGENTS.md: ✓ present
- README: ✓ present (README.md)
- skills/ : ✗ absent
- .claude/ : ✗ absent
- .claude/skills/ : ✗ absent
- agents/ : ✗ absent
- commands/ : ✗ absent
- hooks/ : ✗ absent
- prompts/ : ✗ absent
- evals/ : ✗ absent
- composer.json: ✓ present
- package.json: ✗ absent
- skills.yaml: ✗ absent
- .cursorrules / .cursor/ : ✗ absent
- .github/ : ✗ absent

## SKILL.md count

Number of SKILL.md files: 0

(no SKILL.md files)

## File tree (depth 3)

```
.
./AGENTS.md
./composer.json
./INDEX.md
./phpunit.xml
./README.md
./src
./src/Agents
./src/Agents/AgentsConfig.php
./src/Agents/Command
./src/Agents/EnvironmentDetector.php
./src/Agents/SectionComposer.php
./src/Agents/templates
./src/Skills
./src/Skills/Command
./src/Skills/README.md
./src/Skills/SkillsAggregator.php
./src/Skills/SkillsConfig.php
./src/Skills/SkillsOutputStyleInterface.php
./src/Skills/SkillsScanner.php
./src/Skills/SkillValidator.php
./src/Skills/Source
./src/Surge
./src/Surge/Composer
./src/Surge/Config
./src/Surge/Console
./src/Surge/PathSecurity.php
./surge.yaml.dist
./tests
./tests/Agents
./tests/Agents/EnvironmentDetectorTest.php
./tests/Agents/SectionComposerTest.php
./tests/Fixtures
./tests/Fixtures/RecordingSkillsOutput.php
./tests/Integration
./tests/Integration/ComposerRemoveWithSurgeTest.php
./tests/Skills
./tests/Skills/SkillsAggregatorComposerPluginRegressionTest.php
./tests/Skills/SkillsAggregatorTest.php
./tests/Skills/SkillsScannerTest.php
./tests/Skills/SkillValidatorTest.php
./tests/Surge
./tests/Surge/PathSecurityTest.php
```

## README first 200 lines

Source: README.md

```
> **Surge 🌊**
>
> a sudden powerful forward or upward movement, especially by a crowd or by a natural force such as the tide.

**Drupal Surge:** An AI coding standard kit for Drupal development.

It gives AI tools the context they need to work *with* Drupal, not around it. By combining discoverable skills and open standards, Surge helps AI understand your codebase, conventions, and environment from day one.

Surge focuses on open standards and makes them easy to integrate in a flexible way. You can adopt only what you need, extend where it makes sense, and compose your own setup without locking yourself into specific tools or formats.

This is a foundation, not a finished product. A forward movement shaped by shared direction and collective effort within the Drupal ecosystem.

## Open Standards

Drupal Surge is built on open standards to stay flexible, transparent, and future-proof.

- **Skills** follow the [Agent Skills specification](https://agentskills.io/) for discoverable, reusable capabilities, you pick the skills you need.

By relying on open standards, Surge stays tool-agnostic and easy to extend as the AI ecosystem evolves.

## Installation

```bash
composer require drupal/surge --dev
```

## Automatic Setup

**Note**: You may need to allow the plugin to run by executing:

```bash
composer config allow-plugins.drupal/surge true
```

When you install this package, the Surge commands are automatically available through Composer scripts. The package includes a Composer plugin that automatically registers the necessary scripts in your project's `composer.json`.

And it will create a `surge.yaml` configuration file in your project root with sensible defaults.

## Modular Architecture

Drupal Surge is organized into modules under `src/`:

- **Surge** (`src/Surge/`) - Core framework (PathSecurity, Composer plugin, Console, Config)
- **Skills** (`src/Skills/`) - Agent Skills discovery and aggregation

## Skills

Surge aggregates [Agent Skills](https://agentskills.io/) from multiple sources into a configurable output directory (defaults to `.agents/skills/`) for use with Claude Code, Cursor, and other AI tools.

The ecosystem is converging on `.agents/skills/` as a shared location ([agentskills#15](https://github.com/agentskills/agentskills/issues/15)); Surge uses that as the default install target while still discovering `.claude/skills/`, plain `skills/`, and custom `output_directory` values.

## Configuration

**Note**: Skills are enabled by default. A `surge.yaml` configuration file gets created automatically with sensible defaults. You can customize it to exclude specific skills or directories if needed.

See [src/Skills/README.md](src/Skills/README.md) for detailed documentation.

## Usage

After installation and configuration, you can use Surge directly:

## Commands

### Skills

- `composer surge skills-install` - Install Agent Skills to the configured output directory (defaults to `.agents/skills/`)
- `composer surge skills-list` - List discovered skills with validation status

### Agents

- `composer surge agents-generate` - Generate `AGENTS.md` file for AI coding agents

The `agents-generate` command creates a customized `AGENTS.md` file tailored to your Drupal project by:

- **Auto-detecting** your development environment (DDEV, Lando, Docker Compose, or Vanilla)
- **Detecting** Drupal version and PHP requirements from `composer.json`
- **Composing** sections from modular templates with environment-specific placeholders replaced
- **Supporting** section toggles and project-local overrides via `surge.yaml`

#### How It Works

1. **Environment Detection**: The command scans your project for indicators (`.ddev/`, `.lando.yml`, `compose.yaml`, etc.) to determine your development setup.

2. **Template Composition**: It assembles `AGENTS.md` from modular markdown templates:
   - **Shared sections** (`src/Agents/templates/sections/`) - Drupal patterns, code style, security guidelines
   - **Environment sections** (`src/Agents/templates/environments/{env}/`) - Setup, commands, debugging specific to your environment

3. **Placeholder Replacement**: Environment-specific values are automatically filled in:
   - Drupal version, PHP version, environment name
   - Docker Compose service names and database credentials (if applicable)
   - Environment-specific tool references

4. **Customization**: You can customize the output by:
   - **Disabling sections** in `surge.yaml`:
     ```yaml
     agents:
       sections:
         batch-queue-ajax: false  # Disable if not using
     ```
   - **Overriding templates** by creating files in `.surge/agents/`:
     ```
     .surge/agents/sections/code-style.md  # Override code style section
     .surge/agents/environments/ddev/commands.md  # Override DDEV commands
     ```
   - **Configuring overrides** in `surge.yaml`:
     ```yaml
     agents:
       overrides:
         code-style: .surge/agents/sections/code-style.md
     ```

The generated `AGENTS.md` file provides comprehensive guidance for AI coding agents working on your Drupal project, ensuring consistent code quality and adherence to your project's conventions.
```
