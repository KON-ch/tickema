class ContactsController < ApplicationController
  def update
    if set_contact.update!(contact_params)
      render json: set_contact.status
    else
      render_status_422(contact.errors.full_messages)
    end
  end

  private

  def set_contact
    Contact.find_by(id: params[:id])
  end

  def contact_params
    params.require(:contact).permit(:status, :ticket_id).merge(user_id: current_user.id)
  end

  def render_status_422(exception)
    render json: { errors: [exception] }, status: 422
  end
end
