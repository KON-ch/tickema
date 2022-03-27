class ReservationsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  # PATCH
  def status
    if sample_user_action?
      render json: Reservation::STATUS.key(status_params)
      return
    end

    reservation = set_reservation

    begin
      reservation.update!(status: status_params)
    rescue ArgumentError
      render_status_422("#{status_params}は登録できません")
    else
      render json: reservation.status, status: 200
    end
  end

  # PATCH
  def count
    return head :no_content if sample_user_action?

    set_reservation.update!(count: count_params)
    head :no_content
  end

  private

  def set_reservation
    Reservation.find_by(id: params[:id])
  end

  def status_params
    params.require(:reservation).permit(:status)
  end

  def count_params
    params.require(:reservation).permit(:count)
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_422(exception)
    render json: { errors: [exception] }, status: 422
  end


end
