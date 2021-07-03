class StagesController < ApplicationController
  def index
    stages = Stage.select(:title)
    render json: stages
  end
end
