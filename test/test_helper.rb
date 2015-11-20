require 'bundler/setup'
require_relative '../lib/page-toc-filter'
require 'minitest/autorun'
require 'minitest/pride'

def pipeline(content, context)
  pipeline = HTML::Pipeline.new([
    HTML::Pipeline::MarkdownFilter,
    HTML::Pipeline::TableOfContentsFilter,
    HTML::Pipeline::PageTocFilter
  ], context)
  result = pipeline.call(content)
  result[:output].to_s
end
