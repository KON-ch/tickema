class UsersController < ApplicationController
  def show
    stage = Stage.select(:id, :title).order(created_at: :desc)
    render json: { stages: stage, name: current_user.name }
  end
end
