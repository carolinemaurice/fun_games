class RenameCityToAdress < ActiveRecord::Migration[7.0]
  def change
    rename_column(:games, :city, :address)
  end
end
