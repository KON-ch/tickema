class StageSchedulesController < ApplicationController
  def show
    stage_schedule = StageSchedule.find_by(id: params[:id])
    customers = stage_schedule.customers.pluck(:name)

    render json: customers
  end
end
