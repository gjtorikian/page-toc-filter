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
    toc = ''
    levels = context[:toc_levels] || 'h2'

    doc.search(levels).each do |node|
      text = node.text
      id = node.child['id']
      toc << %(<li><a href="##{id}" id="markdown-toc-#{id}">#{text}</a></li>\n)
    end
    toc = %(<ul id="markdown-toc">\n#{toc}</ul>) unless toc.empty?
    toc
  end
end
