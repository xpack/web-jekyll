---
permalink: /ci/
title: CI/CD

summary: Continuous Integration

comments: true

date: 2023-09-11 13:38:00 +0300

---

## Continuous Integration use cases

By design, the main use case intended for xPacks was to run
multi-platform unit tests for the µOS++ project.

The general way to run such tests follows the npm ecosystem way,
which uses an `install` to satisfy dependencies and a `run test`
action which invokes the actual script to perform the test.

### GitHub Actions

For example, with the proper scripts configured, a simple test
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
        node-version: [16, 18, 20]
        # https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners
        os: [ubuntu-22.04, macos-12, windows-2022]

    steps:
    - name: Checkout
      uses: actions/checkout@v2
      with:
        fetch-depth: 3

    - name: Setup Node.js {% raw %}${{ matrix.node-version }} on ${{ matrix.os }}{% endraw %}
      # https://github.com/actions/setup-node
      uses: actions/setup-node@v2
      with:
        node-version: {% raw %}${{ matrix.node-version }}{% endraw %}

    - name: Install xpm on Linux/macOS
      if: runner.os != 'Windows'
      run: sudo npm install --global xpm@latest

    - name: Install xpm on Windows
      if: runner.os == 'Windows'
      run: npm install --global xpm@latest

    - name: Satisfy project dependencies
      run: xpm install --quiet

    - name: Run test
      run: xpm run test
```
