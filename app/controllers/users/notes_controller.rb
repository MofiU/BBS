class Users::NotesController < Users::ApplicationController
  before_action :get_recent_notes, except: [:create, :destroy]
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @notes = @user.notes.publish
  end

  def show
  end

  private

  def note_params
    params.require(:note).permit(:title, :body)
  end

  def get_recent_notes
    @recent_notes = current_user.notes.recently
  end

  def set_note
    @note = Note.find(params[:id])
  end

  def set_user
    @user = User.find(params[:id])
  end

end

