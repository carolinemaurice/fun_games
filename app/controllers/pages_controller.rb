class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  skip_after_action :verify_authorized, only: [:dashboard]
  def home
  end

  def dashboard
    @games = current_user.games
    @bookings = current_user.bookings
    @pendings_bookings_as_owner = current_user.bookings_as_owner.pendings
    @accepteds_bookings_as_owner = current_user.bookings_as_owner.accepteds
    @declineds_bookings_as_owner = current_user.bookings_as_owner.declineds
  end
end
