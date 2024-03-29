[![Jekyll site CI](https://github.com/xpack/web-jekyll/workflows/Jekyll%20site%20CI/badge.svg)](https://github.com/xpack/web-jekyll/actions?query=workflow%3A%22Jekyll+site+CI%22)

# The xPack web site - Jekyll sources

## Overview

This GitHub project, available from
[xpack/web-jekyll](https://github.com/xpack/web-jekyll), contains
the source files used to generate the
**[xPack web site](https://xpack.github.io)**.

## Public URLs

The **xPack web site** is an organisation specific
[GitHub Pages](https://pages.github.com) site, publicly available from:

- https://xpack.github.io
- https://xpack.github.io/web-preview/ (for preview of
new pages only, do not bookmark it)

## Jekyll

The web site is generated off-line by [Jekyll](jekyllrb.com).
It cannot be generated by [GitHub Pages](https://pages.github.com)
because it uses Jekyll plug-ins, considered unsafe and disabled by
the GitHub Pages instance of Jekyll.

## Folder structure

### Posts

All blog posts are in the `_posts` folder.

### Pages

All web pages are in the `pages` folder.

## `last_updated:`

To maintain `sitemap.xml` usefulness, while maintaining pages and posts, it
is necessary to provide an accurate timestamp.

This timestamp can be automatically updated by the `gjtorikian/jekyll-last-modified-at` plug-in.

## Timezone

As per `_config.yml`, the default timezone is UTC. For other timezones,
set it explicitly as offset (for example +0300)

## Images

The embedded images are located in the `/assets/images` folder.

For a certain degree of portability, the recommended editable format is
PPTX. On macOS, PPTX files can be processed with Keynote, although
saving can be done only indirectly via **Export To**, not directly via **Save**.

The preferred format is PNG. The available width is lower than 700 px,
but apparently Jekyll scales images properly. By default Keynote exports
images as 1024 x 768, which is generally ok for regular (non-HiRes) screens.

## Contributing

Contributions are welcomed!

Please review the [Contributing Guidelines](CONTRIBUTING.md) for details.
