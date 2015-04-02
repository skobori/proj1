class PokemonController < ApplicationController

  def new
    @pokemon = Pokemon.new
    @pokemon.level = 1
    @pokemon.hp = 100
    @pokemon.trainer_id = current_trainer.id
  end

  def capture
    pokemon = Pokemon.find_by(id: params[:id])
    pokemon.update_attribute(:trainer_id, current_trainer.id)
    redirect_to "home#index"
  end

  def damage
    pokemon = Pokemon.find_by(id: params[:id])
    pokemon.update_attribute(:hp, pokemon.hp - 10)
    if pokemon.hp <= 0
      pokemon.destroy
    end
    redirect_to trainer_path(current_trainer)
  end

end
