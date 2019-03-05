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
    return @status = false unless race_status.zero?

    participants.map { |part| part.points = 0 }
    @ranks = points(participants.order(duration: :asc), params[:race])
    @status = true
    @ranks.each do |part|
      points = part.user.points + part.points
      part.user.update(points: points)
    end
  end

  private

  def points(participants, race)
    owner = Race.find(race).user_id
    participants.map.with_index do |participant, index|
      if owner == participant.user_id
        if [1, 2, 3].include?(index)
          participant.points = 6
        elsif participant.status == 'finished'
          participant.points = 4
        end
      end
      if participant.status == 'finished'
        participant.points = 10 if index.zero?
        participant.points = 8 if index == 1
        participant.points = 6 if index == 2
        participant.points = 2 unless [0, 1, 2].include?(index)
      else
        participant.points = 1
      end
    end
    participants
  end
end
