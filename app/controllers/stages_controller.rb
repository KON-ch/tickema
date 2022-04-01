class StagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    stages = current_user.stages.select(:id, :title)
    render json: {stages: stages}, status: 200
  end

  def show
    stage = set_stage

    # 予約済
    tickets = Ticket.for_stage(current_user.id, params[:id])

    # 未予約
    candidates =
      current_user.customers.select(:id, :name) - tickets.unscoped.includes(:customer).map(&:customer)

    render json: {
      id: stage.id,
      title: stage.title,
      schedules: stage.schedules.select(:id, :staged_on, :staged_at),
      tickets: tickets.unscoped.includes(:reservation, :schedule, :customer).map { |ticket| TicketSerializer.new(ticket) },
      candidates: candidates
    }
  end

  private

  def set_stage
    Stage.find_by(id: params[:id])
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end
end
