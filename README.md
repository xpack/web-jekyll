# The xPack web site

## Overview

This GitHub project, available from 
[xpack/xpack.github.io](https://github.com/xpack/xpack.github.io), contains 
the source files used to generate the 
**[xPack web site](http://xpack.github.io)**.

## Destination URL

The **xPack web site** is an organisation 
[GitHub Pages](https://pages.github.com) site, stored in the 
[xpack/xpack.github.io](https://github.com/xpack/xpack.github.io) Git and 
publicly available from [http://xpack.github.io](http://xpack.github.io).

## Jekyll

The web site uses Jekyll and is generated online by 
[GitHub Pages](https://pages.github.com).

For security reasons, GitHub Pages allows only a curated [list of plugins](https://pages.github.com/versions/).

## Prerequisites

To be able to run the Jekyll build process, the `ruby` interpreter 
and the `gem` tool are required. In OS X 10.10.5, these tools are 
pre-installed, at least when the Developer Command Line tools are present.

### Install separate Homebrew

If you are like me and like really separated things, install a separate 
Homebrew instance only for the jekyll builds.

```console
$ mkdir -p "${HOME}/opt"
$ git clone https://github.com/ilg-ul/opt-install-scripts \
    "${HOME}/opt/install-scripts.git"
$ caffeinate bash 
$ exec bash "${HOME}/opt/install-scripts.git/install-homebrew-jekyll.sh"
```

Add a new alias to your `.profile`:

```console
alias ajkl='export PATH=/Users/ilg/opt/homebrew/jekyll/bin:${PATH}'
```

Then, in a new terminal:

```console
$ ajkl
$ which ruby
/Users/ilg/opt/homebrew/jekyll/bin/ruby
$ ruby --version
ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-darwin17]
$ gem --version
3.0.3
$ bundler --version
Bundler version 2.0.1
```

## Clone Git

To manage the web site, a local copy of this repository is required.

```console
$ git clone https://github.com/xpack/xpack.github.io.git xpack.github.io.git
```

## Install jekyll & gems

Install jekyll and all gems referred in `Gemfile`. Probably usually there 
is no need to run bundler as root, it can ask for sudo if needed, but in 
my setup it looks necessary.

```console
$ cd xpack.github.io.git
$ bundle install
$ bundle exec jekyll --version
jekyll 3.8.5
```

## Development

The current development cycle is edit-save-build-view.

The build can be performed automatically by Jekyll when started in server mode.

```console
$ cd xpack.github.io.git
$ bundle exec jekyll serve --trace --safe --baseurl "/preview"
```

To view the result, point the browser to `http://localhost:4002/preview/`.

To test links:

```console
$ bundle exec jekyll build
$ bundle exec htmlproofer --allow-hash-href --url-swap \^/preview/\:/ ./_site
$ bundle exec htmlproofer --allow-hash-href --url-swap \^/preview/\:/ --url-ignore /github.com/xpack/xpack.github.io/blob/master/ ./_site
```


## Publish

To publish, commit this Git and the new site will be automatically updated.

## Updates

When new versions of Jekyll, or of gems, are available, run `bundle update` 
and be sure the `Gemfile.lock` file is committed:

```console
$ cd xpack.github.io.git
$ bundle update
Fetching gem metadata from https://rubygems.org/............
Fetching gem metadata from https://rubygems.org/..
Resolving dependencies....
Using concurrent-ruby 1.1.5
Using i18n 0.9.5
Using minitest 5.11.3
Using thread_safe 0.3.6
Using tzinfo 1.2.5
Using activesupport 4.2.11.1
Using public_suffix 3.1.0
Using addressable 2.6.0
Using bundler 2.0.1
Using coffee-script-source 1.11.1
Using execjs 2.7.0
Using coffee-script 2.4.1
Using colorator 1.1.0
Using ruby-enum 0.7.2
Using commonmarker 0.17.13
Using dnsruby 1.61.2
Using eventmachine 1.2.7
Using http_parser.rb 0.6.0
Using em-websocket 0.5.1
Using ffi 1.11.1
Using ethon 0.12.0
Using multipart-post 2.1.1
Using faraday 0.15.4
Using forwardable-extended 2.6.0
Using gemoji 3.0.1
Using sawyer 0.8.2
Using octokit 4.14.0
Using typhoeus 1.3.1
Using github-pages-health-check 1.16.1
Using rb-fsevent 0.10.3
Using rb-inotify 0.10.0
Using sass-listen 4.0.0
Using sass 3.7.4
Using jekyll-sass-converter 1.5.2
Using ruby_dep 1.5.0
Using listen 3.1.5
Using jekyll-watch 2.2.1
Using kramdown 1.17.0
Using liquid 4.0.0
Using mercenary 0.3.6
Using pathutil 0.16.2
Using rouge 2.2.1
Using safe_yaml 1.0.5
Using jekyll 3.8.5
Using jekyll-avatar 0.6.0
Using jekyll-coffeescript 1.1.1
Using jekyll-commonmark 1.3.1
Using jekyll-commonmark-ghpages 0.1.5
Using jekyll-default-layout 0.1.4
Using jekyll-feed 0.11.0
Using jekyll-gist 1.5.0
Using jekyll-github-metadata 2.12.1
Using mini_portile2 2.4.0
Using nokogiri 1.10.3
Using html-pipeline 2.11.0
Using jekyll-mentions 1.4.1
Using jekyll-optional-front-matter 0.3.0
Using jekyll-paginate 1.1.0
Using jekyll-readme-index 0.2.0
Using jekyll-redirect-from 0.14.0
Using jekyll-relative-links 0.6.0
Using rubyzip 1.2.3
Using jekyll-remote-theme 0.3.1
Using jekyll-seo-tag 2.5.0
Using jekyll-sitemap 1.2.0
Using jekyll-swiss 0.4.0
Using jekyll-theme-architect 0.1.1
Using jekyll-theme-cayman 0.1.1
Using jekyll-theme-dinky 0.1.1
Using jekyll-theme-hacker 0.1.1
Using jekyll-theme-leap-day 0.1.1
Using jekyll-theme-merlot 0.1.1
Using jekyll-theme-midnight 0.1.1
Using jekyll-theme-minimal 0.1.1
Using jekyll-theme-modernist 0.1.1
Using jekyll-theme-primer 0.5.3
Using jekyll-theme-slate 0.1.1
Using jekyll-theme-tactile 0.1.1
Using jekyll-theme-time-machine 0.1.1
Using jekyll-titles-from-headings 0.5.1
Using jemoji 0.10.2
Using minima 2.5.0
Using unicode-display_width 1.6.0
Using terminal-table 1.8.0
Using github-pages 198
Bundle updated!
```

People using forked repositories must run `bundle install` to be sure the 
required versions are properly installed. 

## Folder structure

### Posts

All blog posts are in the `_posts` folder.

### Pages

All web pages are in the `pages` folder.

## `last_updated:`

To maintain `sitemap.xml` usefulness, while maintaining pages and posts, it 
is necessary to provide an accurate timestamp. 

With `gjtorikian/jekyll-last-modified-at` not available, the only way is
to manually update this variable for all pages & posts.

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

## Links

- [preview](https://xpack.github.io/preview/)
- [Liquid](https://shopify.github.io/liquid/)
- [Jekyll Doc Theme 6.0](https://idratherbewriting.com/documentation-theme-jekyll/)
- [kramdown](https://kramdown.gettalong.org)
- [Markdown Kramdown Tips & Tricks](https://about.gitlab.com/2016/07/19/markdown-kramdown-tips-and-tricks/)
- [GitHub Pages](https://pages.github.com).
- [list of plugins](https://pages.github.com/versions/)

