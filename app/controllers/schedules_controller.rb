class SchedulesController < ApplicationController
  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def create
    # status: 422
    return head :unprocessable_entity unless stage = Stage.find_by(id: stage_params[:id])

    schedules = []

    schedule_params.each do |param|
      schedule          = Schedule.new(param)
      schedule.stage_id = stage.id

      if schedule.save
        schedules << schedule
      else
        return render json: { errors: schedule.errors.full_messages }, status: 422
      end
    end

    render json: schedules, status: 201
  end

  private

  def stage_params
    params.require(:stage).permit(:id)
  end

  def schedule_params
    params.require(:schedule).map do |s|
      s.permit(:staging_date, :start_time)
    end
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end
end
