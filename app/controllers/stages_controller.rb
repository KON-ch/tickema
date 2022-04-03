class StagesController < ApplicationController
  def show
    user_stages = current_user.stages.select(:id, :title)
    stage = user_stages.find_by(id: params[:id])

    # 予約
    reservations = Reservation.for_stage(params[:id], current_user.id)

    # 予約候補者(未予約)
    candidates =
      ProvideCandidatesService.new(user_id: current_user.id, stage_id: params[:id]).list

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
    }, status: 200
  end
end
