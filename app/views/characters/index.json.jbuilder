json.array!(@characters) do |character|
  json.extract! character, :id, :name, :background, :personality_traits, :ideals, :bonds, :flaws, :strength, :dexterity, :constitution, :inteligence, :wisdom, :charisma, :proficiency_bonus, :race
  json.url character_url(character, format: :json)
end
