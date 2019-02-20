require 'rails_helper'

RSpec.describe UserControllerController, type: :controller do
  let(:user) { build(:user) }
  let(:headers) { { "Content-Type" => "application/json" } }
  let(:valid_attributes) do
    attributes_for(:user, username: user.username, screen_name:user.screen_name,  password: user.password)
  end

  # User users test suite
  describe 'POST /users' do
    context 'when valid request' do
      before { post '/users', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/users', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match("Validation failed: Password can't be blank, Username can't be blank, Username is too short (minimum is 2 characters), Password digest can't be blank, Screen name can't be blank, Email can't be blank")
      end
    end
  end
end
