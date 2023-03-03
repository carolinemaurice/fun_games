class BookingsController < ApplicationController
  before_action :set_game, only: %i[new create]

  def new
    @booking = Booking.new(game: @game)
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.game = @game
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to game_path(@game), notice: "You have booked the game #{@game.name} on #{@booking.start_date} to #{@booking.end_date}."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.destroy
    redirect_to dashboard_path, status: :see_other
  end

  def accept
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.status = "Accepted"
    @booking.save
    redirect_to dashboard_path
  end

  def decline
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.status = "Declined"
    @booking.save
    redirect_to dashboard_path
  end


  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end

  def set_game
    @game = Game.find(params[:game_id])
  end
end
