---
title: How to create a new xPack Git repository
permalink: /develop/how-to-new-git/

date: 2019-07-09 17:48:00 +0300

---

The technical definition of an xPack is _a folder which includes a
package.json file with some minimal content_
([full definition]({{ site.baseurl }}/intro/));
it does not require
any special structure for the folders or for the version-control system,
if any.

## Projects with 3rd party content

The first thought is that xPacks, as a new technology,
will be used for new projects,
with original content, so, in principle, these projects can be created
to have any structure.

In reality there are a lot of existing 3rd party
software projects, each using its specific structure, and migrating them to
xPacks may add some maintenance burden to keep them in sync with the
originals.

If the 3rd party projects use a public Git, fork them, with its original
`master` branch, and continue to track them in the future.

## The `originals` branch

If the 3rd party projects do not use a
public Git project, but are distributed only as release archives, to
keep track of the changes it is recommended to
recreate the Git with the original
code on a separate branch, like `originals`.

With each upstream release, while on the `originals` branch,
fuly remove the content and extract the newly released archive.

In case the archive contains binary files, or other large files considered
not essential for the xPack distribution, add them to `.gitignore`.

## The `xpack` branch and three-way merging

One way to reduce the maintenance burden of source xPacks is to use the
[three-way merge](https://en.wikipedia.org/wiki/Merge_(version_control)#Three-way_merge)
feature of Git and a separate branch to accommodate the xPack specific changes.

This method does not require any changes to the original project, which can
keep its original structure, with its original branches, regardless
their names.

The only requirement is to create a new branch (preferably named `xpack`)
and to keep the changes on it; thus the main branch (probably `master`) can
easily track the upstream repository, while the xPack specific changes
continue to be developed using the `xpack` branch; from time to time the
main branch can be merged into the `xpack` branch and things kept in sync.

## Creating xPacks

For consistency reasons, it is recommended for the new xPacks, even if
they do not include 3rd party content, to use the `xpack` branch instead
of the `master` branch.

{% include note.html content="The xPack tools do not require and
do not enforce the use of a branch named `xpack`, this is only
a recommendation." %}

### Do not use a GitHub Template project

The easiest way to create new projects would be to use an existing
GitHub Template project.

Unfortunately this path leads to repositories with weirds histories,
like disconnected commits, and is not practical.

### Create the GitHub project manually

The following steps apply to GitHub. Adjust them for other Git hosting sites.

The editor of choice is Visual Studio Code (VS Code), but you can use
any editor you like; just be sure that on Windows it does not mess the
line terminators.

{% include tip.html content="To easily identify the project as
an xPack, it is recommended to suffix the project name with '-xpack'." %}

With a browser, at GitHub, select your account or organisation.
(for the purposes of this project, here are some organisations that use xPacks:
[xPacks](https://github.com/xpacks),
[xPacks Dev Tools](https://github.com/xpack-dev-tools),
[µOS++](https://github.com/micro-os-plus)).

- click the green **New** button to create a new repository
  - enter **Repository name**; use all lowercase and hyphens to
    separate words (not underscores!); preferably suffix the name with `-xpack`
  - enter **Description** (like _A source xPack with ..._ or _A binary xPack with ..._; no ending dot!)
  - select **Public**
  - enable **Initialize this repository with a README**
  - select **Add .gitignore: Node**
  - select **Add a license: MIT License**; this is the license of
    choice for xPacks, but any other license of your choice is also ok
  - click the **Create Repository** button
- select the **Settings** tab
  - in the **Features** section, disable the **Wikis** and **Projects** options

### Clone the repository to a local folder

- select the GitHub project
- select the **Code** tab
- click the **Clone or download** button; this will open a
  small **Clone to HTTPS** window
- click the **Copy** icon, or explicitly copy the URL
- in a terminal window, in a place of our choice, create a folder
  to store all xPacks (for example it can be named `xpacks`):

```sh
mkdir -p xpacks
cd xpacks
git clone https://github.com/<user>/<project>.git <project>.git
```

### Edit the `.gitignore` file

With Visual Studio Code:

- add the following to `.gitignore`:

```text
# xpm
xpacks/

# Windows
Thumbs.db

# macOS
.DS_Store

# end

```

- for Eclipse C/C++ projects you can include:

```text
# Eclipse
.settings/
Debug/
Release/
test-*/
build/
```

With VS Code, Sourcetree or Git:

- stage the `.gitignore` file
- commit with the following message: **.gitignore: add xPack specifics**

### Check/edit the `LICENSE` file

The automatically generated `LICENSE` file already includes the
user name as the copyright owner. When the project is owned by
an organisation, the name refers to the organisation. Probably
this is not exactly what you need, and you might prefer to have
your name in the copyright notice.

Check and possibly adjust to match your `LICENSE` requirements.

```text
MIT License

Copyright (c) 2021 Liviu Ionescu

Permission is hereby granted, free of charge, to any person obtaining a copy
...
```

With VS Code, Sourcetree or Git:

- stage the `LICENSE` file
- commit with the following message: **LICENSE: update copyright owner**

### Edit the master `README.md` file

As mentioned in the introduction,
although for original xPacks there are no constraints on how to
organise the branches, for consistency with xPacks that use 3rd
party content, it is recommended to use an `xpack` branch.

In this case, to warn users about this configuration, edit
the `README.md` file and replace its entire content with:

```text
This project does not use the `master` branch, please
switch to the `xpack` branch to get the project files.

```

With VS Code, Sourcetree or Git:

- stage the `README.md` file
- commit with the following message: **README: 'no master' notice**

### Create the `originals` branch

If the xPack will be used for 3rd party content, create an `originals`
branch:

Sourcetree:

- select the `master` branch
- click the **Branch** button
- in the **Name Branch** field, enter `originals`
- click the **Create Branch** button

Edit the README file to read:

```text
This branch is used to recreate the 3rd party project history
from release archives.
```

With VS Code, Sourcetree or Git:

- stage the `README.md` file
- commit with the following message: **README: notice for 3rd party content**

### Create the `xpack` branch

With VS Code, Sourcetree or Git.

- VS Code menu **View** → **Command Palette...**
  - **Git: Create branch**

(or with Git view, **...** → **Branch** → **Create Branch...**)

Sourcetree:

- select the `master` branch
- click the **Branch** button
- in the **Name Branch** field, enter `xpack`
- click the **Create Branch** button

### Publish all branches

With VS Code, Sourcetree or Git.

With Sourcetree:

- click the **Push** button
- select all local branches (`master`, `xpack` and maybe the `originals`)
- click the **OK** button

With the GitHub web interface (as shortcut, in Sourcetree, click
the **View Remote** button):

- select the **Settings** tab
- select the **Branches** grouping
- change the **Default branch** to `xpack`
- click the **Update** button
- click the **I understand, update the default branch** confirmation window

### Create the npm/xpm `package.json`

Select the `xpack` branch.

Use `xpm init` and later edit the `package.json`.

```console
$ cd <project>.git
$ xpm init --verbose
$ cat package.json
{
  "name": "@<scope>/<project-name>",
  "version": "0.1.0",
  "description": "A source/binary xPack with <your-description-here>",
  "main": "",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "repository": {
    "type": "git",
    "url": "https://github.com/<user-id>/<project-name>-xpack.git"
  },
  "bugs": {
    "url": "https://github.com/<user-id>/<project-name>-xpack/issues"
  },
  "homepage": "https://github.com/<user-id>/<project-name>-xpack",
  "keywords": [
    "xpack"
  ],
  "author": {
    "name": "<author-name>",
    "email": "<author-email>",
    "url": "<author-url>"
  },
  "license": "MIT",
  "config": {},
  "dependencies": {},
  "devDependencies": {},
  "xpack": {}
}
$
```

Open `package.json` with Visual Studio Code:

- as **name** enter the scope (your npm account name or one of
  your npm organisations) and the project name, without `-xpack.git`
  (like `@micro-os-plus/diag-trace`, `@xpack-dev-tools/ninja-build`)
- as **version**, enter `0.1.0` if the project is in early development,
  or accept 1.0.0 for the first stable release; generally use the
  [semver](http://semver.org) conventions
- as **description**, use the same string as the GitHub project description
- in **scripts**, check and possibly remove a trailing comma,
- as **url** and **homepage**, use the actual project Git URL
- as **author**, enter full data, like

```json
{
  "author": {
    "name": "Liviu Ionescu",
    "email": "ilg@livius.net",
    "url": "https://github.com/ilg-ul/"
  }
}
```

- as **license**, enter the [SPDX](https://spdx.org/licenses/) license
  identifier (like `MIT`); if the license is not a standard one, provide
  the text in a `LICENSE` file and update the JSON to read:

```json
{ "license": "SEE LICENSE IN <filename>" }
```

- if the package is inspired by other existing code, enter the author
  as the first contributor, for example:

```json
{
  "contributors": [
    {
      "name": "SEGGER Microcontroller GmbH & Co. KG",
      "email": "support@segger.com",
      "url": "https://www.segger.com/"
    }
  ]
}
```

### Commit the initial package file

With VS Code, Sourcetree or Git:

- stage the `package.json`
- commit with the following message: **package.json: v0.1.0**

### Edit the `README.md` file with actual content

With the editor of your choice:

- start with some badges
- as headers, you can start with H1, the npmjs server now shows it
- after the main title, copy the project description
- explain how to install the xPack
  (like `xpm install --global @scope/name`)
- in the License section, use something like

```markdown
### License

The original content is released under the
[MIT License](https://opensource.org/licenses/MIT), with all rights reserved to
[Liviu Ionescu](https://github.com/ilg-ul/).
```

With Sourcetree or Git:

- stage the `README*.md` files
- commit with the following message: **README: preliminary content**

### Publish the initial version to GitHub

With Sourcetree or Git:

- click the **Push** button (to push the `xpack` branch to the server)

### Add more content

- add project files

### Commit the initial content

With Sourcetree or Git:

- stage the new files
- commit with the following message: **add initial content**

### Create the `xpack-develop` branch

With Sourcetree or Git:

- select the `xpack` branch
- create the `xpack-develop` branch

Generally work in the `xpack-develop` branch and only when ready merge it
to `master`.

### Publish the branches to GitHub

- with Sourcetree or Git, click **Push** and select all
  (or at least `xpack` and `xpack-develop`)

### Publish the initial version to the npmjs public registry

- check the latest commits `npm run git-log`
- update `CHANGELOG.md`; commit with a message like
  _CHANGELOG: prepare npm v1.10.0-1.1_
- `npm version v1.10.0-1.1`; the first 4 numbers are the same as the
  GitHub release; the fifth number is the npm specific version
- `npm pack` and check the content of the archive, which should list
only the `package.json`, the `README.md`, `LICENSE` and `CHANGELOG.md`
- push all changes to GitHub
- `npm publish --access public --tag next`

When the release is considered stable, promote it as `latest`. For example:

- `npm dist-tag ls @xpack-dev-tools/ninja-build`
- `npm dist-tag add @xpack-dev-tools/ninja-build@1.10.0-1.1 latest`
- `npm dist-tag ls @xpack-dev-tools/ninja-build`

### Bump version

In general, depending on the _disruption_ degree, chose one of the following:

```console
$ cd <project>.git
$ npm version patch
$ npm version minor
$ npm version major
```

With Sourcetree or Git:

- click **Push**, to push the commits
