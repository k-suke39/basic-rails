class BookmarksController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    current_user.bookmark(@board)
    redirect_to boards_path, success: t('bookmarks.create.successful')
  end

  def destroy
    @board = current_user.bookmarks.find(params[:board_id]).board
    @board.delete
    redirect_to boards_path, danger: t('bookmarks.destroy.successful'), status: :see_other
  end
end
