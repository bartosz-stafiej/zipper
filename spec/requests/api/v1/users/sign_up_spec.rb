# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/users/sign_up', type: :request do
  let(:valid_params) { attributes_for(:user) }

  before { post '/api/v1/users/sign_up', params: params }

  context 'when valid request' do
    let(:params) { valid_params }
  end

  context 'when invalid request' do
    context 'when validation fails' do
      context 'when missing params' do
        let(:params) { {} }
        let(:expected_error_message) { 'email is missing, password is missing' }

        it 'has 400 response code' do
          expect(response).to(have_http_status(400))
        end

        it 'returns error message in json response' do
          expect(json_response['error']).to(eq(expected_error_message))
        end
      end

      context 'when invalid formatted params' do
        let(:params) { { email: 'invalid', password: 'invalid' } }
        let(:expected_error_message) do
          {
            'email' => ['is in invalid format'],
            'password' => ['is in invalid format']
          }
        end

        it 'has 422 response code' do
          expect(response).to(have_http_status(422))
        end

        it 'returns error message in json response' do
          expect(json_response['details']).to(eq(expected_error_message))
        end
      end
    end
  end
end
