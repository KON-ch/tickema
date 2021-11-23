class TicketsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_status_422

  def create
    ticket = Ticket.new(ticket_params)

    ticket.save!

    render json: ticket.serializable_hash, status: 201

    ticket.destroy! if sample_user_action?
  end

  def update
    return if sample_user_action?

    set_ticket.update!(ticket_params)
    head :no_content
  end

  def destroy
    return if sample_user_action?

    set_ticket.destroy!
    head :no_content
  end

  private

  def set_ticket
    Ticket.find_by(id: params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:count, :stage_id, :schedule_id, :customer_id)
  end

  def render_status_422(exception)
    render json: { errors: [exception] }, status: 422
  end
end
