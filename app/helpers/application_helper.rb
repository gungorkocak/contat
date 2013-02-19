module ApplicationHelper
  def title(title = "ContAT")
    content_for(:title, title)
  end

  def print_errors_for(resource, attr)
    return unless (content = resource.errors[attr.to_sym]).present?
    
    raw content_tag(:span, content.first, class: "error")
  end
end
