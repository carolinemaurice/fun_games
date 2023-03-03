class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_game, only: %i[show edit update destroy]

  def index
    if params[:query].present? || params[:address].present?
      @games = policy_scope(Game).search_by_name_and_address("#{params[:query]} #{params[:address]}")
    else
      @games = policy_scope(Game)
    end
    @markers = @games.map do |game|
      {
        lat: game.latitude,
        lng: game.longitude,
        info_window_html: render_to_string(partial: "games/info_window", locals: {game: game})
      }
    end
  end

  def show
    @booking = Booking.new
    @markers = [{
      lat: @game.latitude,
      lng: @game.longitude
    }]
    @upcoming_bookings = @game.bookings.upcomings
    @declined_bookings = @game.bookings.declineds
    @history_bookings = @game.bookings.historic
  end

  def new
    @game = Game.new
    authorize @game
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user
    authorize @game
    if @game.save
      redirect_to games_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @game.update(game_params)
      redirect_to game_path(@game)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path, status: :see_other
  end

  private

  def game_params
    params.require(:game).permit(:name, :players, :minimum_age, :description, :address, :price_per_day, photos: [] )
  end

  def set_game
    @game = Game.find(params[:id])
    authorize @game
  end
end
