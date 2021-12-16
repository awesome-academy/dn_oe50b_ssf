class Admin::SoccerFieldsController < AdminController
  before_action :load_soccer_field, only: %i(edit update destroy)
  before_action :check_search_location, only: :index
  def index
    @s = SoccerField.ransack(params[:q])
    @soccer_fields = @s.result(distinct: true).order_by_field_name
                       .paginate(page: params[:page],
                        per_page: Settings.paginate.manage)
  end

  def new
    @soccer_field = SoccerField.new
  end

  def create
    @soccer_field = SoccerField.new soccer_field_params
    if @soccer_field.save
      flash[:success] = t "soccer_fields_controller.create_success"
      redirect_to admin_soccer_fields_path
    else
      flash.now[:warning] = t "soccer_fields_controller.create_warning"
      render :new
    end
  end

  def edit; end

  def update
    if @soccer_field.update soccer_field_params
      flash[:success] = t "soccer_fields_controller.update_success"
      redirect_to admin_soccer_fields_path
    else
      flash.now[:warning] = t "soccer_fields_controller.update_warning"
      render :edit
    end
  end

  def destroy
    if @soccer_field&.destroy
      flash[:success] = t "soccer_fields_controller.destroy_success"
    else
      flash[:danger] = t "soccer_fields_controller.destroy_danger"
    end
    redirect_to admin_soccer_fields_path
  end

  private

  def soccer_field_params
    params.require(:soccer_field)
          .permit(:field_name, :type_field, :description, :price, :status)
  end

  def load_soccer_field
    @soccer_field = SoccerField.find_by id: params[:id]
    return if @soccer_field

    flash[:warning] = t "soccer_fields_controller.load_fail"
    redirect_to admin_soccer_fields_path
  end
end
