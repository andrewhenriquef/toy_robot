require 'rails_helper'

RSpec.describe "Robots", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/robots/index"
      expect(response).to have_http_status(:success)
    end
  end

end
