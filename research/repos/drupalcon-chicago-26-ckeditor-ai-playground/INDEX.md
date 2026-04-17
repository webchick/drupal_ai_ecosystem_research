# drupalcon-chicago-26-ckeditor-ai-playground Index

## Repo Facts

- Path: /Users/webchick/Documents/Codex/2026-04-17-research-drupal-ai-tooling-landscape-synthesis-2/research/repos/drupalcon-chicago-26-ckeditor-ai-playground
- Last commit date: 2026-04-13 16:45:41 +0200
- Skill count (SKILL.md): 1

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
- composer.json: no
- package.json: yes
- skills.yaml: no
- Any SKILL.md files: yes

## File Tree (Depth 3)

~~~text
.
./.github
./.github/workflows
./.github/workflows/build.yml
./.gitignore
./Article.md
./INDEX.md
./LICENSE
./OUTLINE.md
./PROMPT.md
./README.md
./SKILL.md
./assets
./assets/drupal-ai-infographics.md
./assets/non-minified-error-screenshot.png
./assets/plugin-flow.png
./assets/screenshot-drupal.png
./ckeditor5_timestamp.ckeditor5.yml
./ckeditor5_timestamp.info.yml
./ckeditor5_timestamp.libraries.yml
./js
./js/build
./js/build/timestamp.js
./js/ckeditor5_plugins
./js/ckeditor5_plugins/timestamp
./package-lock.json
./package.json
./src
./src/Plugin
./src/Plugin/CKEditor5Plugin
./webpack.config.js
~~~

## File Type Counts

~~~text
.js	3
.json	2
.md	7
.php	1
.png	3
.yml	4
[dotfile-no-ext]	1
[no-ext]	1
~~~

## README (First 200 Lines)

Source: README.md

~~~text
# CKEditor 5 Timestamp Plugin for Drupal

A Drupal module that adds a CKEditor 5 toolbar button to insert the current timestamp at the cursor position.

**Want the full story?** Read [Article.md](Article.md) to learn how this plugin was created using Claude Code at DrupalCon Chicago 2026.

## Quick Start

### Prerequisites

- Drupal 10.1+ or 11.x
- CKEditor 5 (included with Drupal core)
- Drush (recommended)

### Installation

1. Copy this module to your Drupal installation:

   ```bash
   # Place in modules/custom/ directory
   cp -r ckeditor5_timestamp /path/to/drupal/web/modules/custom/
   ```

2. Enable the module:

   ```bash
   drush en ckeditor5_timestamp
   drush cr
   ```

3. Configure a text format:
   - Go to `/admin/config/content/formats`
   - Edit a text format using CKEditor 5 (e.g., "Full HTML")
   - Drag the "Timestamp" button to your toolbar
   - Save configuration

### Usage

Click the "Timestamp" button in the editor toolbar to insert the current date and time at the cursor position.

## Use as a Starter Template

This project is designed to help you create your own CKEditor 5 plugins for Drupal. Two files guide the process:

### [SKILL.md](SKILL.md)

A comprehensive guide teaching Claude Code (or any developer) how to:

- Explore existing CKEditor implementations in a Drupal codebase
- Create all necessary module files
- Handle the DLL bundling requirement
- Troubleshoot common issues

### [PROMPT.md](PROMPT.md)

A customizable template for creating new plugins:

- Replace the plugin requirements with yours
- Specify your module name
- Define the UI type you need (toolbar, context menu, etc.)

### Creating Your Own Plugin

```text
Please create a CKEditor 5 plugin for Drupal following the SKILL.md approach.

My requirements:
- Plugin function: [describe what it should do]
- Module name: [your_module_name]
- UI type: [toolbar button / context menu / dialog]
```

## Documentation Links

- **Drupal**: [Creating Modules](https://www.drupal.org/docs/develop/creating-modules)
- **CKEditor 5**: [Creating Simple Plugin Tutorial](https://ckeditor.com/docs/ckeditor5/latest/framework/tutorials/creating-simple-plugin-timestamp.html)
- **CKEditor 5**: [Plugin Development Guide](https://ckeditor.com/docs/ckeditor5/latest/framework/architecture/plugins.html)

## Plugin Extension Points

When creating your own plugin, consider these extension options:

### Toolbar Button Configuration

```javascript
button.set({
  label: 'My Plugin',     // Button text
  withText: true,         // Show text (false = icon only)
  tooltip: true,          // Enable tooltip on hover
  icon: mySvgIcon,        // Custom SVG icon
});
```

### Plugin Configuration (Admin Settings)

Add configurable options in your `.ckeditor5.yml`:

```yaml
my_plugin_id:
  ckeditor5:
    plugins:
      - myPlugin.MyPlugin
    config:
      myPlugin:
        defaultValue: 'example'
  drupal:
    label: My Plugin
    library: my_module/my_plugin
    admin_library: my_module/admin
    toolbar_items:
      myButton:
        label: My Button
    elements: false
```

### Modal Dialogs

For plugins requiring user input, use CKEditor 5's dialog system:

```javascript
import { Dialog } from 'ckeditor5/src/ui';

// Create a dialog with form inputs
// See: https://ckeditor.com/docs/ckeditor5/latest/framework/architecture/ui-library.html
```

### Custom Elements & Formatting

For plugins that create new HTML elements:

```javascript
// Define schema
editor.model.schema.register('myElement', {
  inheritAllFrom: '$block'
});

// Define conversion (model <-> view)
editor.conversion.elementToElement({
  model: 'myElement',
  view: 'div'
});
```

Update `.ckeditor5.yml` to declare allowed elements:

```yaml
elements:
  - <div class="my-class">
```

## Project Structure

```text
ckeditor5_timestamp/
├── ckeditor5_timestamp.info.yml      # Module metadata
├── ckeditor5_timestamp.ckeditor5.yml # CKEditor plugin definition
├── ckeditor5_timestamp.libraries.yml # JavaScript library config
├── js/
│   ├── build/
│   │   └── timestamp.js              # Bundled UMD (production)
│   └── ckeditor5_plugins/
│       └── timestamp/src/
│           └── index.js              # Source ES module (development)
├── src/
│   └── Plugin/
│       └── CKEditor5Plugin/
│           └── Timestamp.php         # PHP plugin class
├── SKILL.md                          # Guide for creating plugins
├── PROMPT.md                         # Customizable prompt template
└── Article.md                        # Full story/blog post
```

## Important: DLL Bundling Pattern

Drupal's CKEditor 5 uses a **DLL (Dynamic Link Library) pattern**. Raw ES modules will not work and will produce:

```text
Uncaught SyntaxError: Cannot use import statement outside a module
```

**Solution**: Plugins must be bundled in UMD format and export to the `CKEditor5.{namespace}` global. The bundled version goes in `js/build/`.

For details, see:

- [CKEditor DLL Architecture](https://ckeditor.com/blog/ckeditor-14-updates-to-move-faster/#developer-experience-improvements)
- [Import Maps Discussion](https://github.com/ckeditor/ckeditor5/issues/15739) (future improvements)

## Resources

| Resource                  | Description                                       |
| ------------------------- | ------------------------------------------------- |
| [SKILL.md](SKILL.md)      | Comprehensive guide for creating CKEditor 5 plugins |
| [PROMPT.md](PROMPT.md)    | Template prompt for Claude Code                   |
| [Article.md](Article.md)  | The full DrupalCon Chicago story                  |
| [GitHub Repository](https://github.com/Simply007/drupalcon-chicago-26-ckeditor-ai-playground) | Source code and updates |

## Compatibility

| Component  | Version                    |
| ---------- | -------------------------- |

~~~

## License

Source: LICENSE

~~~text
SPDX-License-Identifier: GPL-2.0-or-later

This project is licensed under the GNU General Public License v2.0 or later.

You may obtain a copy of the license at:
https://www.gnu.org/licenses/old-licenses/gpl-2.0.html

This is the same license used by Drupal core.

~~~
