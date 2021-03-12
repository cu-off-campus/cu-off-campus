module ApplicationHelper
  def text_abstract(text)
    shortened = text[...text.index(" ", 80)]
    shortened << "..." if shortened.length != text.length
    shortened
  end
end
