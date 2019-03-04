class ParticipantsController < ApplicationController
  before_action :authenticate_user!

  def create
    @participant = Participant.new(race_id: params[:race_id])
    @participant.user_id = current_user.id
    if @participant.save!
      redirect_to race_path(params[:race_id])
    else
      redirect_to :race ##
    end
  end
end
