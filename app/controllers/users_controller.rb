class UsersController < ApplicationController
  def show
    stage = Stage.select(:id, :title)
    render json: stage
  end
end
