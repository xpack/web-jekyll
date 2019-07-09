---
title: How to create an xPack Git repository?
permalink: /develop/git-structure/

date: 2019-07-09 17:48:00 +0300
last_updated: 2019-06-30 10:30:18 +0300

---

The technical definition of an xPack is _a folder which includes a 
`package.json` file with some minimal content_; it does not require
any special structure for the version-control system where the 
xPack is stored, if any.

## Projects with 3rd party content

Although the first thought is that xPacks will be used for new projects,
with original content, so, in principle, these projects can be created
to use any structure, the truth is that there is a lot of existing 
software, each using its specific structure, and migrating them to
an xPack may add some maintenance burden.

## The `xpack` branch and three-way merge

One way to reduce the maintenance burden is to use:

- Git, preferably GitHub
- the [three-way merge](https://en.wikipedia.org/wiki/Merge_(version_control)#Three-way_merge) 
  feature of Git 
- and a separate branch where the xPack specific changes are kept.

This method does not require any changes to the original project, it can
maintain its original structure, with its original branches, regardless
how they are named.

The only requirement is to branch the main branch and to keep the changes
on this branch (preferably named `xpack`); in time the main branch can
easily follow the upstream repository, while the xPack specific changes
continue to be developed on the `xpack` branch; from time to time the
main branch is merged into the `xpack` branch and things kept in sync.

## Creating xPacks with original content

For consistency reasons, it is recommended for the new xPacks, even if
they do not include 3rd party content, to use the `xpack` branch instead 
the `master` branch.

{% include note.html content="The xPack tools do not require and
do not enforce the use of the `xpack` named branch, this is only
a recommendation." %}

The following steps apply to GitHub. Adjust them for other sites.

The editor of choice is Visual Studio Code (VSC), but you can use
any editor you like. 

### Create the GitHub project

{% include tip.html content="To easily identify the project as
an xPack, it is recommended to suffix the project name with `-xpack`." %}

With a browser, at GitHub, select your account or one of your 
  organisations (like 
  [µOS++](https://github.com/micro-os-plus), 
  [GNU MCU Eclipse](https://github.com/gnu-mcu-eclipse) or 
  [xPacks](https://github.com/xpacks))

- click the green **New** button to create a new repository
  - enter **Repository name**; use all lowercase and hyphens to 
    separate words (not underscores!); preferably suffix the name with `-xpack`
  - enter **Description** (like _An xPack with ..._)
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
  ```console
$ mkdir -p xpacks
$ cd xpacks
$ git clone https://github.com/<user>/<project>.git <project>.git
```

### Edit the .gitignore file

With Visual Studio Code:

- add the following to `.gitignore`:

```
# xpm
xpacks/

# Windows
Thumbs.db

# macOS
.DS_Store

# end
```

- for Eclipse C/C++ projects you can include:

```
# Eclipse
.settings/
Debug/
Release/
test-*/
build/
```

With Sourcetree or Git:

- stage the `.gitignore` file
- commit with the following message: **.gitignore: add npm & Eclipse specifics**
- click the **Commit** button

### Check/edit the LICENSE file

The automatically generated `LICENSE` file already includes the 
user name as the copyright owner. When the project is owned by 
an organisation, the name refers to the organisation. Probably 
this is not exactly what you need, and you might prefer to have 
your name in the copyright notice.

Check and possibly adjust to match your LICENSE requirements.

```
MIT License

Copyright (c) 2018 Liviu Ionescu

Permission is hereby granted, free of charge, to any person obtaining a copy
...
```

With Sourcetree or Git:

- stage the `LICENSE` file
- commit with the following message:  **LICENSE: update copyright owner**
- click the **Commit** button

### Edit the master README.md file

Although for original xPacks there are no constraints on how to 
organise the branches, for consistency with xPacks that use 3rd 
party content, it is recommended to also use an `xpack` branch 
for the entire content.

In this case, to warn users about this configuration, edit 
the `README.md` file and replace its entire content with:

```
This project does not use the `master` branch, please
switch to the `xpack` branch to get the project files.
```

With Sourcetree or Git:

- stage the `README.md` file
- commit with the following message: **README: 'no master' notice**
- click the **Commit** button

### Create the `xpack` branch 

With Sourcetree or Git:

- select the `master` branch
- click the **Branch** button 
- in the **Name Branch** field, enter `xpack`
- click the **Create Branch** button

### Publish both branches

With Sourcetree or Git:

- click the **Push** button
- select the `master` and `xpack` local branches
- click the **OK** button

With the GitHub web interface:

(as shortcut, in Sourcetree, click the **View Remote** button)

- select the **Settings** tab
- select the **Branches** grouping
- change the **Default branch** to `xpack`
- click the **Update** button
- click the **I understand, update the default branch** confirmation window
 

### Create the npm/xpm package.json

Use `xpm init` and later edit the `package.json`. 

```console
$ cd <project>.git
$ xpm init
$ cat package.json 
{
  "name": "xxx",
  "version": "1.0.0",
  "description": "An xPack with <your-description-here>",
  "main": "",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/<user-id>/xxx.git"
  },
  "bugs": {
    "url": "https://github.com/<user-id>/xxx/issues"
  },
  "homepage": "https://github.com/<user-id>/xxx",
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
  (like `@micro-os-plus/diag-trace`)
- as **version**, enter 0.0.1 if the project is in early development, 
  or accept 1.0.0 for the first stable release; generally use the 
  [semver](http://semver.org) conventions
- as **description**, use the same string as the GitHub project description
- as **url** and **homepage**, use the actual project Git URL
- as **author**, enter full data, like
  ```json
{
  "author": {
    "name": "Liviu Ionescu",
    "email": "ilg@livius.net",
    "url": "http://liviusdotnet.wordpress.com"
  }
}
```
- as **license**, enter the [SPDX](https://spdx.org/licenses/) license 
  identifier (like MIT); if the license is not a standard one, provide 
  the text in a `LICENSE` file and update the JSON to read:
  ```json
{ "license" : "SEE LICENSE IN <filename>" }
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

With Sourcetree or Git:

- stage the `package.json`
- commit with the following message: **package.json: v1.0.0** or 
  **package.json: v0.0.1**
- click the **Commit** button

### Edit the README.md file with actual content

With the editor of your choice:

- **do not start with H1**, since it is not shown by the npmjs server; H2 is ok,
  or start with a badge and then H2
- after the main title, copy the project description
- explain how to install the xPack 
  (like `xpm install --global @scope/name`)
- in the License section, use something like 
  ```
The original content is released under the 
[MIT License](https://opensource.org/licenses/MIT), with all rights 
reserved to [Liviu Ionescu](https://github.com/ilg-ul).
```

With Sourcetree or Git:

- stage the `README.md` file
- commit with the following message: **README: preliminary content**
- click the **Commit** button

### Publish the initial version to GitHub

With Sourcetree or Git:

- click the **Push** button (to push the `xpack` branch to the server)

### Add more content

- add project files

### Commit the initial content

With Sourcetree or Git:

- stage the new files
- commit with the following message: **add initial content**
- click the **Commit** button

### Publish the branch

- with Sourcetree or Git, click **Push** and select `xpack`

### Publish the initial version to the npmjs public registry

```console
$ cd <project>.git
$ npm publish --access public
```

### Bump version

In general, depending on the 'disruption' degree, chose one of the following:

```console
$ cd <project>.git
$ npm version patch
$ npm version minor
$ npm version major
```

With Sourcetree or Git:

- click **Push**, to push the commits
