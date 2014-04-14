module ApplicationHelper
  def icon_link_to(text, path, icon)
    link_to "#{content_tag :i, nil, class: "fa #{icon}"} #{text}".html_safe, path
  end
end
