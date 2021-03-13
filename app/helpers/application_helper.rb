class String
  def is_i?
    /\A[-+]?\d+\z/ === self
  end
end

module ApplicationHelper
  def text_abstract(text)
    shortened = text[...text.index(" ", 80)]
    shortened << "..." if shortened.length != text.length
    shortened
  end

  def validate_aptmt_params(permitted)
    !(permitted[:name].empty? ||
      permitted[:address].empty? ||
      permitted[:price].empty? ||
      !permitted[:price].is_i? ||
      permitted[:price].to_i <= 0)
  end
end
