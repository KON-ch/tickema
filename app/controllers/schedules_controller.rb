class SchedulesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    return unless stage = Stage.find_by(id: params.require(:stage_id))

    schedule_params.each do |param|
      schedule = Schedule.new(param)
      if schedule.save
        stage_schedule = StageSchedule.new(stage_id: stage.id, schedule_id: schedule.id)
        stage_schedule.save
        render json: schedule, status: 201
      else
        render json: { errors: schedule.errors.full_messages }, status: 422
      end
    end
  end

  private
    def schedule_params
      params.require(:schedule).map do |s|
        s.permit(:staging_date, :start_time)
      end
    end
end
