class Booking < ApplicationRecord
  STATUS = ["Pending", "Declined", "Accepted"]

  belongs_to :user
  belongs_to :game

  validates :status, inclusion: { in: STATUS }
  validates :start_date, :end_date, presence: true
  validates :end_date, comparison: { greater_than: :start_date }

  scope :pendings, -> { where(status: "Pending") }
  scope :declineds, -> { where(status: "Declined") }
  scope :accepteds, -> { where(status: "Accepted") }
  scope :historic, -> { where(status: "Declined").or(where('end_date < ?', Date.today)) }
  scope :upcomings, -> { where(status: "Accepted").and(where('end_date > ?', Date.today)) }
end
