class RemoveUserIdFromPokemons < ActiveRecord::Migration
  def change
    remove_column :pokemons, :user_id, :integer
  end
end
