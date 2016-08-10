class Users::NotesController < ApplicationController
  before_action :get_recent_notes, except: [:create, :destroy]

  def index
    @notes = current_user.notes
  end

  def show
    @note = Note.find(params[:id])
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.create(title: note_params[:title], body: note_params[:body], user_id: current_user.id)
    if @note.valid?
      redirect_to users_note_url(@note)
    else
      render 'new'
    end
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      redirect_to users_note_url(@note)
    else
      render 'edit'
    end
  end

  def edit
    @note = Note.find(params[:id])
  end

  def destroy
    note = Note.find(params[:id])
    note.update!(deleted_at: Time.now)
    redirect_to users_notes_path
  end

  private

  def note_params
    params.require(:note).permit(:title, :body)
  end

  def get_recent_notes
    @recent_notes = current_user.notes.recently
  end

end

