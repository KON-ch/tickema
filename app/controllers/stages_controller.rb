class StagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_stage, only: %i[show update destroy]

  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    stages = Stage.select(:id, :title)
    render json: stages
  end

  def show
    render json: @stage
  end

  def create
    stage = Stage.new(stage_params)
    if stage.save
      render json: stage, status: 201
    else
      render json: { errors: stage.errors.full_messages }, status: 422
    end
  end

  def update
    if @stage.update(stage_params)
      head :no_content
    else
      render json: { errors: @stage.errors.full_messages }, status: 422
    end
  end

  def destroy
    @stage.destroy!
    head :no_content
  end

  private
    def stage_params
      params.require(:stage).permit(:title)
    end

    def set_stage
      @stage = Stage.find_by(id: params[:id])
    end

    def render_status_404(exception)
      render json: { errors: [exception] }, status: 404
    end

    def render_status_500(exception)
      render json: { errors: [exception] }, status: 500
    end
end
