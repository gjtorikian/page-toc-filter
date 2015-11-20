# PageTocFilter

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'page-toc-filter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install page-toc-filter

## Usage

The simplest way to do this is

``` ruby
require 'extended-markdown-filter'
```

Then, place this filter *after* you've rendered your content through the Markdown and TOC filters:

``` ruby
pipeline = HTML::Pipeline.new([
  HTML::Pipeline::MarkdownFilter,
  HTML::Pipeline::TableOfContentsFilter,
  HTML::Pipeline::PageTocFilter
])
```

By default, only `h2` headings will be converted into a table of contents. You can change this with the optional `toc_levels` setting, which should be a comma-separated string of heading levels. For example:

``` ruby
pipeline = HTML::Pipeline.new([
  HTML::Pipeline::MarkdownFilter,
  HTML::Pipeline::TableOfContentsFilter,
  HTML::Pipeline::PageTocFilter
], { :toc_levels => 'h2, h3' })
```
