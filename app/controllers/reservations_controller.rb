class ReservationsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def create
    customer_name = params.require(:customer).permit(:name)[:name]

    return render_status_422("名前を入力してください") if customer_name.blank?

    customer = Customer.find_or_initialize_by(name: customer_name, user_id: current_user.id)

    customer.save!

    begin
      reservation = customer.reservations.create(reservation_params)
    rescue ActiveRecord::RecordNotUnique
      return render_status_422("#{customer.name}は同日に登録されています")
    else
      render json: TicketSerializer.new(reservation), status: 201
    end

    return unless sample_user_action?

    reservation.destroy!
    return if customer.reservations.present?

    customer.destroy!
  end

  def destroy
    return if sample_user_action?

    Reservation.find_by(id: params[:id]).destroy!
    head :no_content
  end


  # PATCH
  def status
    if sample_user_action?
      render json: Reservation::STATUS.key(status_params[:status])
      return
    end

    reservation = set_reservation

    begin
      reservation.update!(status_params)
    rescue ArgumentError
      render_status_422("#{status_params[:status]}は登録できません")
    else
      render json: reservation.status, status: 200
    end
  end

  # PATCH
  def count
    return head :no_content if sample_user_action?

    set_reservation.update!(count_params)
    head :no_content
  end

  private

  def set_reservation
    Reservation.find_by(id: params[:reservation_id])
  end

  def reservation_params
    params.require(:reservation).permit(:schedule_id, :count)
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
