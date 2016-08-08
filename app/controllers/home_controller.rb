class HomeController < ApplicationController
  def index
    redirect_to users_notes_path
  end
end
