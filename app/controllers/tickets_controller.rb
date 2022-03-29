class TicketsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_status_422

  def create
    customer_name = params.require(:customer).permit(:name)[:name]

    return render_status_422("名前を入力してください") if customer_name.blank?

    customer = Customer.find_or_initialize_by(name: customer_name, user_id: current_user.id)

    customer.save!

    begin
      ticket = customer.tickets.create(ticket_params)
    rescue ActiveRecord::RecordNotUnique
      return render_status_422("#{customer.name}は同日に登録されています")
    else
      if count_params.present?
        ticket.reservation.update!(count_params)
      end
      render json: TicketSerializer.new(ticket), status: 201
    end

    return unless sample_user_action?

    ticket.destroy!
    return if customer.tickets != Array(ticket)

    customer.destroy!
  end

  def destroy
    return if sample_user_action?

    Ticket.find_by(id: params[:id]).destroy!
    head :no_content
  end

  private

  def ticket_params
    params.require(:ticket).permit(:schedule_id)
  end

  def count_params
    return unless params[:reservation]

    params.require(:reservation).permit(:count)
  end

  def render_status_422(exception)
    render json: { errors: [exception] }, status: 422
  end
end
