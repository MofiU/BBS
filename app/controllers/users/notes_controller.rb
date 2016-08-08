class Users::NotesController < ApplicationController
  def index
    @notes = []
    100.times do |i|
      @notes << {id: i, name: "item#{i}", price: "$#{i}"}
    end
    # @notes = current_user.notes

  end
end
