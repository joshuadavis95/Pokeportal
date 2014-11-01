class PokemonsController < ApplicationController

    def new
        @pokemon = Pokemon.new
    end

    def create
        p = Pokemon.new({:name => (params[:pokemon])[:name], 
                         :trainer_id    => current_trainer, 
                         :level         => 1, 
                         :health => 100})
        test = p.save
        if test
            redirect_to trainer_path(current_trainer)
        else
            redirect_to pokemons_new_path(p.errors.full_messages)
        end
    end

    def capture
        @pokemon = Pokemon.find(params[:id])
        @pokemon.update_attribute(:trainer_id, current_trainer)
        redirect_to root_path
    end

    def damage
        @pokemon = Pokemon.find(params[:id])
        id = @pokemon.trainer_id
        @pokemon.update_attribute(:health, @pokemon.health - 10)
        if @pokemon.health <= 0
           @pokemon.destroy 
        end
        redirect_to trainer_path(id)
    end

end
