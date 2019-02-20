require 'rails_helper'

RSpec.describe 'QuestionControllerController Api', type: :request do
  # Initialize the test data
  let(:user) { create(:user) }
  let(:headers) { {
      "Authorization" => user.token,
      "Content-Type" => "application/json"
    } }

  # Test suite for GET /questions
  describe 'GET /questions' do
    # make HTTP get request before each example
    before { get '/questions' }

    it 'returns questions' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

    # Test suite for GET /questions?sort=pending_first
  describe 'GET /questions?sort=pending_first' do
    # make HTTP get request before each example
    before { get '/questions?sort=pending_first' }

    it 'returns questions' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /questions
  describe 'POST /questions' do
    let(:valid_attributes) { { title: 'respuesta test', description: Faker::Lorem.characters(100) }.to_json }


    context 'when request attributes are valid' do
      before do
        post "/questions", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/questions", params: {}, headers: headers }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end

      it 'returns a failure message' do
        expect(json['message']).to match("Access denied")
      end
    end
  end
end
