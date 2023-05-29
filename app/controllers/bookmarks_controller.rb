class BookmarksController < ApplicationController
  def create
    bookmark = Bookmark.new(user_id: current_user.id, board_id: params[:board_id])
    bookmark.save
    redirect_to boards_path, success: t('bookmarks.create.successful')
  end

  def destroy
    bookmark = Bookmark.find_by(user_id: current_user.id, board_id: params[:board_id])
    bookmark.delete
    redirect_to boards_path, danger: t('bookmarks.destroy.successful')
  end
end
