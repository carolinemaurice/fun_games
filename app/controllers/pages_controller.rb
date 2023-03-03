class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  skip_after_action :verify_authorized, only: [:dashboard]
  def home
    @games = Game.all.geocoded.last(5)
    @markers = @games.map do |game|
      {
        lat: game.latitude,
        lng: game.longitude,
        info_window_html: render_to_string(partial: "games/info_window", locals: {game: game})
      }
    end
  end

  def dashboard
    @games = current_user.games
    @bookings = current_user.bookings
    @pendings_bookings_as_owner = current_user.bookings_as_owner.pendings
    @accepteds_bookings_as_owner = current_user.bookings_as_owner.accepteds
    @declineds_bookings_as_owner = current_user.bookings_as_owner.declineds
  end
end
