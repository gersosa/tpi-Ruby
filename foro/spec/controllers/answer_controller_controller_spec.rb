require 'rails_helper'

RSpec.describe AnswerControllerController, type: :controller do
  # Initialize the test data
  let(:user) { create(:user) }
  let!(:question) { create(:question, user_id: user.id) }
  let!(:answers) { create_list(:answer, 20, question_id: question.id) }
  let(:question_id) { question.id }
  let(:id) { answers.first.id }
  # let(:headers) { { Authorization: token_generator(user.id),Content-Type: "application/json" } }

  # Test suite for GET /questions/:question_id/answers
  describe 'GET /questions/:question_id/answers' do
    before { get "/questions/#{question_id}/answers" }

    context 'when question exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all question answers' do
        expect(json.size).to eq(20)
      end
    end

    context 'when question does not exist' do
      let(:question_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Question/)
      end
    end
  end

  # Test suite for GET /questions/:question_id/answers/:id
  describe 'GET /questions/:question_id/answers/:id' do
    before { get "/questions/#{question_id}/answers/#{id}" }

    context 'when todo answer exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the answer' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when question answer does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Answer/)
      end
    end
  end

  # # Test suite for POST /questions/:question_id/answers
  # describe 'POST /questions/:question_id/answers' do
  #   let(:valid_attributes) { { content: 'Visit Narnia', is_correct: false }.to_json }


  #   context 'when request attributes are valid' do
  #     before do
  #       post "/questions/#{question_id}/answers", params: valid_attributes, headers: headers
  #     end

  #     it 'returns status code 201' do
  #       expect(response).to have_http_status(201)
  #     end
  #   end

  #   context 'when an invalid request' do
  #     before { post "/questions/#{question_id}/answers", params: {}, headers: headers }

  #     it 'returns status code 422' do
  #       expect(response).to have_http_status(422)
  #     end

  #     it 'returns a failure message' do
  #       expect(response.body).to match(/Validation failed: Content can't be blank/)
  #     end
  #   end
  # end

  # Test suite for PUT /questions/:question_id/anwers/:id
  describe 'PUT /questions/:question_id/answers/:id' do
    let(:valid_attributes) { { content: 'I think this is the answer' } }

    before { put "/questions/#{question_id}/answers/#{id}", params: valid_attributes }

    context 'when answer exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the answer' do
        updated_answer = Answer.find(id)
        expect(updated_answer.content).to match(/I think this is the answer/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Answer/)
      end
    end
  end

  #Test suite for DELETE /answers/:id /questions/:question_id/answers/:id
  # describe 'DELETE /answers/:id' do
  #   before { delete "/questions/#{question_id}/answers/#{id}", params: {}, headers: headers }

  #   it 'returns status code 204' do
  #     expect(response).to have_http_status(204)
  #   end
  # end

end
