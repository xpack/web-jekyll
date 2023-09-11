---
permalink: /ci/
title: CI/CD

summary: Using xPacks in Continuous Integration environments

comments: true

date: 2023-09-11 13:38:00 +0300

---

## Continuous Integration use cases

By design, the main use case intended for xPacks was to run
multi-platform unit tests for the µOS++ project.

The general way to run such tests follows the npm ecosystem way,
which uses an `install` to satisfy dependencies and a `run test`
action which invokes the actual script to perform the test.

### GitHub Actions with xPack project

The recommended way to use xPack dependencies is to add a `package.json`
to the project, add the dependencies there and save them to the repository.

With the proper scripts configured, a simple test
configuration for an xPack project may look like this:

```yml
name: CI on Push

on:
  push:

jobs:
  ci-test:
    name: 'CI tests'

    runs-on: {% raw %}${{ matrix.os }}{% endraw %}

    strategy:
      matrix:
        # https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners
        os: [ ubuntu-22.04, macos-12 ]
        node-version: [ 18 ]

    steps:
    - name: Checkout
      uses: actions/checkout@v2
      with:
        fetch-depth: 3

    - name: Setup Node.js {% raw %}${{ matrix.node-version }} on ${{ matrix.os }}{% endraw %}
      uses: actions/setup-node@v2
      with:
        node-version: {% raw %}${{ matrix.node-version }}{% endraw %}

    - name: Install xpm
      run: npm install --global xpm@latest

    - name: Satisfy project dependencies
      run: xpm install

    - name: Run test
      run: xpm run test
```

### GitHub Actions with non-xPack project

If, for any reason, it is not possible to add the `package.json` to the
project, it is possible to reconstruct it during the CI session.

```yml
name: Manual

on:
  workflow_dispatch:
    inputs:
      xpm_version:
        description: 'The version of xpm to install'
        required: false
        type: string
        default: 'latest'

jobs:
  manual-test:

    runs-on: {% raw %}${{ matrix.os }}{% endraw %}

    strategy:
      matrix:
        # https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners
        os: [ ubuntu-22.04, macos-12 ]
        node-version: [ 18 ]

    steps:
    - name: Checkout
      uses: actions/checkout@v2
      with:
        fetch-depth: 3

    - name: {% raw %}Setup Node.js ${{ matrix.node-version }} on ${{ matrix.os }}{% endraw %}
      uses: actions/setup-node@v3
      with:
        node-version: {% raw %}${{ matrix.node-version }}{% endraw %}

    - name: Install xpm
      run: {% raw %}npm install --global xpm@${{ github.event.inputs.xpm_version }}{% endraw %}

    - name: Pretend no xPack project
      run: rm -f package*.json

    - name: Make project an xPack
      run: xpm init

    - name: Add dependencies
      run: xpm install @xpack-dev-tools/clang@16.0.6-1.1 @xpack-dev-tools/cmake@3.26.5-1.1 @xpack-dev-tools/ninja-build@1.11.1-3.1

    - name: Adjust PATH
      run: echo "$(pwd)/xpacks/.bin" >> $GITHUB_PATH

    - name: Build
      run: |
        cmake -S . -B build -G Ninja -D CMAKE_TOOLCHAIN_FILE=cmake/clang.cmake
        cmake --build build --verbose

    - name: Run test
      run: cd build && ctest -V
```

{% include note.html content="Please note that the `PATH` was explicitly
adjusted to the `xpacks/.bin` folder, where **xpm** installs links to
the binaries." %}
