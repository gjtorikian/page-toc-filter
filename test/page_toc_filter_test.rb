require 'test_helper'

class HTML::Pipeline::PageTocFilterTest < Minitest::Test
  def fixture(name)
    File.open(File.join("#{File.expand_path(File.dirname(__FILE__))}", 'fixtures', name)).read
  end

  def test_plain_page_toc
    output = pipeline(fixture('plain_toc.txt'), {})
    assert_equal fixture('plain_toc.html').chomp, output.chomp
  end

  def test_toc_levels
    output = pipeline(fixture('toc_levels.txt'), { :toc_levels => 'h2, h3' })
    assert_equal fixture('toc_levels.html').chomp, output.chomp
  end
end
