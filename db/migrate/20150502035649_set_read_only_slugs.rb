class SetReadOnlySlugs < ActiveRecord::Migration
  def change
    Character.all.each(&:regenerate_read_only_slug)
  end
end
