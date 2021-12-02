class StaticPagesController < ApplicationController
  before_action :load_soccer_field, only: :show
  def index
    @soccer_fields = SoccerField.order_by_field_name
                                .paginate(page: params[:page],
                                          per_page: Settings.paginate.home)
  end

  def show
    @comments = @soccer_field.comments.newest
    @comment = Comment.new
  end

  private

  def load_soccer_field
    @soccer_field = SoccerField.find_by(id: params[:id])
    return if @soccer_field

    flash[:warning] = t "booking.update_booking.not_exist_id"
    redirect_to root_path
  end
end
