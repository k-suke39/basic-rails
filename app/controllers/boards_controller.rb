class BoardsController < ApplicationController
  before_action :login?
  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end

  def show
    @board = Board.find_by(id: params[:id])
    @comment = Comment.new
    @comments = @board.comments.order(created_at: :desc)
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id
    if @board.save
      redirect_to boards_path, success: t('boards.create.successful')
    else
      flash.now[:danger] = t('boards.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to boards_path, success: t('boards.edit.successful')
    else
      flash.now[:danger] = t('boards.edit.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board = current_user.boards.find(params[:id])
    @board.delete
    redirect_to boards_path, success: t('boards.destroy.successful'), status: :see_other
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image)
  end
end
