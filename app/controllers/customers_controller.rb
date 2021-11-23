class CustomersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def create
    return render_status_422("名前を入力してください") if customer_params[:name].blank?

    customer = Customer.find_or_initialize_by(customer_params)

    customer.save!

    begin
      ticket = customer.tickets.create(ticket_params)
    rescue ActiveRecord::RecordNotUnique
      return render_status_422("#{customer.name}は同日に登録されています")
    else
      render json: ticket.serializable_hash, status: 201
    end

    customer.destroy! if sample_user_action? && customer.tickets == Array(ticket)
  end

  private

  def customer_params
    params.require(:customer).permit(:name).merge(user_id: current_user.id)
  end

  def ticket_params
    params.require(:ticket).permit(:stage_id, :schedule_id)
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_422(exception)
    render json: { errors: [exception] }, status: 422
  end
end
