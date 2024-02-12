class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def destroy
    @user = current_user
    if @user.delete
      redirect_to new_user_registration_path
    end
  end
end
