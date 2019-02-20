require 'rails_helper'

RSpec.describe 'AnswerControllerController Api', type: :request do
  # Initialize the test data
  let(:user) { create(:user) }
  let(:headers) { {
      "Authorization" => user.token,
      "Content-Type" => "application/json"
    } }

  describe 'GET /answers' do
    before { get "/answers" }

    context 'when todo answers exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

    end
  end

  # Test suite for POST /answers
  describe 'POST /answers' do
    let(:valid_attributes) { { content: 'respuesta test', is_correct: false }.to_json }


    context 'when request attributes are valid' do
      before do
        post "/answers", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/answers", params: {}, headers: headers }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end

      it 'returns a failure message' do
        expect(json['message']).to match("Access denied")
      end
    end
  end

end
