class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show update destroy]

  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    customers = current_user.customers.select(:id, :name)
    render json: customers
  end

  def show
    render json: @customer
  end

  def create
    customer = Customer.new(name: customer_params)
    customer.schedule_id = params.require(:schedule_id)
    customer.user_id = current_user.id
    if customer.save
      render json: customer, status: 201
    else
      render json: { errors: customer.errors.full_messages }, status: 422
    end
  end

  def update
    if @customer.update(name: customer_params)
      head :no_content
    else
      render json: { errors: @customer.errors.full_messages }, status: 422
    end
  end

  def destroy
    @customer.destroy!
    head :no_content
  end

  private
    def customer_params
      params.require(:customer).permit(:family_name, :first_name).values.join(" ")
    end

    def set_customer
      @customer = Customer.find_by(id: params[:id])
    end

    def render_status_404(exception)
      render json: { errors: [exception] }, status: 404
    end

    def render_status_500(exception)
      render json: { errors: [exception] }, status: 500
    end
end
