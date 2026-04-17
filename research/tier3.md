# Tier 3 Repositories Analysis

**drupal_ai (https://www.drupal.org/project/drupal_ai):** This project focuses on AI integration *for Drupal sites* (e.g., providing LLM providers, recipes, and features for end-users or site builders), rather than AI tooling *for developing* Drupal. It is fundamentally out of scope for the `ai_best_practices` initiative, which targets developer workflows and agent skills.

**drupal_devkit (https://www.drupal.org/project/drupal_devkit):** Verified to exist via a successful HTTP 200 check. It is likely a developer toolkit for Drupal but seems to be a broader developer utility module rather than a dedicated AI agent skill framework, though it may contain useful developer commands.

**awesome-drupal-ai (https://github.com/AJV009/awesome-drupal-ai):** This is an "awesome list" directory rather than an executable toolkit or target repository. It is highly useful as a discovery index for finding other Drupal AI modules, tools, and discussions, but contains no actual skill definitions or agent context files to analyze or absorb.

**Zivtech Demos Landscape (https://zivtech.github.io/zivtech-demos/drupal-ai-skills-landscape.html):** A static presentation and landscape map produced by Zivtech that outlines the current ecosystem of Drupal AI skills. It serves as historical and conceptual context for mapping the space, but does not host any standalone executable artifacts or agent skills.

**skills.sh (https://skills.sh/?q=drupal):** The search results page on the `skills.sh` registry for Drupal-related packages. It demonstrates the distribution channel for `agentskills.io` compliant skills (like those aggregated by Surge) and acts purely as a package manager index rather than a repository of original content.

*Note on Special Case (`ai_skills`): This repository was cloned and inspected. Its `README.md` confirms it is an unmaintained aggregator that points to external repositories (e.g., `drupal-coding-standards-skill`, `drupal-contribute-fix`), which are already covered in the Tier 2 analysis. It contains no unique skill content worth extracting directly, so it is safely ignored in favor of its sources.*
