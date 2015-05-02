class AddReadOnlySlugToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :read_only_slug, :string
    add_index :characters, :read_only_slug, unique: true
  end
end
