class Admin::UsersController < Admin::BaseController

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.all.order(created_at: :desc).page(params[:page])
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), success: 'ユーザーを更新しました'
    else
      flash.now[:danger] = 'ユーザーを更新出来ませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to admin_users_path, success: 'ユーザーを削除しました', status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :avatar, :password, :password_confirmation)
  end
end
