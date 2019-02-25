class Race < ApplicationRecord
  belongs_to :user

  has_many :participants, dependent: :delete_all
  has_many :locations, dependent: :delete_all
  has_many :checkpoints, dependent: :delete_all
  has_many :users, through: :participants
end
