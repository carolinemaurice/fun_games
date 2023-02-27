class Booking < ApplicationRecord
  STATUS = ["Pending", "Declined", "Accepted"]

  belongs_to :user
  belongs_to :game

  validates :status, inclusion: { in: STATUS }
  validates :start_date, :end_date, presence: true
  validates :start_date, comparison: { greater_than: :end_date }
end
