# claude-skill-drupal-module Index

## Repo Facts

- Path: /Users/webchick/Documents/Codex/2026-04-17-research-drupal-ai-tooling-landscape-synthesis-2/research/repos/claude-skill-drupal-module
- Last commit date: 2026-02-10 14:59:02 +0100
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
- composer.json: yes
- package.json: no
- skills.yaml: no
- Any SKILL.md files: yes

## File Tree (Depth 3)

~~~text
.
./.github
./.github/workflows
./.github/workflows/check-versions.yml
./CHANGELOG.md
./INDEX.md
./LICENSE.txt
./README.md
./SKILL.md
./VERSIONS.md
./composer.json
./ddev-commands
./ddev-commands/phpcbf
./ddev-commands/phpcs
./ddev-commands/phpstan
./ddev-commands/phpunit
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
~~~

## File Type Counts

~~~text
.json	1
.md	18
.txt	1
.yml	1
[no-ext]	4
~~~

## README (First 200 Lines)

Source: README.md

~~~text
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

~~~

## License

Source: LICENSE.txt

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
