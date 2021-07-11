class SchedulesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    return unless stage = Stage.find_by(id: params.require(:stage_id))

    schedules = []
    schedule_params.each do |param|
      schedule = Schedule.new(param)
      if schedule.save
        schedules << schedule
        StageSchedule.new(stage_id: stage.id, schedule_id: schedule.id).save
      else
        return render json: { errors: schedule.errors.full_messages }, status: 422
      end
    end
    render json: schedules, status: 201
  end

  private
    def schedule_params
      params.require(:schedule).map do |s|
        s.permit(:staging_date, :start_time)
      end
    end
end
