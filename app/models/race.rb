class Race < ApplicationRecord
  belongs_to :user

  has_many :participants, dependent: :delete_all
  has_many :locations, dependent: :delete_all
  has_many :checkpoints, dependent: :delete_all
  has_many :users, through: :participants

  accepts_nested_attributes_for :checkpoints, reject_if: :all_blank, allow_destroy: true
end
