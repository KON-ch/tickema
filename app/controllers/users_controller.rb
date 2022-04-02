class UsersController < ApplicationController
  def show
    stages = current_user.stages.select(:id, :title).order(created_at: :desc)
    render json: { stages: stages, name: current_user.name }
  end
end
