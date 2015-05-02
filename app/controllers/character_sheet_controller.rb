class CharacterSheetController < ApplicationController
  def show
    @character = Character.find_by(read_only_slug: params[:id])

    render 'characters/show'
  end
end
