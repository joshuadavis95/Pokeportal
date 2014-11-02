class PokemonsController < ApplicationController

    def new
        @pokemon = Pokemon.new
    end

    def create
        p = Pokemon.new({:name => (params[:pokemon])[:name], 
                         :trainer_id    => current_trainer, 
                         :level         => 1, 
                         :health => 100,
                         :exp => 0})
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
        @pokemon       = Pokemon.find(params[:victim])
        @enemy_pokemon = Pokemon.find(params[:pokemon][:id])
        d = -10;
        if @pokemon.health <= 0
            d = 0;
        end
        @pokemon.update_attribute(:health, @pokemon.health + d)

       @enemy_pokemon.update_attribute(:exp, @enemy_pokemon.exp + 10)
        if @enemy_pokemon.exp >= 100
            @enemy_pokemon.update_attribute(:exp, 0)
            @enemy_pokemon.update_attribute(:level, @enemy_pokemon.level + 1)
        end
        redirect_to trainer_path(@pokemon.trainer_id)
    end

    def heal
        d = 10;
        @pokemon = Pokemon.find(params[:id])
        if @pokemon.health >= 100
           d = 0;
        end
        @pokemon.update_attribute(:health, @pokemon.health + d)
        redirect_to trainer_path(@pokemon.trainer_id)
    end

end
