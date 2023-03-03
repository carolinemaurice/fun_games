class Booking < ApplicationRecord
  STATUS = ["Pending", "Declined", "Accepted"]

  belongs_to :user
  belongs_to :game

  validates :status, inclusion: { in: STATUS }
  validates :start_date, :end_date, presence: true
  validates :end_date, comparison: { greater_than: :start_date }

  scope :pendings, ->{ where(status: "Pending") }
  scope :declineds, ->{ where(status: "Declined") }
  scope :accepteds, ->{ where(status: "Accepted") }

  def accept_reservation
    @status = "Accepted"
  end

  def decline_reservation
    @status = "Declined"
  end
end
