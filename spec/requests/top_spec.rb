require 'rails_helper'

RSpec.describe "Tops", type: :request do
  describe "GET #index " do
    it "status 200" do
      get "/"
      expect(response).to have_http_status(200)
    end
  end
end
