# drupaltools-skills Index

## Repo Facts

- Path: /Users/webchick/Documents/Codex/2026-04-17-research-drupal-ai-tooling-landscape-synthesis-2/research/repos/drupaltools-skills
- Last commit date: 2026-04-16 10:00:03 +0300
- Skill count (SKILL.md): 27

## Presence / Absence

- CLAUDE.md: no
- AGENTS.md: no
- skills/: yes
- .claude/skills/: no
- agents/: yes
- commands/: no
- hooks/: no
- .claude/: no
- prompts/: no
- evals/: no
- composer.json: no
- package.json: no
- skills.yaml: no
- Any SKILL.md files: yes

## File Tree (Depth 3)

~~~text
.
./.github
./.github/workflows
./.github/workflows/opencode.yml
./.gitignore
./INDEX.md
./LICENSE
./README.md
./agents
./agents/drupal-backend-dev.md
./agents/drupal-code-archaeologist.md
./agents/drupal-content-architect.md
./agents/drupal-core-contributor.md
./agents/drupal-devops-engineer.md
./agents/drupal-documentation-expert.md
./agents/drupal-frontend-dev.md
./agents/drupal-performance-engineer.md
./agents/drupal-security-engineer.md
./agents/drupal-tech-lead.md
./skills
./skills/drupaltools-best-practices
./skills/drupaltools-best-practices/SKILL.md
./skills/drupaltools-checklist-development
./skills/drupaltools-checklist-development/SKILL.md
./skills/drupaltools-code-search
./skills/drupaltools-code-search/SKILL.md
./skills/drupaltools-code-search/dsearch.py
./skills/drupaltools-coding-standards
./skills/drupaltools-coding-standards/SKILL.md
./skills/drupaltools-contrib-gitlab-ci
./skills/drupaltools-contrib-gitlab-ci/SKILL.md
./skills/drupaltools-contrib-lookup
./skills/drupaltools-contrib-lookup/SKILL.md
./skills/drupaltools-contrib-readme
./skills/drupaltools-contrib-readme/SKILL.md
./skills/drupaltools-contrib-search
./skills/drupaltools-contrib-search/SKILL.md
./skills/drupaltools-contrib-search/csearch.py
./skills/drupaltools-contrib-validator
./skills/drupaltools-contrib-validator/DECISIONS.md
./skills/drupaltools-contrib-validator/README.md
./skills/drupaltools-contrib-validator/SKILL.md
./skills/drupaltools-contrib-validator/references
./skills/drupaltools-contrib-validator/scripts
./skills/drupaltools-cost-estimation
./skills/drupaltools-cost-estimation/SKILL.md
./skills/drupaltools-developer-setup
./skills/drupaltools-developer-setup/SKILL.md
./skills/drupaltools-git-blame
./skills/drupaltools-git-blame/SKILL.md
./skills/drupaltools-git-blame/fetch-blame.py
./skills/drupaltools-issue-generate
./skills/drupaltools-issue-generate/SKILL.md
./skills/drupaltools-maintenance-contract
./skills/drupaltools-maintenance-contract/SKILL.md
./skills/drupaltools-migration-plan
./skills/drupaltools-migration-plan/SKILL.md
./skills/drupaltools-module-clone
./skills/drupaltools-module-clone/SKILL.md
./skills/drupaltools-module-info
./skills/drupaltools-module-info/SKILL.md
./skills/drupaltools-module-info/drupal-module-info.py
./skills/drupaltools-module-rename
./skills/drupaltools-module-rename/SKILL.md
./skills/drupaltools-onboarding
./skills/drupaltools-onboarding/SKILL.md
./skills/drupaltools-oop-hooks
./skills/drupaltools-oop-hooks/SKILL.md
./skills/drupaltools-optimize
./skills/drupaltools-optimize/SKILL.md
./skills/drupaltools-patch
./skills/drupaltools-patch/SKILL.md
./skills/drupaltools-postmortem
./skills/drupaltools-postmortem/SKILL.md
./skills/drupaltools-postmortem/examples
./skills/drupaltools-site-audit
./skills/drupaltools-site-audit/SKILL.md
./skills/drupaltools-site-clone
./skills/drupaltools-site-clone/SKILL.md
./skills/drupaltools-tip-generator
./skills/drupaltools-tip-generator/SKILL.md
./skills/drupaltools-translations
./skills/drupaltools-translations/SKILL.md
~~~

## File Type Counts

~~~text
.md	46
.py	6
.yml	1
[dotfile-no-ext]	1
[no-ext]	1
~~~

## README (First 200 Lines)

Source: README.md

~~~text
# drupaltools-skills

A collection of AI Skills for Drupal development.

## Install

Install individual skills with [npx skills](https://skills.sh):

```bash
npx skills add https://github.com/drupaltools/skills
```

Or install all at once by cloning this repo into your skills directory:

```bash
# Claude Code
git clone https://github.com/drupaltools/skills.git ~/.claude/skills/drupaltools-skills

# Agents that use ~/.agents/skills
git clone https://github.com/drupaltools/skills.git ~/.agents/skills/drupaltools-skills
```

## Skills

| Skill | Description |
|---|---|
| `drupaltools-best-practices` | Audit code against Drupal best practices |
| `drupaltools-checklist-development` | Guide teams through Drupal project development checklists |
| `drupaltools-code-search` | Search Drupal contrib module source code via GitLab API |
| `drupaltools-coding-standards` | Check Drupal PHP code with PHPCS and PHPStan |
| `drupaltools-contrib-gitlab-ci` | Generate GitLab CI for Drupal modules |
| `drupaltools-contrib-lookup` | Find the online source URL for a contrib code snippet |
| `drupaltools-contrib-readme` | Generate and validate Drupal module README files |
| `drupaltools-contrib-search` | Search Drupal contrib and core source code via search.tresbien.tech API |
| `drupaltools-contrib-validator` | Validate modules for Drupal.org contribution readiness |
| `drupaltools-cost-estimation` | Estimate costs and timeline for Drupal projects |
| `drupaltools-developer-setup` | Optimize Drupal developer machine setup and tooling |
| `drupaltools-git-blame` | Generate a git.drupalcode.org blame URL and fetch commit details for a contrib code snippet |
| `drupaltools-issue-generate` | Generate Drupal.org issue summaries ready for issue forms |
| `drupaltools-maintenance-contract` | Drupal maintenance and support contract templates |
| `drupaltools-migration-plan` | Guide for planning Drupal site migrations and upgrades |
| `drupaltools-module-clone` | Clone a module as a structural scaffold with renamed machine name |
| `drupaltools-module-info` | Identify which module owns a file or code snippet |
| `drupaltools-module-rename` | Rename a module's machine name throughout its codebase |
| `drupaltools-onboarding` | Step-by-step onboarding checklist for Drupal newcomers |
| `drupaltools-oop-hooks` | Generate Drupal 11 OOP code for hooks, plugins, and events |
| `drupaltools-optimize` | Optimize Drupal PHP code for the current Drupal/PHP version |
| `drupaltools-patch` | Apply patches to contrib modules from any source |
| `drupaltools-postmortem` | Generate post-mortem reports for Drupal projects |
| `drupaltools-site-audit` | Generate Drupal site audit reports for RFPs and proposals |
| `drupaltools-site-clone` | Clone a Drupal project as a clean starter template |
| `drupaltools-tip-generator` | Show or generate a random Drupal tip |
| `drupaltools-translations` | Guide for Drupal multilingual and translation workflows |

## Agents

| Agent | Description |
|---|---|
| `drupal-backend-dev` | Backend development tasks including custom modules, services, plugins, and API integrations |
| `drupal-code-archaeologist` | Analyze legacy Drupal codebases for upgrade preparation and migration planning |
| `drupal-content-architect` | Design content models, configure entity relationships, and build editorial experiences |
| `drupal-core-contributor` | Work on Drupal core contributions, patches, and merge requests |
| `drupal-devops-engineer` | Design, deploy, and maintain Drupal hosting infrastructure with automation |
| `drupal-documentation-expert` | Create technical documentation, user guides, API specs, and architecture diagrams |
| `drupal-frontend-dev` | Frontend development tasks including theming, SDC components, and Twig templates |
| `drupal-performance-engineer` | Diagnose and resolve Drupal performance issues with data-driven solutions |
| `drupal-security-engineer` | Audit code for security vulnerabilities and implement hardening measures |
| `drupal-tech-lead` | Expert Drupal technical leadership for architecture decisions, team coordination, and project governance |

## Collections of Drupal skills

- [skills.sh - Search for Drupal](https://skills.sh/trending?q=drupal) - Skill aggregator, search for Drupal skills
- [skillsmp.com - Search for Drupal](https://skillsmp.com/search?q=drupal) - Skill aggregator, search for Drupal skills

## Similar tools

- [AI Skills](https://www.drupal.org/project/ai_skills) - Drupal module providing AI skills
- [claude-code-skill-factory](https://github.com/alirezarezvani/claude-code-skill-factory) - Skill factory for Claude Code
- [claude-skills/php-pro](https://github.com/Jeffallan/claude-skills/tree/main/skills/php-pro) - PHP Pro skill
- [claude-toolbox](https://github.com/kanopi/claude-toolbox) - Kanopi's Claude toolbox
- [claude_code_skills_drupal](https://github.com/askibinski/claude_code_skills_drupal) - Drupal skills for Claude Code
- [cms-cultivator](https://github.com/kanopi/cms-cultivator/tree/main/skills) - Kanopi's CMS skill collection
- [cursorrules](https://github.com/ivangrynenko/cursorrules) - Cursor rules for Drupal
- [Drupal DDEV Setup](https://github.com/jamieaa64/Drupal-DDEV-Setup-Claude-Skill) - DDEV setup skill
- [drupal-agent-resources](https://github.com/madsnorgaard/drupal-agent-resources) - Drupal agent resources
- [drupal-claude-code-sub-agent-collective](https://github.com/gkastanis/drupal-claude-code-sub-agent-collective/tree/main/templates/skills) - Sub-agent collective with Drupal skill templates
- [drupal-claude-skills](https://github.com/grasmash/drupal-claude-skills) - Grasmash's Drupal Claude skills
- [drupal-contribute-fix](https://github.com/scottfalconer/drupal-contribute-fix) - Turn local Drupal fixes into contributions
- [drupal-issue-queue](https://github.com/scottfalconer/drupal-issue-queue) - Drupal issue queue skill
- [drupal-skill](https://github.com/Omedia/drupal-skill) - Omedia's Drupal skill
- [drupal-workflow](https://github.com/gkastanis/drupal-workflow) - Drupal AI workflow resources
- [drupaldev-claude-skill](https://github.com/nonzod/drupaldev-claude-skill) - Drupal dev skill for Claude
- [drupalorg-cli](https://github.com/mglaman/drupalorg-cli/tree/main/skills) - Skills for the drupalorg CLI
- [lakedrops skills](https://gitlab.lakedrops.com/ai/skills) - Lakedrops Drupal skills
- [Surge](https://www.drupal.org/project/surge) - Drupal module with AI-assisted development tools
- [waap-drupal](https://github.com/proofoftom/waap-drupal/tree/main/.claude/skills) - WAAP Drupal skills

## License

[GPL v2](LICENSE) 2026

~~~

## License

Source: LICENSE

~~~text
drupaltools-skills
Copyright (C) 2026 DrupalTools (managed by Theodoros Ploumis)

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

~~~
