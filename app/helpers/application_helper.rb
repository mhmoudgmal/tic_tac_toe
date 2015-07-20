module ApplicationHelper
  def current_user
    session[:player]
  end
end
