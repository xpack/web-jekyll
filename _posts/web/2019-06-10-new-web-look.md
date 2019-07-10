---
title:  "The xPack project web has a new look!"

date: 2019-06-10 12:00:00 +0300
last_updated: 2019-06-30 10:30:22 +0300

categories: 
  - jekyll 
  - update

tags:
  - news
  - web

---

After several re-branding iterations, the xPack project, available from 
[GitHub](https://github.com/xpack), has a new web site.

## GitHub Pages

The site continues to use [GitHub Pages](https://pages.github.com), 
which is the GitHub solution for providing documentation sites to hosted 
projects

## Jekyll & markdown

GitHub Pages use [Jekyll](http://jekyllrb.com) to generate static web 
sites, and the most convenient input format for Jekyll is 
[markdown](http://daringfireball.net/projects/markdown/syntax).

The new site uses the standard GitHub setup, which automatically runs
the Jekyll generator; thus an external build step is no longer needed.

## Content migration

The initial location of the new site was the `xpack/preview.git` project.

Content from the old site was migrated to the new site, with updates.

Switching fom the external builder to GitHub required some changes:

- there is no automatic detection of last modified date, so 
  the `last_updated:` was added to posts
- the `kramdown` markdown parser does not have the `autolink` option, so
  links must be explicit


