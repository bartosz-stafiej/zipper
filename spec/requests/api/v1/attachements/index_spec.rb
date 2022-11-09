# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('/api/v1/attachments#GET', type: :request) do
  let(:query_params) { { items: items, page: page } }
  let(:user) { create(:user) }

  context 'when valid request' do
    let(:items) { 10 }
    let(:page) { 1 }
    let(:token) { auth_token(user) }

    context 'when no attachment' do
      before { get '/api/v1/attachments', params: query_params, headers: { 'Authorization' => "Bearer #{token}" } }

      it 'has 200 response code' do
        expect(response).to(have_http_status(200))
      end

      it 'returns no attachment' do
        expect(json_response['data']).to(be_empty)
      end
    end

    context 'when some attachments' do
      let!(:attachments) { create_list(:attachment, 11, owner: user) }

      before { get '/api/v1/attachments', params: query_params, headers: { 'Authorization' => "Bearer #{token}" } }

      it 'has 200 response code' do
        expect(response).to(have_http_status(200))
      end

      it 'returns paginated attachments' do
        expect(json_response['data'].size).to(eq(10))
      end
    end

    context 'when some attachments that user is not owner of' do
      let!(:attachment) { create(:attachment, owner: another_user) }
      let(:another_user) { create(:user) }

      before { get '/api/v1/attachments', params: query_params, headers: { 'Authorization' => "Bearer #{token}" } }

      it 'has 200 response code' do
        expect(response).to(have_http_status(200))
      end

      it 'returns no attachment' do
        expect(json_response['data']).to(be_empty)
      end
    end
  end

  context 'when invalid request' do
    before { get '/api/v1/attachments', params: query_params, headers: { 'Authorization' => "Bearer #{token}" } }

    include_examples 'invalid_authorization' do
      let(:items) { 10 }
      let(:page) { 1 }
      let(:token) { '' }
    end

    context 'when invalid pagination params' do
      let(:token) { auth_token(user) }

      context 'when invalid page param' do
        let(:items) { 10 }
        let(:page) { -1 }

        let(:expected_error_message) { 'expected :page >= 1; got -1' }

        it 'has 400 response code' do
          expect(response).to(have_http_status(400))
        end

        it 'returns error message in json response' do
          expect(json_response['error']).to(eq(expected_error_message))
        end
      end

      context 'when invalid items param' do
        let(:items) { 0 }
        let(:page) { 1 }

        let(:expected_error_message) { 'expected :items >= 1; got 0' }

        it 'has 400 response code' do
          expect(response).to(have_http_status(400))
        end

        it 'returns error message in json response' do
          expect(json_response['error']).to(eq(expected_error_message))
        end
      end
    end
  end
end
