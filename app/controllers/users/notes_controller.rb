class Users::NotesController < ApplicationController

  def index
    @notes = current_user.notes
  end

  def show
    @note = Note.find(params[:id])
  end

end
