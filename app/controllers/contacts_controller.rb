class ContactsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def update
    return if current_user.email == ENV['TEST_USER_EMAIL']

    begin
      set_contact.update!(contact_params)
    rescue ArgumentError
      render_status_422("#{contact_params[:status]}は登録できません")
    else
      render json: set_contact.status, status: 201
    end
  end

  private

  def set_contact
    Contact.find_by(id: params[:id])
  end

  def contact_params
    params.require(:contact).permit(:status, :ticket_id).merge(user_id: current_user.id)
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_422(exception)
    render json: { errors: [exception] }, status: 422
  end
end
