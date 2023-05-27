class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.board_id = params[:board_id]
    if @comment.save
      redirect_to board_path(params[:board_id]), success: t('comments.create.successful')
    else
      @board = Board.find_by(id: params[:board_id])
      @comments = @board.comments.order(created_at: :desc)
      flash[:danger] = t('comments.create.failure')
      render 'boards/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
