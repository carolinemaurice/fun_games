class BookingsController < ApplicationController
  before_action :set_game, only: %i[new create]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.game = @game
    @booking.user = current_user
    if @booking.save!
      redirect_to game_path(@game), notice: "you have booked the game #{@game.name}"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end

  def set_game
    @game = Game.find(params[:game_id])
  end
end
