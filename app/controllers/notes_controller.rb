class NotesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  before_action :get_recent_notes, except: [:create, :destroy]

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
      redirect_to note_url(@note)
    else
      render 'new'
    end
  end

  def update
    if @note.update(note_params)
      redirect_to note_url(@note), notice: '笔记更新成功'
    else
      render 'edit'
    end
  end

  def edit
  end

  def destroy
    if @note.destroy
      redirect_to notes_path, notice: '删除笔记成功'
    else
      redirect_to notes_path, alert: '程序异常，删除失败'
    end
  end

  private

  def note_params
    params.require(:note).permit(:title, :body)
  end

  def get_recent_notes
    @recent_notes = current_user.notes.recently
  end
end
