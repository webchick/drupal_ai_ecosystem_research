#!/bin/bash

mkdir -p research/repos
echo "# Acquisition Failures" > research/acquisition-failures.md

repos=(
    "surge|https://git.drupalcode.org/project/surge.git"
    "aidev|https://git.drupalcode.org/project/aidev.git"
    "drupal-claude-skills|https://github.com/grasmash/drupal-claude-skills.git"
    "drupal-agent-resources|https://github.com/madsnorgaard/drupal-agent-resources.git"
    "drupal-workflow|https://github.com/gkastanis/drupal-workflow.git"
    "drupal-agentic-workflow|https://github.com/gxleano/drupal-agentic-workflow.git"
    "claude-skill-drupal-module|https://github.com/ablerz/claude-skill-drupal-module.git"
    "drupaltools-skills|https://github.com/drupaltools/skills.git"
    "drupal-intent-testing|https://github.com/scottfalconer/drupal-intent-testing.git"
    "drupal-contribute-fix|https://github.com/scottfalconer/drupal-contribute-fix.git"
    "drupalcon-chicago-26-ckeditor-ai-playground|https://github.com/Simply007/drupalcon-chicago-26-ckeditor-ai-playground.git"
    "prompt_library|https://github.com/Lullabot/prompt_library.git"
    "drupal-issue-hygiene-helper|https://github.com/ivanboring/drupal-issue-hygiene-helper.git"
    "drupal-coding-standards-skill|https://github.com/ronaldtebrake/drupal-coding-standards-skill.git"
    "drupal-critic|https://github.com/zivtech/drupal-critic.git"
    "Drupal-DDEV-Setup-Claude-Skill|https://github.com/jamieaa64/Drupal-DDEV-Setup-Claude-Skill.git"
    "drupal-canvas-skills|https://github.com/drupal-canvas/skills.git"
    "drupal-skill|https://github.com/Omedia/drupal-skill.git"
    "ai-fe-skills|https://github.com/aldunchev/ai-fe-skills.git"
)

for entry in "${repos[@]}"; do
    slug="${entry%%|*}"
    url="${entry##*|}"
    echo "Cloning $slug from $url..."
    if ! git clone --depth 1 "$url" "research/repos/$slug" 2>/dev/null; then
        echo "Failed: $url"
        echo "- $url ($slug)" >> research/acquisition-failures.md
    else
        echo "Success: $slug"
        
        # Generate INDEX.md
        cd "research/repos/$slug" || exit
        
        {
            echo "# INDEX for $slug"
            echo "## File Tree (Depth 3)"
            echo '```'
            find . -maxdepth 3 -not -path '*/\.git/*' -not -path '*/node_modules/*' -not -path '*/vendor/*' | sort
            echo '```'
            
            echo "## File Type Counts"
            echo '```'
            find . -type f -not -path '*/\.git/*' -not -path '*/node_modules/*' -not -path '*/vendor/*' | awk -F. '{if(NF>1) print $NF}' | sort | uniq -c | sort -nr
            echo '```'
            
            echo "## Presence of key files/directories"
            for item in CLAUDE.md AGENTS.md skills/ .claude/skills/ agents/ commands/ hooks/ .claude/ prompts/ evals/ composer.json package.json skills.yaml SKILL.md; do
                if [ -e "$item" ]; then
                    echo "- $item: Present"
                else
                    echo "- $item: Absent"
                fi
            done
            
            echo "## First 200 lines of README"
            echo '```'
            # Find the first README file ignoring case
            readme_file=$(find . -maxdepth 1 -iname "readme*" | head -n 1)
            if [ -n "$readme_file" ]; then
                head -n 200 "$readme_file"
            else
                echo "No README found."
            fi
            echo '```'
            
            echo "## License"
            echo '```'
            # Find the first LICENSE file ignoring case
            license_file=$(find . -maxdepth 1 -iname "license*" | head -n 1)
            if [ -n "$license_file" ]; then
                head -n 1 "$license_file"
            else
                echo "No LICENSE found."
            fi
            echo '```'
            
            echo "## Last Commit Date"
            git log -1 --format=%ci
            
            echo "## Skill Count"
            count=$(find . -name "SKILL.md" -not -path '*/\.git/*' | wc -l | tr -d ' ')
            echo "$count SKILL.md files found."
        } > INDEX.md
        
        cd ../../../
    fi
done
