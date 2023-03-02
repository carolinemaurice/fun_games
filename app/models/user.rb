class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings
  has_many :games
  has_one_attached :photo

  validates :first_name, :last_name, :username, :city, :street_number, :postal_code, :email, presence: true
  validates :email, format: {with: /\A.+@[a-z]+\.[a-z]{2,3}\z/ }
end
