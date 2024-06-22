require 'rails_helper'

RSpec.describe 'Robots', type: :request do
  let(:robot) { create(:robot) }
  let(:params) { { id: robot.id, command: 'MOVE' } }

  describe 'PUT /robots/update' do
    it 'returns http success' do
      put(robots_path(robot), params:)

      expect(response).to have_http_status(:success)
    end
  end
end
