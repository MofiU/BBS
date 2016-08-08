class Users::NotesController < ApplicationController
  def index
    @notes = current_user.notes
  end
end
