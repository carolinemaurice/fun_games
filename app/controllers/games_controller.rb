class GamesController < ApplicationController
  before_action :set_game, only: %i[show edit update destroy]

  def index
    @games = Game.all
  end

  def show
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    user = User.find(1)
    @game.user = user
    if @game.save!
      redirect_to games_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path, status: :see_other
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

  private

  def game_params
    params.require(:game).permit(:name, :players, :minimum_age, :description, :city, :price_per_day, photos: [] )
  end

  def set_game
    @game = Game.find(params[:id])
  end
end
