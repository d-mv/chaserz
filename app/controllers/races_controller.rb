class RacesController < ApplicationController
  before_action :authenticate_user!
    def index
      @races = Race.all

  end
end
