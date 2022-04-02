class CustomersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    customers = current_user.customers.select(:id, :name)
    render json: customers, status: 200
  end

  def update
    if customer = Customer.find_by(customer_params)
      return render_status_422("#{customer.name}は既に登録されています")
    end

    return if sample_user_action?

    set_customer.update!(customer_params)
    head :no_content
  end

  private

  def set_customer
    Customer.find_by(id: params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name).merge(user_id: current_user.id)
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_422(exception)
    render json: { errors: [exception] }, status: 422
  end
end
