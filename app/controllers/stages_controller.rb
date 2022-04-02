class StagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def show
    user_stages = current_user.stages.select(:id, :title)
    stage = user_stages.find_by(id: params[:id])

    # 予約済
    reservations = Reservation.for_stage(params[:id], current_user.id)

    # 未予約
    candidates = current_user.customers.select(:id, :name).not_reserved(reservations)

    tickets = reservations.includes(:customer, :schedule).map do |reservation|
      TicketSerializer.new(reservation)
    end

    other_stages = user_stages - [stage]

    render json: {
      id: stage.id,
      title: stage.title,
      schedules: stage.schedules.select(:id, :staged_on, :staged_at),
      tickets: tickets,
      candidates: candidates,
      otherStages: other_stages
    }
  end

  private

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end
end
