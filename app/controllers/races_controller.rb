class RacesController < ApplicationController
  before_action :authenticate_user!
  def index
    @races = Race.all.order(start_date: :asc)
  end

  def show
    @race = Race.find(params[:id])
  end

end
