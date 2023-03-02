class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_game, only: %i[show edit update destroy]

  def index
    if params[:query].present? || params[:address].present?
      @games = policy_scope(Game).search_by_name_and_address("#{params[:query]} #{params[:address]}")
    else
      @games = policy_scope(Game)
    end
  end

  def show
    @markers = [{
      lat: @game.latitude,
      lng: @game.longitude
    }]
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
