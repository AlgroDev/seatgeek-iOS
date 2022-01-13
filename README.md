# seatgeek-iOS

 The following contributing guidelines intend to ease contribution on this project. These are mostly guidelines, not rules.

## Table of Contents

* [Styleguides](#styleguides)
	* [Git Commit Messages](#git-commit-messages)
	* [Issue Reference](#issue-reference)
	* [Commit Nature](#commit-nature)

## Styleguides

### Git Commit Messages

Git commit messages should help reviewers to do better reviews.

* Write short messages (we recommend 72 characters or less)
* Use the present tense
* Use the imperative mood
* Start your commit with feat(component_Name) and `:emoji-to-use:` to make the nature of your commit clear.

**Preferred:**

- feat(articles) 🎨 Improve cache management.
- feat(articles) 🔥 Remove unused ViewController method.


**Not Preferred:**

- Improve cache management.
- #1024 Remove unused ViewController method.


### Commit Nature

Emojis should help reviewers to quickly and visually identify the nature of the commit. For clear visual identification start the commit message with an applicable emoji:

🎨
`:art:`
Improving structure / format of the code.

⚡️
`:zap:`
Improving performance.

🔥
`:fire:`
Removing code or files.

🐛
`:bug:`
Fixing a bug.

🚑
`:ambulance:`
Critical hotfix.

✨
`:sparkles:`
Introducing new features.

📝
`:memo:`
Writing docs.

🚀
`:rocket:`
Updating the UI and style files.

🔒
`:lock:`
Fixing security issues.

✅
`:white_check_mark:`
Releasing / Version tags.

🚧
`:construction:`
Work in progress.

💚
`:green_heart:`
Fixing CI Build.

⬇️
`:arrow_down:`
Downgrading dependencies.

⬆️
`:arrow_up:`
Upgrading dependencies.

👷
`:construction_worker:`
Adding CI build system.

📈
`:chart_with_upwards_trend:`
Adding analytics or tracking code.

♻️
`:recycle:`
Refactoring code.

➖
`:heavy_minus_sign:`
Removing a dependency.

➕
`:heavy_plus_sign:`
Adding a dependency.

🔧
`:wrench:`
Changing configuration files.

🌐
`:globe_with_meridians:`
Internationalization and localization.

⏪
`:rewind:`
Reverting changes.

👌
`:ok_hand:`
Updating code due to code review changes.

🏗
`:building_construction:`
Making architectural changes.


