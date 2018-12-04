class Track < ApplicationRecord
  belongs_to :url
  belongs_to :user
end
