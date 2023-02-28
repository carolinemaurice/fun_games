class Game < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :name, :city, presence: true
  validates :price_per_day, comparison: { greater_than_or_equal_to: 0 }
end
