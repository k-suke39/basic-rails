class ProfilesController < ApplicationController
  def edit
    @user = User.find_by(id: current_user.id)
  end

  def update
    @user = User.find_by(id: current_user.id)
    if @user.update(profile_params)
      redirect_to profile_path, success: t('users.edit.successful')
    else
      flash.now[:danger] = t('users.edit.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:last_name, :first_name, :email, :avatar)
  end
end
