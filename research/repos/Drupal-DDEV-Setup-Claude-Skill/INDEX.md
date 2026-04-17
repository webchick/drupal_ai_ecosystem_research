# Drupal-DDEV-Setup-Claude-Skill Index

## Repo Facts

- Path: /Users/webchick/Documents/Codex/2026-04-17-research-drupal-ai-tooling-landscape-synthesis-2/research/repos/Drupal-DDEV-Setup-Claude-Skill
- Last commit date: 2025-11-12 20:38:19 +0000
- Skill count (SKILL.md): 0

## Presence / Absence

- CLAUDE.md: no
- AGENTS.md: no
- skills/: no
- .claude/skills/: yes
- agents/: no
- commands/: no
- hooks/: no
- .claude/: yes
- prompts/: no
- evals/: no
- composer.json: no
- package.json: no
- skills.yaml: no
- Any SKILL.md files: no

## File Tree (Depth 3)

~~~text
.
./.claude
./.claude/skills
./.claude/skills/drupal-setup
./.gitignore
./CurrentWorkflow.md
./HISTORY.md
./INDEX.md
./INSTALL.md
./LICENSE
./README.md
./SKILL_IMPROVEMENTS.MD
./package-skill.sh
./plan.md
~~~

## File Type Counts

~~~text
.md	11
.php	1
.sh	2
.yaml	1
[dotfile-no-ext]	1
[no-ext]	2
~~~

## README (First 200 Lines)

Source: README.md

~~~text
# Drupal Setup & Development Skill for Claude Code

A comprehensive Claude Code skill for the complete Drupal development lifecycle - from project creation to team collaboration and ongoing maintenance.

**Works in both Claude Code CLI (local) and Web environments.**

## ⚡ Quick Start

### 1. Install the Skill

**See [INSTALL.md](INSTALL.md) for detailed installation instructions.**

**Quick install (Claude Code CLI):**
```bash
# Clone repository
git clone https://github.com/jamieaa64/Drupal-DDEV-Setup-Claude-Skill.git
cd Drupal-DDEV-Setup-Claude-Skill

# Copy to user skills directory
mkdir -p ~/.claude/skills
cp -r .claude/skills/drupal-setup ~/.claude/skills/
```

**Quick install (Claude Code Web):**
```bash
# Package the skill
./package-skill.sh

# Upload drupal-setup-skill.zip to Claude Code Web
```

### 2. Use the Skill

**New project:**
```
Create a new Drupal site called "my-project"
```

**Existing project:**
```
Set up this existing Drupal project
```

**Update after pulling:**
```
Update my local Drupal environment
```

## 🎯 What This Skill Does

### For New Projects
- **30-second setup** with organizational best practices
- Creates Drupal 11 Core or Drupal CMS projects
- Generates all configuration files (settings.php, .gitignore, DDEV config)
- Sets up Git repository and pushes to GitHub
- Includes comprehensive documentation

### For Existing Projects
- **2-minute onboarding** for new team members
- Automatic environment sync after pulling changes
- One-command reset for clean slate
- Works with or without DDEV
- Environment-aware (adapts to local CLI vs web)

### Key Features
- ✅ Intelligent scenario detection (new vs existing project)
- ✅ Environment detection (DDEV vs web)
- ✅ Template-based Quick Mode (fast, production-aligned)
- ✅ Optional Full Mode (SQLite for testing)
- ✅ Complete lifecycle management (setup → develop → maintain)
- ✅ Team collaboration workflows

## 📚 Documentation

- **[INSTALL.md](INSTALL.md)** - Complete installation guide
- **[plan.md](plan.md)** - Architecture and design decisions
- **[CurrentWorkflow.md](CurrentWorkflow.md)** - Organization's Drupal workflow
- **[.claude/skills/drupal-setup/README.md](.claude/skills/drupal-setup/README.md)** - Detailed skill documentation

## 🚀 Usage Examples

### Scenario 1: Creating a New Project

```
You: "Create a new Drupal site called 'client-portal'"

Claude: I'll help you set up a new Drupal project!

1. Project name: client-portal
2. Drupal variant: [1] Drupal 11 Core / [2] Drupal CMS / [3] Minimal
   Choice: 1
3. Setup mode: [1] Quick (30s) / [2] Full (5-8min)
   Choice: 1 (default)
4. GitHub repository: https://github.com/org/client-portal
5. Include common modules? Y

✓ Project created in 30 seconds!
✓ Pushed to GitHub
✓ Ready for team to clone and deploy
```

### Scenario 2: New Team Member Onboarding

```bash
# New developer joins team
git clone https://github.com/org/client-portal
cd client-portal
```

```
You: "Set up this existing Drupal project"

Claude: This looks like an existing Drupal project!

What would you like to do?
[1] Initial setup (first time working on this project)
[2] Update after pulling changes
[3] Reset local environment
[4] Create new project instead

Choice: 1

[With DDEV - Fully Automated]
✓ ddev start
✓ ddev composer install
✓ ddev drush site:install --existing-config
✓ ddev launch

Done! Site ready at https://client-portal.ddev.site
Login: admin / admin

Your local development environment is ready!
```

### Scenario 3: Syncing After Pulling Changes

```bash
git pull  # Team member pushed changes
```

```
You: "Update my local Drupal environment"

Claude: Syncing your environment...

✓ ddev composer install (new dependencies)
✓ ddev drush config:import -y (config changes)
✓ ddev drush updb -y (database updates)
✓ ddev drush cache:rebuild

Changes applied:
- Dependencies updated (composer.lock changed)
- Configuration imported (3 config files changed)
- Database updates run (2 updates)
- Cache cleared

Your local environment is now in sync with the repository!
```

### Scenario 4: Reset Broken Environment

```
You: "Reset my Drupal environment"

Claude: Resetting your local environment...

✓ ddev delete -y (removed database)
✓ ddev start
✓ ddev composer install
✓ ddev drush site:install --existing-config
✓ ddev launch

Environment reset complete!
Fresh Drupal installation with current configuration.
```

## 🏗️ Project Structure

Created projects include:

```
project-name/
├── .ddev/
│   └── config.yaml          # DDEV configuration
├── config/
│   └── sync/                # Drupal configuration (version controlled)
├── private/                 # Private files directory
├── web/                     # Drupal web root
│   ├── modules/custom/     # Custom modules
│   ├── themes/custom/      # Custom themes
│   └── sites/default/
│       ├── settings.php    # Organization-specific settings
│       └── settings.local.php
├── .gitignore              # Comprehensive Drupal .gitignore
├── composer.json           # PHP dependencies
├── README.md               # Project documentation
└── CLAUDE.md               # Claude Code guidance for this project
```

## 🔧 Requirements

~~~

## License

Source: LICENSE

~~~text
                    GNU GENERAL PUBLIC LICENSE
                       Version 2, June 1991

 Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 Everyone is permitted to copy and distribute verbatim copies
 of this license document, but changing it is not allowed.

                            Preamble

  The licenses for most software are designed to take away your
freedom to share and change it.  By contrast, the GNU General Public
License is intended to guarantee your freedom to share and change free
software--to make sure the software is free for all its users.  This
General Public License applies to most of the Free Software
Foundation's software and to any other program whose authors commit to
using it.  (Some other Free Software Foundation software is covered by
the GNU Lesser General Public License instead.)  You can apply it to
your programs, too.

  When we speak of free software, we are referring to freedom, not
price.  Our General Public Licenses are designed to make sure that you
have the freedom to distribute copies of free software (and charge for
this service if you wish), that you receive source code or can get it
if you want it, that you can change the software or use pieces of it
in new free programs; and that you know you can do these things.

  To protect your rights, we need to make restrictions that forbid
anyone to deny you these rights or to ask you to surrender the rights.
These restrictions translate to certain responsibilities for you if you
distribute copies of the software, or if you modify it.

  For example, if you distribute copies of such a program, whether
gratis or for a fee, you must give the recipients all the rights that
you have.  You must make sure that they, too, receive or can get the
source code.  And you must show them these terms so they know their
rights.

  We protect your rights with two steps: (1) copyright the software, and
(2) offer you this license which gives you legal permission to copy,
distribute and/or modify the software.

  Also, for each author's protection and ours, we want to make certain
that everyone understands that there is no warranty for this free
software.  If the software is modified by someone else and passed on, we
want its recipients to know that what they have is not the original, so
that any problems introduced by others will not reflect on the original
authors' reputations.

  Finally, any free program is threatened constantly by software
patents.  We wish to avoid the danger that redistributors of a free
program will individually obtain patent licenses, in effect making the
program proprietary.  To prevent this, we have made it clear that any
patent must be licensed for everyone's free use or not licensed at all.

  The precise terms and conditions for copying, distribution and
modification follow.

                    GNU GENERAL PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. This License applies to any program or other work which contains
a notice placed by the copyright holder saying it may be distributed
under the terms of this General Public License.  The "Program", below,
refers to any such program or work, and a "work based on the Program"
means either the Program or any derivative work under copyright law:
that is to say, a work containing the Program or a portion of it,
either verbatim or with modifications and/or translated into another
language.  (Hereinafter, translation is included without limitation in
the term "modification".)  Each licensee is addressed as "you".

Activities other than copying, distribution and modification are not
covered by this License; they are outside its scope.  The act of
running the Program is not restricted, and the output from the Program
is covered only if its contents constitute a work based on the
Program (independent of having been made by running the Program).
Whether that is true depends on what the Program does.

  1. You may copy and distribute verbatim copies of the Program's
source code as you receive it, in any medium, provided that you
conspicuously and appropriately publish on each copy an appropriate
copyright notice and disclaimer of warranty; keep intact all the
notices that refer to this License and to the absence of any warranty;
and give any other recipients of the Program a copy of this License
along with the Program.

You may charge a fee for the physical act of transferring a copy, and
you may at your option offer warranty protection in exchange for a fee.

  2. You may modify your copy or copies of the Program or any portion
of it, thus forming a work based on the Program, and copy and
distribute such modifications or work under the terms of Section 1
above, provided that you also meet all of these conditions:

    a) You must cause the modified files to carry prominent notices
    stating that you changed the files and the date of any change.

    b) You must cause any work that you distribute or publish, that in
    whole or in part contains or is derived from the Program or any
    part thereof, to be licensed as a whole at no charge to all third
    parties under the terms of this License.

    c) If the modified program normally reads commands interactively
    when run, you must cause it, when started running for such
    interactive use in the most ordinary way, to print or display an
    announcement including an appropriate copyright notice and a
    notice that there is no warranty (or else, saying that you provide
    a warranty) and that users may redistribute the program under
    these conditions, and telling the user how to view a copy of this
    License.  (Exception: if the Program itself is interactive but
    does not normally print such an announcement, your work based on
    the Program is not required to print an announcement.)

These requirements apply to the modified work as a whole.  If
identifiable sections of that work are not derived from the Program,
and can be reasonably considered independent and separate works in
themselves, then this License, and its terms, do not apply to those
sections when you distribute them as separate works.  But when you
distribute the same sections as part of a whole which is a work based
on the Program, the distribution of the whole must be on the terms of
this License, whose permissions for other licensees extend to the
entire whole, and thus to each and every part regardless of who wrote it.

Thus, it is not the intent of this section to claim rights or contest
your rights to work written entirely by you; rather, the intent is to
exercise the right to control the distribution of derivative or
collective works based on the Program.

In addition, mere aggregation of another work not based on the Program
with the Program (or with a work based on the Program) on a volume of
a storage or distribution medium does not bring the other work under
the scope of this License.

  3. You may copy and distribute the Program (or a work based on it,
under Section 2) in object code or executable form under the terms of
Sections 1 and 2 above provided that you also do one of the following:

    a) Accompany it with the complete corresponding machine-readable
    source code, which must be distributed under the terms of Sections
    1 and 2 above on a medium customarily used for software interchange; or,

    b) Accompany it with a written offer, valid for at least three
    years, to give any third party, for a charge no more than your
    cost of physically performing source distribution, a complete
    machine-readable copy of the corresponding source code, to be
    distributed under the terms of Sections 1 and 2 above on a medium
    customarily used for software interchange; or,

    c) Accompany it with the information you received as to the offer
    to distribute corresponding source code.  (This alternative is
    allowed only for noncommercial distribution and only if you
    received the program in object code or executable form with such
    an offer, in accord with Subsection b above.)

The source code for a work means the preferred form of the work for
making modifications to it.  For an executable work, complete source
code means all the source code for all modules it contains, plus any
associated interface definition files, plus the scripts used to
control compilation and installation of the executable.  However, as a
special exception, the source code distributed need not include
anything that is normally distributed (in either source or binary
form) with the major components (compiler, kernel, and so on) of the
operating system on which the executable runs, unless that component
itself accompanies the executable.

If distribution of executable or object code is made by offering
access to copy from a designated place, then offering equivalent
access to copy the source code from the same place counts as
distribution of the source code, even though third parties are not
compelled to copy the source along with the object code.

  4. You may not copy, modify, sublicense, or distribute the Program
except as expressly provided under this License.  Any attempt
otherwise to copy, modify, sublicense or distribute the Program is
void, and will automatically terminate your rights under this License.
However, parties who have received copies, or rights, from you under
this License will not have their licenses terminated so long as such
parties remain in full compliance.

  5. You are not required to accept this License, since you have not
signed it.  However, nothing else grants you permission to modify or
distribute the Program or its derivative works.  These actions are
prohibited by law if you do not accept this License.  Therefore, by
modifying or distributing the Program (or any work based on the
Program), you indicate your acceptance of this License to do so, and
all its terms and conditions for copying, distributing or modifying
the Program or works based on it.

  6. Each time you redistribute the Program (or any work based on the
Program), the recipient automatically receives a license from the
original licensor to copy, distribute or modify the Program subject to
these terms and conditions.  You may not impose any further
restrictions on the recipients' exercise of the rights granted herein.
You are not responsible for enforcing compliance by third parties to
this License.

  7. If, as a consequence of a court judgment or allegation of patent
infringement or for any other reason (not limited to patent issues),
conditions are imposed on you (whether by court order, agreement or
otherwise) that contradict the conditions of this License, they do not

~~~
