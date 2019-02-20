require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { build(:user) }
  let(:valid_attributes) do
    attributes_for(:user, username: user.username, screen_name:user.screen_name,  password: user.password, password_digest: user.password)
  end

  # User users test suite
  describe 'POST /users' do
    context 'when valid request' do
      before { post '/users', params: valid_attributes.to_json}
      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match("User created successfully")
      end

    end

    context 'when invalid request' do
      before { post '/users', params: {}}

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match("Username can't be blank Screen name can't be blank Email can't be blank Password digest can't be blank Password can't be blank")
      end
    end
  end
end
