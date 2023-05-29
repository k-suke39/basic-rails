module ApplicationHelper
  def bookmark?(board)
    bookmark = Bookmark.find_by(user_id: board.user.id, board_id: board.id)
    bookmark ? true : false
  end
end
