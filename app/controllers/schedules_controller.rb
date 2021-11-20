class SchedulesController < ApplicationController
  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404
  rescue_from ActiveRecord::RecordInvalid, with: :render_status_422

  def create
    # status: 422
    return head :unprocessable_entity unless stage = Stage.find_by(id: stage_params[:id].to_i)

    schedules = schedule_params.map do |param|
      stage.schedules.create!(param)
    end

    render json: schedules, status: 201
  end

  private

  def stage_params
    params.require(:stage).permit(:id)
  end

  def schedule_params
    params.require(:schedule).map do |s|
      s.permit(:staged_on, :staged_at)
    end
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_422(exception)
    render json: { errors: [exception] }, status: 422
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end
end
