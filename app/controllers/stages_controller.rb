class StagesController < ApplicationController
  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def show
    stage = set_stage

    render json: {
      id:                 stage.id,
      title:              stage.title,
      stages:             current_user.stages.select(:id, :title).where.not(id: stage.id).order(id: :desc),
      schedules:          stage.schedules.select(:id, :staged_on, :staged_at),
      tickets:            set_tickets,
      unbooked_customers: set_unbooked_customers
    }
  end

  private

  def stage_params
    params.require(:stage).permit(:title)
  end

  def set_stage
    Stage.find_by(id: params[:id])
  end

  def set_tickets
    @tickets = set_stage.tickets.includes(%i[contact schedule customer]).filter_map do |ticket|
      ticket.serializable_hash if ticket.manager?(current_user.id)
    end
  end

  def set_unbooked_customers
    booked_customer_ids   = @tickets.map { |ticket| ticket["customer_id"] }.uniq
    current_user.customers.select(:id, :name).where.not(id: booked_customer_ids)
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end

  def render_status_422(exception)
    render json: { errors: [exception] }, status: 422
  end
end
