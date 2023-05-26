class BoardsController < ApplicationController
  def index
    user = User.find_by(id: current_user.id)
    @boards = user.boards
  end
end
