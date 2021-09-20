class CustomersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    customers = current_user.customers.select(:id, :name)
    render json: customers
  end

  def show
    render json: set_customer
  end

  def create
    begin
      customer = Customer.new(name: name_params, user_id: current_user.id)
    rescue ActionController::ParameterMissing
      render json: { errors: ["名前を入力してください"] }, status: 422
      return
    end

    customer.schedule_id = schedule_params[:id]

    if customer.save
      render json: customer, status: 201
    else
      render json: { errors: customer.errors.full_messages }, status: 422
    end
  end

  def update
    customer = set_customer
    if customer.update(name: name_params)
      head :no_content
    else
      render json: { errors: customer.errors.full_messages }, status: 422
    end
  end

  def destroy
    set_customer.destroy!
    head :no_content
  end

  def count
    count = count_params[:count]
    return head :unprocessable_entity unless count.to_i.positive?

    customer = set_customer.stage_customers.find_by(stage_schedule_id: count_params[:schedule_id])
    if customer.update(count: count)
      head :no_content
    else
      render json: { errors: customer.errors.full_messages }, status: 422
    end
  end

  def contacted
    customer = set_customer.stage_customers.find_by(stage_schedule_id: contacted_params[:schedule_id])
    if customer.update(contacted: contacted_params[:contacted])
      head :no_content
    else
      render json: { errors: customer.errors.full_messages }, status: 422
    end
  end

  private
    def name_params
      params.require(:customer).permit(:family_name, :first_name).values.join(" ")
    end

    def count_params
      params.require(:customer).permit(:schedule_id, :count)
    end

    def schedule_params
      params.require(:schedule).permit(:id)
    end

    def contacted_params
      params.require(:customer).permit(:schedule_id, :contacted)
    end

    def set_customer
      Customer.find_by(id: params[:id])
    end

    def render_status_404(exception)
      render json: { errors: [exception] }, status: 404
    end
end
