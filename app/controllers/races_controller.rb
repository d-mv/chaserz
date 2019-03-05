require 'open-uri'

class RacesController < ApplicationController
  before_action :authenticate_user!
  def index
    @races = Race.all.order(start_date: :asc)
  end

  def show
    params[:start].nil? ? @start = 0 : @start = params[:start].to_i
    @race = Race.find(params[:id])
    qty = @race.participants.size
    if qty < 5
      @participants = @race.participants
    else
      over = @start + 4 > qty - 1
      if over
        @participants = @race.participants[-5..-1]
        @start = qty - 5
      else
        @participants = @race.participants[@start..@start + 4]
      end
    end
    @locations = locations(@race.id)
    @applied = true unless Participant.where(user_id: current_user.id, race_id: @race.id).length.zero?
    puts @applied

  end

  def map
    @race = Race.find(params[:race])
    race_checkpoints = @race.checkpoints.order(position: :asc)
    @race_checkpoints = []
    location = params[:location].split(',').map(&:to_f)
    @race_checkpoints << location
    race_checkpoints.each { |el| @race_checkpoints << [el.longitude, el.latitude] }
    location_history = Location.where(user_id: current_user.id, race_id: params[:race])
    location_history.delete_all
  end

  def new
    @race = Race.new
    @race.checkpoints.build
  end

  def create
    @race = Race.new(race_params)
    @race.user = current_user
    if @race.save
      Participant.create(race_id: @race.id, user_id: @race.user_id)
      redirect_to races_path
    else
      render :new
    end
  end

  def participant
    @participant = Participant.new(race_id: params[:id])
    @participant.user_id = current_user.id
    if @participant.save
      redirect_to race_path(@race)
    else
      redirect_to :menu ##
    end
  end

  private

  def race_params
    params.require(:race).permit(:title, :category, :start_date, checkpoints_attributes: %i[id position location _destroy])
  end


  def locations(race_id)
    locations = []
    Checkpoint.where(race_id: race_id).each do |checkpoint|
      locations << checkpoint.location
    end
    locations

  end
end
