class StagesController < ApplicationController
  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    render json: Stage.select(:id, :title)
  end

  def show
    render json: set_stage.set_schedule_data(customers_data: set_customers)
  end

  def create
    stage = Stage.new(stage_params)

    if stage.save
      render json: stage, status: 201
    else
      render_status_422(stage.errors.full_messages)
    end
  end

  def update
    stage = set_stage

    if stage.update(stage_params)
      head :no_content
    else
      render_status_422(stage.errors.full_messages)
    end
  end

  def destroy
    set_stage.destroy!
    head :no_content
  end

  private

  def stage_params
    params.require(:stage).permit(:title)
  end

  def set_stage
    Stage.find_by(id: params[:id])
  end

  def set_customers
    customers_data = []

    current_user.customers.includes([:stage_schedules]).each do |customer|
      customer.set_customer_data(customers_data, stage_id: params[:id])
    end

    customers_data
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end

  def render_status_422(exception)
    render json: { errors: [exception] }, status: 422
  end
end
