class ApplicationController < ActionController::Base
  def login?
    if logged_in?
      true
    else
      flash[:danger] = "#{t.(user_sessions.new.title)}してください"
      redirect_to login_path
    end
  end
end
