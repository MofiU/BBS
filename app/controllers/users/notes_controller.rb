class Users::NotesController < Users::ApplicationController
  before_action :get_recent_notes, except: [:create, :destroy]
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = current_user.notes
  end

  def show
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(title: note_params[:title], body: note_params[:body], user_id: current_user.id)
    if @note.save
      redirect_to users_note_url(@note)
    else
      render 'new'
    end
  end

  def update
    if @note.update(note_params)
      redirect_to users_note_url(@note)
    else
      render 'edit'
    end
  end

  def edit
  end

  def destroy
    @note.destroy
    redirect_to users_notes_path
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

end

