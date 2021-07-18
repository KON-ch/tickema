class StageSchedulesController < ApplicationController
  def show
    stage_schedule = StageSchedule.find_by(id: params[:id])
    customers = stage_schedule.customers.select(:id, :name)

    render json: customers
  end
end
