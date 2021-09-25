require 'csv'

class CustomersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    render json: current_user.customers.select(:id, :name)
  end

  def show
    render json: set_customer
  end

  def create
    if name_params.blank?
      render_status_422("名前を入力してください")
      return
    end

    customer = Customer.find_or_initialize_by(name: name_params, user_id: current_user.id)

    customer.schedule_id = schedule_params[:id]

    begin
      customer.save
    rescue ActiveRecord::RecordNotUnique
      render_status_422("#{customer.name}は同じ日に登録されています")
    else
      render json: customer, status: 201
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
    set_customer.stage_customers.find_by(stage_schedule_id: params[:schedule_id]).destroy!
    head :no_content
  end

  def data
    stage_customer = set_customer.stage_customers.find_by(stage_schedule_id: schedule_params[:id])

    if stage_customer.update(stage_customer_params)
      head :no_content
    else
      render_status_422(stage_customer.errors.full_messages)
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

  def stage_customer_params
    params.require(:customer).permit(:count, :contacted)
  end

  def schedule_params
    params.require(:schedule).permit(:id)
  end

  def set_customer
    Customer.find_by(id: params[:id])
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_422(exception)
    render json: { errors: [exception] }, status: 422
  end
end
