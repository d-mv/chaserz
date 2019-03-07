class Checkpoint < ApplicationRecord
  belongs_to :race
  acts_as_list scope: :race

  # geocoded_by :location
  # after_validation :geocode, if: :will_save_change_to_location?
end
