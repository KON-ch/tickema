class StagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    stages = current_user.stages.select(:id, :title)
    render json: {stages: stages}, status: 200
  end

  def show
    stage = set_stage

    # 予約済
    reservations = Reservation.for_stage(params[:id], current_user.id)

    # 未予約
    candidates = current_user.customers.select(:id, :name).not_reserved(reservations)

    tickets = reservations.includes(:customer, :schedule).map do |reservation|
      TicketSerializer.new(reservation)
    end

    render json: {
      id: stage.id,
      title: stage.title,
      schedules: stage.schedules.select(:id, :staged_on, :staged_at),
      tickets: tickets,
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
