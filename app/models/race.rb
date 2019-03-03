class Race < ApplicationRecord
  belongs_to :user

  scope :involving, -> (participant) {

    joins(:participants).where('participants.race_id=race_id AND participants.user_id=?',  participant.id)
    # where("races.sender_id = ? OR chats.recipient_id = ?", participant.user_id, user.id)
  }

  has_many :participants, dependent: :delete_all
  has_many :locations, dependent: :delete_all
  has_many :checkpoints, dependent: :delete_all
  has_many :users, through: :participants
end
