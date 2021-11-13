class UsersController < ApplicationController
  def show
    stage = current_user.stages.select(:id, :title).order(created_at: :desc)
    render json: { stages: stage, name: current_user.name }
  end
end
