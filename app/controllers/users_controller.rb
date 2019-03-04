class UsersController < ApplicationController
  before_action :authenticate_user!, :set_user

  def show
    @kit = Kit.where(user_id: current_user.id)
  end

  def set_user
    @user = User.find(params[:id]) if params[:id].to_i.class == Integer
  end
end
