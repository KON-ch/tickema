require 'csv'

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
      render_status_422("名前を入力してください")
      return
    end

    customer.schedule_id = schedule_params[:id]

    if customer.save
      render json: customer, status: 201
    else
      render_status_422(customer.errors.full_messages)
    end
  end

  def update
    customer = set_customer
    if customer.update(name: name_params)
      head :no_content
    else
      render_status_422(customer.errors.full_messages)
    end
  end

  def destroy
    set_customer.destroy!
    head :no_content
  end

  def count
    count = count_params[:count]
    # status: 422
    return head :unprocessable_entity unless count.to_i.positive?

    customer = set_stage_customer(count_params[:schedule_id])
    if customer.update(count: count)
      head :no_content
    else
      render_status_422(customer.errors.full_messages)
    end
  end

  def contacted
    customer = set_stage_customer(contacted_params[:schedule_id])
    if customer.update(contacted: contacted_params[:contacted])
      head :no_content
    else
      render json: { errors: customer.errors.full_messages }, status: 422
    end
  end

  def csv
    customers = current_user.customers.filter_map do |customer|
      customer if customer.stage_schedules.find_by(stage_id: params[:id])
    end

    csv_data = CSV.generate do |csv|
      csv << %w[名前 日付 開演時間 備考]

      customers.each do |customer|
        customer_schedule = customer.stage_schedules.find_by(stage_id: params[:id]).schedule
        csv << [customer.name, l(customer_schedule.staging_date), l(customer_schedule.start_time)]
      end
    end

    send_data(csv_data)
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

    def set_stage_customer(stage_schedule_id)
      set_customer.stage_customers.find_by(stage_schedule_id: stage_schedule_id)
    end

    def render_status_404(exception)
      render json: { errors: [exception] }, status: 404
    end

    def render_status_422(exception)
      render json: { errors: [exception] }, status: 422
    end
end
