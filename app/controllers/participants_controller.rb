class ParticipantsController < ApplicationController
  before_action :authenticate_user!

  def create
    Participant.create(
      race_id: params[:race_id],
      user_id: current_user.id
    )
    redirect_to race_path(params[:race_id])
  end

  def result
    participants = Participant.where(race_id: params[:race])
    participant = Participant.where(user_id: current_user.id, race_id: params[:race])
    participant.update(duration: params[:duration], status: 'finished')
    race_status = 0
    participants.each { |part| race_status += 1 if part.status == 'racing' }
    @message = 'Not everyone has finished' unless race_status.zero?

    if race_status.zero?
      @ranks = participants.order(duration: :desc)
      @message = 'Race is over'
    end



    # t.bigint "user_id"
    # t.bigint "race_id"
    # t.integer "duration"
    # t.integer "points"
    # t.string "status"
    # binding.pry
  end
end
