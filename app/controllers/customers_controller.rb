class CustomersController < ApplicationController
  def index
    customers = current_user.customers.select(:id, :name)
    render json: customers, status: 200
  end

  def update
    if customer = Customer.find_by(customer_params)
      return render_status_422("#{customer.name}は既に登録されています")
    end

    return head :no_content if sample_user_action?

    begin
      set_customer.update!(customer_params)
    rescue ActiveRecord::RecordInvalid
      return render_status_422("名前を入力して下さい")
    end

    head :no_content
  end

  private

  def set_customer
    Customer.find_by(id: params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name).merge(user_id: current_user.id)
  end

  def render_status_422(exception)
    render json: { errors: [exception] }, status: 422
  end
end
