require 'html/pipeline'

class PageTocFilter < HTML::Pipeline::Filter

  def call
    doc.search('p').each do |node|
      content = node.to_html
      next unless content == '<p>{:toc}</p>'
      html = page_toc_filter(doc)
      node.replace(html)
    end

    doc
  end

  def page_toc_filter(doc)
    levels = doc.search(context[:toc_levels] || 'h2')
    return '' if levels.empty?

    toc = %(<ul id="markdown-toc">\n)
    last_level = nil
    depth = 1

    levels.each do |node|
      current_level = node.name.match(/h(\d)/)[1]

      text = node.text
      id = node.child['id']

      link = %(<a href="##{id}" id="markdown-toc-#{id}">#{text}</a>)

      if last_level.nil?
        toc << %(<li>#{link})
      elsif current_level == last_level
        toc << %(</li>\n<li>#{link})
      elsif current_level > last_level
        depth += 1
        toc << %(\n<ul><li>#{link})
      elsif current_level < last_level
        depth -= 1
        toc << %(</li></ul>\n<li>#{link})
      end

      last_level = current_level
    end

    if depth < 0
      raise ArgumentError, 'Your headings are not in sequential order. It seems that a lower heading level (like an h4) is being defined before a higher heading level (like an h1).'
    end

    toc << %(</li>\n</ul>) * depth
    toc
  end
end
