require 'test_helper'

class HTML::Pipeline::PageTocFilterTest < Minitest::Test
  def fixture(name)
    File.open(File.join("#{File.expand_path(File.dirname(__FILE__))}", 'fixtures', name)).read
  end

  def test_plain_page_toc
    output = pipeline(fixture('plain_toc.txt'))
    assert_equal fixture('plain_toc.html').chomp, output.chomp
  end

  def test_toc_levels
    output = pipeline(fixture('toc_levels.txt'), toc_levels: 'h2, h3')
    assert_equal fixture('toc_levels.html').chomp, output.chomp
  end

  def test_misaligned_toc
    assert_raises ArgumentError do
      pipeline(fixture('misaligned_toc.txt'), toc_levels: 'h1, h2, h3, h4')
    end
  end

  def test_all_variants_work
    toc = '{:toc}'
    levels = {
      h1: '# Level 1',
      h2: '## Level 2',
      h3: '### Level 3',
      h4: '#### Level 4',
      h5: '##### Level 5',
      h6: '###### Level 6'
    }
    levels.each do |level, string|
      text = []
      text << toc
      level_number = level.to_s[1].to_i
      i = level_number
      loop do
        text << levels["h#{i}".to_sym]
        i += 1
        break if i == 7
      end
      output = pipeline(text.join("\n\n"), toc_levels: 'h1, h2, h3, h4, h5, h6')
      output = "<html>" + output + "</html>"
    end
  end
end
