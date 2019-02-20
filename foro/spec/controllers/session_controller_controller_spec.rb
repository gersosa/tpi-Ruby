require 'rails_helper'

RSpec.describe SessionControllerController, type: :controller do

  describe 'POST /sessions' do
    # create test user
    let!(:user) { create(:user) }
    # set test valid and invalid credentials
    let(:valid_credentials) do
      {
        username: user.username,
        password: user.password
      }.to_json
    end
    let(:invalid_credentials) do
      {
        username: Faker::Internet.username,
        password: Faker::Internet.password
      }.to_json
    end

    context 'When request is valid' do
      before { post '/sessions', params: valid_credentials }

      it 'returns an authentication token' do
        expect(json['token']).not_to be_nil
      end
    end

    # returns failure message when request is invalid
    context 'When request is invalid' do
      before { post '/sessions', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect(json['message']).to match("Error with your username or password")
      end
    end
  end

end
