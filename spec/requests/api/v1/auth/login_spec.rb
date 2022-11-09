# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/login#POST', type: :request do
  let(:valid_input) { { email: user.email, password: password } }
  let(:user) { create(:user, password: password) }

  let(:password) { 'ValidPassword123!' }

  before { post '/api/v1/login', params: input }

  context 'when valid request' do
    let(:input) { valid_input }

    it 'has http status 200' do
      expect(response).to(have_http_status(200))
    end

    it 'returns valid jwt token' do
      expect(json_response['token'].present?).to(be(true))
    end
  end

  context 'when invalid request' do
    context 'when invalid email or password' do
      let(:input) { valid_input.merge(email: 'invalid') }

      let(:expected_error_message) do
        I18n.t('errors.api.unauthorized.default_message')
      end

      it 'has http status 401' do
        expect(response).to(have_http_status(401))
      end

      it 'returns error message in JSON response' do
        expect(json_response['error']).to(eq(expected_error_message))
      end
    end
  end
end
