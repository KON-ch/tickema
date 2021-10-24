require 'csv'

class CustomersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    customers = current_user.customers.select(%i[id name]).includes(:stage_schedules, :stage_customers).reject do |customer|
      customer.watch?(params[:stage_id].to_i)
    end

    render json: customers
  end

  def show
    render json: set_customer
  end

  def create
    return render_status_422("名前を入力してください") if name_params.blank?

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
    csv_data = CSV.generate do |csv|
      csv << %w[名前 日付 時間 枚数 備考]
      current_user.set_customers(params[:id].to_i).each do |customer_data|
        csv << [customer_data[:name], customer_data[:date], customer_data[:time], customer_data[:count]]
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
