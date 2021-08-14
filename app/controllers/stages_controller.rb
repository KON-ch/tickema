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

    @stage.schedules.order(:staging_date).select(:id, :staging_date, :start_time).each do |s|
      id = StageSchedule.find_by(stage_id: @stage.id, schedule_id: s.id).id
      schedules << { id: id, staging_date: l(s.staging_date), start_time: l(s.start_time) }
    end

    stage = { title: @stage.title, schedules: schedules, customers: set_customers(@stage) }

    render json: stage
  end

  def create
    stage = Stage.new(stage_params)
    if stage.save
      render json: stage, status: 201
    else
      render json: { errors: stage.errors.full_messages }, status: 422
    end
  end

  def update
    if @stage.update(stage_params)
      head :no_content
    else
      render json: { errors: @stage.errors.full_messages }, status: 422
    end
  end

  def destroy
    @stage.destroy!
    head :no_content
  end

  private
    def stage_params
      params.require(:stage).permit(:title)
    end

    def set_stage
      @stage = Stage.find_by(id: params[:id])
    end

    def render_status_404(exception)
      render json: { errors: [exception] }, status: 404
    end

    def render_status_500(exception)
      render json: { errors: [exception] }, status: 500
    end

    def set_customers(stage)
      customers = []
      user_customers = Customer.includes([:stage_schedules]).where(user_id: current_user.id).select(:id, :name)

      user_customers.each do |customer|
        customer.stage_schedules.each do |s|
          next unless s.stage_id == stage.id
          schedule = Schedule.find_by(id: s.schedule_id)
          schedule_id = StageSchedule.find_by(stage_id: stage.id, schedule_id: schedule.id).id
          date = schedule.staging_date
          count = s.stage_customers.find_by(customer_id: customer.id).count
          customers << { id: customer.id, name: customer.name, schedule_id: schedule_id, schedule: l(date), count: count }
        end
      end

      customers
    end
end
