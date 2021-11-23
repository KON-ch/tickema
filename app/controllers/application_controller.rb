class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def sample_user_action?
    current_user.email == ENV['TEST_USER_EMAIL']
  end
end
