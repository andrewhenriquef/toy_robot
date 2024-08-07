require 'rails_helper'

RSpec.describe 'Boards', type: :request do
  before do
    create(:robot)
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/boards/index'
      expect(response).to have_http_status(:success)
    end
  end
end
