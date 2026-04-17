# ai_skills — Structural Index

**Source URL**: https://git.drupalcode.org/project/ai_skills.git
**Clone URL used**: https://git.drupalcode.org/project/ai_skills.git
**Last commit**: 2026-03-24 10:05:18 +0100
**Last commit subject**: Add license
**License**: composer.json: GPL-2.0-or-later
**Default branch**: refs/heads/1.0.x

## File type counts

     46 md
     10 py
      3 png
      2 gitignore
      1 yml
      1 txt
      1 /skills/drupal-issue-queue/LICENSE
      1 /skills/drupal-contribute-fix/LICENSE
      1 json

## Presence of key files/dirs

- CLAUDE.md: ✗ absent
- AGENTS.md: ✗ absent
- README: ✓ present (README.md)
- skills/ : ✓ present
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

Number of SKILL.md files: 3

Paths:

```
./skills/drupal-coding-standards/SKILL.md
./skills/drupal-contribute-fix/SKILL.md
./skills/drupal-issue-queue/SKILL.md
```

## File tree (depth 3)

```
.
./composer.json
./CONTRIBUTING.md
./README.md
./skills
./skills/drupal-coding-standards
./skills/drupal-coding-standards/assets
./skills/drupal-coding-standards/SKILL.md
./skills/drupal-coding-standards/standards-index.md
./skills/drupal-contribute-fix
./skills/drupal-contribute-fix/examples
./skills/drupal-contribute-fix/.gitignore
./skills/drupal-contribute-fix/lib
./skills/drupal-contribute-fix/LICENSE
./skills/drupal-contribute-fix/README.md
./skills/drupal-contribute-fix/references
./skills/drupal-contribute-fix/requirements.txt
./skills/drupal-contribute-fix/scripts
./skills/drupal-contribute-fix/SKILL.md
./skills/drupal-issue-queue
./skills/drupal-issue-queue/.gitignore
./skills/drupal-issue-queue/LICENSE
./skills/drupal-issue-queue/README.md
./skills/drupal-issue-queue/references
./skills/drupal-issue-queue/scripts
./skills/drupal-issue-queue/SKILL.md
```

## README first 200 lines

Source: README.md

```
# Agentic Skills

A library of Agent Skills for the Drupal Community, based on the [Agentskills.io specification.](https://agentskills.io/)

## Overview

This repository contains a curated collection of Agent Skills that can be used with AI agents in the Drupal ecosystem. Skills are stored in the `skills` directory and are automatically validated on every merge request.

## Usage
​
Install these skills in your Agent using any of the following options:

1. Using skills.sh 

`npx skills add https://git.drupalcode.org/project/ai_skills/-/tree/1.0.x`

2. Use `drupal/surge` an AI coding toolkit specifically for Drupal, which will have these skills installable and configurable

3. Manually copy paste it to the skills directory of your Agent

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute skills to this library.

## Validation

All skills are automatically validated using `ronaldtebrake/agent-skills-validator-php` when merge requests are created. The validation runs as part of the GitLab CI/CD pipeline. 
This is based on the [Agentskills.io specification validator.](https://github.com/agentskills/agentskills/blob/main/skills-ref/src/skills_ref/validator.py) 

## Skills

<table border="0" cellpadding="1" cellspacing="1" style="width:500px">
	<tbody>
		<tr>
			<td><strong>Skill</strong></td>
			<td><strong>Repository</strong></td>
			<td><strong>Maintainer</strong></td>
		</tr>
		<tr>
			<td><code>drupal-coding-standards</code></td>
			<td><a href="https://github.com/ronaldtebrake/drupal-coding-standards-skill">drupal-coding-standards-skill</a></td>
			<td>ronaldtebrake</td>
		</tr>
		<tr>
			<td><code>drupal-issue-queue</code></td>
			<td><a href="https://github.com/scottfalconer/drupal-issue-queue">drupal-issue-queue</a></td>
			<td>scottfalconer</td>
		</tr>
		<tr>
			<td><code>drupal-contribute-fix</code></td>
			<td><a href="https://github.com/scottfalconer/drupal-contribute-fix">drupal-contribute-fix</a></td>
			<td>scottfalconer</td>
		</tr>
	</tbody>
</table>
```
