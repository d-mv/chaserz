class ParticipantsController < ApplicationController
  before_action :authenticate_user!

  def create
    Participant.create(
      race_id: params[:race_id],
      user_id: current_user.id
    )
    redirect_to race_path(params[:race_id])
  end
end
