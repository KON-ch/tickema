class StagesController < ApplicationController
  before_action :set_stage, only: %i[show update destroy]

  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    stages = Stage.select(:id, :title)
    render json: stages
  end

  def show
    schedules = []
    stage     = set_stage

    stage.schedules.order(:staging_date, :start_time).select(:id, :staging_date, :start_time).each do |s|
      id = stage.stage_schedules.find_by(schedule_id: s.id).id
      schedules << { id: id, staging_date: l(s.staging_date), start_time: l(s.start_time) }
    end

    stage = { id: stage.id, title: stage.title, schedules: schedules, customers: set_customers }

    render json: stage
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
    customers = []

    current_user.customers.includes([:stage_schedules]).each do |customer|
      customer.stage_schedules.each do |s|
        next if s.stage_id != params[:id].to_i

        date = s.schedule.staging_date
        stage_customer = s.stage_customers.find_by(customer_id: customer.id)
        customers << {
          id:          customer.id,
          name:        customer.name,
          schedule_id: s.id,
          schedule:    l(date),
          count:       stage_customer.count,
          contacted:   stage_customer.contacted
        }
      end
    end

    customers
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
