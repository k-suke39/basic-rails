class ApplicationController < ActionController::Base
  def login?
    if logged_in?
      true
    else
      flash[:danger] = 'ログインしてください'
      redirect_to login_path
    end
  end
end
