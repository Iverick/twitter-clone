module ApplicationHelper
  def nav_link_active?(link_name)
    "active" if controller_name == link_name
  end
end
