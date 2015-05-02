class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :background
      t.string :personality_traits
      t.string :ideals
      t.string :bonds
      t.string :flaws
      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :inteligence
      t.integer :wisdom
      t.integer :charisma
      t.integer :proficiency_bonus
      t.string :race

      t.timestamps null: false
    end
  end
end
