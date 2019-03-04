class KitsController < ApplicationController

  before_action :authenticate_user!

  before_action :set_kit, only: [:show, :edit, :update, :destroy]

  def new
    @kit = Kit.new

  end

  def create
    @kit = Kit.new(kit_params)
    @kit.user = current_user

    if @kit.save!
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def show
  end

  def edit


  end

  def update
    if @kit.update(kit_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @kit.destroy
    redirect_to root ##
  end

  private

  def set_kit
    @kit = Kit.find(params[:id])

  end



  def kit_params
    params.require(:kit).permit(:name, :description, :photo)
  end

end
