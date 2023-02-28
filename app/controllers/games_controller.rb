class GamesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to games_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def game_params
    params.require(:game).permit(:name, :players, :minimum_age, :description, :city, :price_per_day)
  end
end
