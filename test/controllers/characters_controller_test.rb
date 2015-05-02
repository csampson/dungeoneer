require 'test_helper'

class CharactersControllerTest < ActionController::TestCase
  setup do
    @character = characters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:characters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create character" do
    assert_difference('Character.count') do
      post :create, character: { background: @character.background, bonds: @character.bonds, charisma: @character.charisma, constitution: @character.constitution, dexterity: @character.dexterity, flaws: @character.flaws, ideals: @character.ideals, inteligence: @character.inteligence, name: @character.name, personality_traits: @character.personality_traits, proficiency_bonus: @character.proficiency_bonus, race: @character.race, strength: @character.strength, wisdom: @character.wisdom }
    end

    assert_redirected_to character_path(assigns(:character))
  end

  test "should show character" do
    get :show, id: @character
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @character
    assert_response :success
  end

  test "should update character" do
    patch :update, id: @character, character: { background: @character.background, bonds: @character.bonds, charisma: @character.charisma, constitution: @character.constitution, dexterity: @character.dexterity, flaws: @character.flaws, ideals: @character.ideals, inteligence: @character.inteligence, name: @character.name, personality_traits: @character.personality_traits, proficiency_bonus: @character.proficiency_bonus, race: @character.race, strength: @character.strength, wisdom: @character.wisdom }
    assert_redirected_to character_path(assigns(:character))
  end

  test "should destroy character" do
    assert_difference('Character.count', -1) do
      delete :destroy, id: @character
    end

    assert_redirected_to characters_path
  end
end