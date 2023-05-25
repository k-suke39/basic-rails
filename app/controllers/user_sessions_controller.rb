class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      flash[:success] = t('header.login') + 'しました'
      redirect_to root_path
    else
      flash[:danger] = t('header.login') + 'に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:success] = t('header.logout') + 'しました'
    redirect_to root_path, status: :see_other
  end
end
