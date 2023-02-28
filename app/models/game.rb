class Game < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many_attached :photos

  validates :name, :city, :price_per_day, presence: true
  validates :price_per_day, comparison: { greater_than_or_equal_to: 0 }
  validates :photos, attached: true
end
