class AddHpToPokemon < ActiveRecord::Migration
  def change
    add_column :pokemons, :hp, :integer
  end
end
