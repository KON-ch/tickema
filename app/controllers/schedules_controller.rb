class SchedulesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    schedule = Schedule.new(schedule_params)
    if schedule.save
      stage_schedule = StageSchedule.new(stage_id: params[:stage_id], schedule_id: schedule.id)
      stage_schedule.save
      render json: schedule, status: 201
    else
      render json: { errors: schedule.errors.full_messages }, status: 422
    end
  end

  private
    def schedule_params
      params.require(:schedule).permit(:staging_date, :start_time)
    end
end
