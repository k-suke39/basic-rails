class BoardsController < ApplicationController
  before_action :is_login?, only: %i[index]
  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end
end
