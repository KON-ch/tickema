class StagesController < ApplicationController
  def index
    stages = Stage.select(:id, :title)
    render json: stages
  end

  def show
    stage = Stage.find(params[:id])
    render json: stage
  end
end
