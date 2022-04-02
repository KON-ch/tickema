class StagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def show
    user_stages = current_user.stages.select(:id, :title)
    stage = user_stages.find_by(id: params[:id])

    # 予約
    reservations = Reservation.for_stage(params[:id], current_user.id)

    # 未予約 = 全顧客 - 予約済顧客
    user_customers = current_user.customers.select(:id, :name)
    candidates = user_customers - user_customers.reserved(params[:id])

    tickets =
      reservations.includes(:customer, :schedule).map do |reservation|
        TicketSerializer.new(reservation)
      end

    other_stages = user_stages - Array(stage)

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
