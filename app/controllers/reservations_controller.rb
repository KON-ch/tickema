class ReservationsController < ApplicationController
  def create
    customer_name = params.require(:customer).permit(:name)[:name]

    return render_status_422("名前を入力してください") if customer_name.blank?

    customer = Customer.find_or_initialize_by(name: customer_name, user_id: current_user.id)

    if sample_user_action?
      reservation = customer.reservations.build(reservation_params)
      render json: TicketSerializer.new(reservation), status: 200
      return
    end

    customer.save!

    begin
      reservation = customer.reservations.create(reservation_params)
    rescue ActiveRecord::RecordNotUnique
      return render_status_422("#{customer.name}は同日に登録されています")
    end

    customer_stage_history =
      CustomerStageHistory.find_or_initialize_by(
        customer_id: customer.id,
        stage_id: reservation.schedule.stage_id
      )

    customer_stage_history.save!

    render json: TicketSerializer.new(reservation), status: 201
  end

  def destroy
    if sample_user_action?
      return head :no_content
    end

    reservation = Reservation.find_by(id: params[:id])
    reservation.destroy!

    stage_id = reservation.schedule.stage_id
    customer = reservation.customer

    if customer.reservations.for_stage(stage_id, current_user.id).blank?
      CustomerStageHistory.find_by(stage_id: stage_id, customer_id: customer.id).destroy!
    end

    head :no_content
  end


  # PATCH
  def status
    if sample_user_action?
      render json: status_params[:status], status: 200
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
    if sample_user_action?
      return head :no_content
    end

    begin
      set_reservation.update!(count_params)
    rescue ActiveRecord::RecordInvalid
      render_status_422("枚数は1枚以上にして下さい")
    else
      head :no_content
    end
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

  def render_status_422(exception)
    render json: { errors: [exception] }, status: 422
  end
end
