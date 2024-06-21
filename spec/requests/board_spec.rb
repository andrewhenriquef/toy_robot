require 'rails_helper'

RSpec.describe "Boards", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/board/index"
      expect(response).to have_http_status(:success)
    end
  end

end