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

  describe 'POST /robots/upload_file' do
    let(:file_path) { Rails.root.join('spec', 'fixtures', 'sample_a') }
    let(:file_type) { 'text/plain' }
    let(:file) { fixture_file_upload(file_path, file_type) }
    let(:axis_x) { 0 }
    let(:axis_y) { 1 }
    let(:face) { 'SOUTH' }
    let(:response_body) { JSON.parse(response.body, symbolize_names: true) }

    before do
      post(upload_file_robots_path, params: { id: robot.id, file: })
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(response_body[:axis_x]).to eq(axis_x) }
    it { expect(response_body[:axis_y]).to eq(axis_y) }
    it { expect(response_body[:face]).to eq(face) }
  end
end
