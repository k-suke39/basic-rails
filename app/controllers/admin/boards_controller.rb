class Admin::BoardsController < Admin::BaseController
  before_action :login?
  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show
    @board = Board.find(params[:id])
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to admin_board_path(@board), success: '掲示板を更新しました'
    else
      flash.now[:danger] = '掲示板を更新出来ませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board = Board.find(params[:id])
    @board.delete
    redirect_to admin_boards_path, success: '掲示板を削除しました', status: :see_other
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image)
  end
end
