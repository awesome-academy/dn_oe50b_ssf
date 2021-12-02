class CommentsController < ApplicationController
  before_action :find_soccer_field, only: :create

  def create
    @comment = current_user.comments.build comment_params
    @comment.soccer_field_id = @soccer_field.id
    if @comment.save
      flash[:success] = t "comment_controller.success"
      redirect_to static_page_path @soccer_field
    else
      flash[:warning] = t "comment_controller.fail"
      redirect_to static_page_path params[:soccer_field_id]
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_soccer_field
    @soccer_field = SoccerField.find_by id: params[:comment][:soccer_field_id]
    return if @soccer_field

    flash[:warning] = t "comment_controller.fail"
    redirect_to static_page_path params[:soccer_field_id]
  end
end
