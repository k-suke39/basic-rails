class PasswordResetsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!

    redirect_to login_path, success: t('password_resets.create.successful')
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?

    # パスワード確認の検証を機能
    @user.password_confirmation = params[:user][:password_confirmation]
    # 次の行は一時トークンをクリアし、パスワードを更新します
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: t('password_resets.edit.successful')
    else
      flash.now[:danger] = t('password_resets.edit.successful')
      render :edit
    end
  end
end
