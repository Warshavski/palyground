require 'rails_helper'

RSpec.describe 'About endpoint', type: :request do

  let(:root_url) { '/' }

  describe 'GET #show' do
    before do
      allow(PlaygroundApp).to receive(:version).and_return(1)
      allow(PlaygroundApp).to receive(:revision).and_return(2)
    end

    before(:each) { get root_url }

    it { expect(response).to have_http_status(:ok) }

    it { expect(response.body).to look_like_json }

    it 'responds with expected data' do
      expected_data = {
        'data' => {
          'version' => 1,
          'revision' => 2
        }
      }

      expect(body_as_json).to eq(expected_data)
    end
  end
end
