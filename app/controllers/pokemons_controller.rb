class PokemonsController < ApplicationController

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.create(pokemon_params)
    @pokemon.level = 1
    @pokemon.hp = 100
    @pokemon.trainer_id = current_trainer.id
    if @pokemon.save
      redirect_to trainer_path(current_trainer)
    else
      flash[:error] = @pokemon.errors.full_messages.to_sentence
      render "new"
    end
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

  def pokemon_params
    params.require(:pokemon).permit(:name)
  end

end
