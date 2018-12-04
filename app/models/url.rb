class Url < ApplicationRecord
  has_many :tracks
  has_many :users, through: :tracks
  has_many :clicks
end
