class Race < ApplicationRecord
  belongs_to :user

  has_many :participants, :locations, :checkpoints
  has_many :users, through: :participants
end
