class Admin::BaseController < ApplicationController
  before_action :check_admin

  before_action :check_admin
  layout 'admin/layouts/application'

  private

  def not_authenticated
    flash[:danger] = t('ログイン失敗')
    redirect_to admin_login_path
  end

  def check_admin
    redirect_to root_path, danger: t('権限がありません') unless current_user.admin?
  end
end
