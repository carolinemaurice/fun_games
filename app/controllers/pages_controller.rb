class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  skip_after_action :verify_authorized, only: [:dashboard]
  def home
  end

  def dashboard
    @games = current_user.games
    @bookings = current_user.bookings
  end
end
