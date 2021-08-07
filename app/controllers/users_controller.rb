class UsersController < ApplicationController
  def show
    stage = Stage.select(:id, :title).first
    render json: stage
  end
end
