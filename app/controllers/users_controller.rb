class UsersController < ApplicationController
  before_action :authenticate_user!, :set_user

  def show
    @kit = Kit.where(user_id: current_user.id)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
