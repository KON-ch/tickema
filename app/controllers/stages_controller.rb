class StagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    stages = current_user.stages.select(:id, :title)
    render json: {stages: stages}, status: 200
  end

  def show
    stage = set_stage

    render json: {
      id: stage.id,
      title: stage.title,
      schedules: stage.schedules.select(:id, :staged_on, :staged_at),
    }
  end

  # GET
  def tickets
    tickets =
      Ticket.includes(:customer, :schedule, :reservation)
            .for_stage(current_user.id, params[:id]).map do |ticket|
        TicketSerializer.new(ticket)
      end

    render json: { tickets: tickets}, status: 200
  end

  # GET
  def candidates
    candidates = current_user.customers.select(:id, :name).not_reserved(params[:id])
    render json: { candidates: candidates}, status: 200
  end

  private

  def set_stage
    Stage.find_by(id: params[:id])
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end
end
