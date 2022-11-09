# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('/api/v1/users/me#GET', type: :request) do
  context 'when valid request' do
    let(:token) { auth_token(user) }
    let(:user) { create(:user) }

    before { get '/api/v1/users/me', headers: { 'Authorization' => "Bearer #{token}" } }

    it 'returns current user details' do
      expect(json_response['id']).to(eq(user.id))
    end

    it 'has 200 response code' do
      expect(response).to(have_http_status(200))
    end
  end

  context 'when invalid request' do
    include_examples 'invalid_authorization' do
      before { get '/api/v1/users/me', headers: { 'Authorization' => 'Bearer invalid' } }
    end

    context 'when user from headers could not be found' do
      let(:user) { create(:user) }

      let(:expected_error_message) do
        I18n.t('errors.api.not_found.model_by', model: 'User', by: 'id', value: user.id)
      end

      before do
        valid_token = auth_token(user)
        user.destroy!
        get '/api/v1/users/me', headers: { 'Authorization' => "Bearer #{valid_token}" }
      end

      it 'returns error message in json response' do
        expect(json_response['error']).to(eq(expected_error_message))
      end

      it 'has 404 response code' do
        expect(response).to(have_http_status(404))
      end
    end
  end
end
