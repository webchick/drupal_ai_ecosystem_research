# aidev Index

## Repo Facts

- Path: /Users/webchick/Documents/Codex/2026-04-17-research-drupal-ai-tooling-landscape-synthesis-2/research/repos/aidev
- Last commit date: 2024-04-01 13:49:35 +0300
- Skill count (SKILL.md): 0

## Presence / Absence

- CLAUDE.md: no
- AGENTS.md: no
- skills/: no
- .claude/skills/: no
- agents/: no
- commands/: no
- hooks/: no
- .claude/: no
- prompts/: no
- evals/: no
- composer.json: yes
- package.json: no
- skills.yaml: no
- Any SKILL.md files: no

## File Tree (Depth 3)

~~~text
.
./INDEX.md
./README.md
./aidev.info.yml
./aidev.module
./aidev.services.yml
./composer.json
./src
./src/Annotation
./src/Annotation/SourceModifier.php
./src/Exception
./src/Exception/AIDevException.php
./src/Plugin
./src/Plugin/SourceModifier
./src/Plugin/SourceModifierPluginBase.php
./src/Plugin/SourceModifierPluginInterface.php
./src/Source.php
./src/SourceInterface.php
./src/SourceModifierPluginManager.php
~~~

## File Type Counts

~~~text
.json	1
.md	2
.module	1
.php	10
.yml	2
~~~

## README (First 200 Lines)

Source: README.md

~~~text
CONTENTS OF THIS FILE
---------------------

 * Introduction
 * Requirements
 * Installation and usage

INTRODUCTION
------------

Build Drupal systems using natural language with the help of AI.

At the moment has API functions to gather and preprocess source code.

For more information visit project page https://drupal.org/project/aidev

REQUIREMENTS
------------

None

INSTALLATION AND USAGE
----------------------

- Follow the standard Drupal installation instructions:
  https://www.drupal.org/docs/extending-drupal/installing-modules

- Module provides API methods to use within your custom code:

```php
// Get service
$service = \Drupal::service('aidev.source_code');

// Define files to preprocess
$modifiers = [

  // mention every file that exist
  ["status" => 1, "action" => "mention", "paths" => ["*"]],

  // completely exclude README.md file
  ["status" => 1, "action" => "exclude", "paths" => ["README.md"]],

  // include full contents of some files
  ["status" => 1, "action" => "include", "paths" => ["aidev.info.yml", "src/Plugin"]],

  // this rule is disabled and does nothing
  ["status" => 0, "action" => "exclude", "paths" => ["ExcludeFilePlugin.php"]],
];

// Now you can either 1) gather source code from particular directory like this
$path = 'modules/aidev/src';
$source_code = $service->gatherDirectorySource($path, $modifiers);

// Or 2) gather source code of particular project like this
$project_type = 'module';
$project_name = 'aidev';
$source_code = $service->gatherProjectSource($project_type, $project_name, $modifiers);
```

The `$source_code` variable will now contain an array of the gathered source code and related statistics

~~~

## License

No top-level license file found.
