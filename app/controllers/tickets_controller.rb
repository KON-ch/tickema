class TicketsController < ApplicationController
  def create
    ticket = Ticket.new(ticket_params)

    if ticket.save
      render json: ticket.data
    else
      render_status_422(ticket.errors.full_messages)
    end
  end

  def update
    if set_ticket.update!(ticket_params)
      head :no_content
    else
      render_status_422(ticket.errors.full_messages)
    end
  end

  def destroy
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
