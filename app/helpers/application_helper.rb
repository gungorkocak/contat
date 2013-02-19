module ApplicationHelper
  def title(title = "ContAT")
    content_for(:title, title)
  end
end
