module ApplicationHelper
  def sidebar_active(controller)
    'c-active' if controller_name == controller
  end
end
