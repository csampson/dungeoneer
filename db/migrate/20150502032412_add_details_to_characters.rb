class AddDetailsToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :current_hp, :integer
    add_column :characters, :max_hp, :integer
    add_column :characters, :current_hit_die, :integer
    add_column :characters, :max_hit_die, :integer
    add_column :characters, :hit_die, :string
    add_column :characters, :ac, :integer
    add_column :characters, :speed, :integer
    add_column :characters, :alignment, :string
    add_column :characters, :klass, :string
  end
end
