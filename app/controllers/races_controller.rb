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
    @locations = []
    Checkpoint.where(race_id: @race.id).each do |checkpoint|
      @locations << coordinates_to_text(checkpoint.latitude, checkpoint.longitude)
    end
  end

  def map
    @race = Race.find(params[:race])
    race_checkpoints = @race.checkpoints.order(position: :asc)
    @race_checkpoints = []
    location = params[:location].split(',').map(&:to_f)
    @race_checkpoints << location
    race_checkpoints.each { |el| @race_checkpoints << [el.longitude, el.latitude] }
  end

  def new
    @race = Race.new
    @race.checkpoints.build
  end

  def create
    @race = Race.new(race_params)
    @race.user = current_user
    if @race.save
      redirect_to races_path
    else
      render :new
    end
  end

  private

  def race_params
    params.require(:race).permit(:title, :category, :start_date, checkpoints_attributes: [:id, :position, :location, :_destroy])
  end

  def coordinates_to_text(lat, lon)
    # request = "#{lon},#{lat}"
    # url1 = 'https://api.mapbox.com/geocoding/v5/mapbox.places/'
    # url2 = '.json?access_token=pk.eyJ1IjoiZC1tdiIsImEiOiJjanJzenJ0aGkwanh4NDNtaXd2MXl6anVlIn0.2VkrtPiDn08qMZXGhSZfAg'
    # url = "#{url1}#{request}#{url2}"
    # response = JSON.parse(open(url).read)
    # response['features'][0]['text']
    return ''
  end
end
