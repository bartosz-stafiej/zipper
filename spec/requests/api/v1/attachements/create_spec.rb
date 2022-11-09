# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/attachments#POST', type: :request do
  let(:user) { create(:user) }
  let(:tempfile) do
    temp = Tempfile.new
    Rack::Test::UploadedFile.new(temp)
  end

  context 'when valid request' do
    let(:params) { { files: [tempfile] } }
    let(:token) { auth_token(user) }

    before { post '/api/v1/attachments', params: params, headers: { 'Authorization' => "Bearer #{token}" } }

    it 'has 201 response code' do
      expect(response).to(have_http_status(201))
    end

    it 'returns valid json response' do
      expect(json_response['id']).not_to(be(nil))
      expect(json_response['password']).not_to(be(nil))
    end
  end

  context 'when invalid request' do
    include_examples 'invalid_authorization' do
      let(:params) { {} }
      let(:token) { '' }
      before { post '/api/v1/attachments', params: params, headers: { 'Authorization' => "Bearer #{token}" } }
    end

    context 'when bad request' do
      context 'when trying to add 2 the same files' do
        let(:token) { auth_token(user) }
        let(:params) do
          file = tempfile.dup

          { files: [file, tempfile] }.with_indifferent_access
        end
        let(:expected_error_message) { I18n.t('errors.api.bad_request.uploads.conflict') }

        before do
          allow(Zip::OutputStream).to(receive(:write_buffer).and_raise(Zip::EntryExistsError))

          post '/api/v1/attachments', params: params, headers: { 'Authorization' => "Bearer #{token}" }
        end

        it 'has 400 response code' do
          expect(response).to(have_http_status(400))
        end

        it 'returns expected error messages in json response' do
          expect(json_response['error']).to(eq(expected_error_message))
        end
      end
    end

    context 'when validation failed' do
      let(:token) { auth_token(user) }

      before { post '/api/v1/attachments', params: params, headers: { 'Authorization' => "Bearer #{token}" } }

      context 'when missing params' do
        let(:params) { {} }
        let(:expected_error_message) { 'files is missing, files is invalid' }

        it 'has 400 response code' do
          expect(response).to(have_http_status(400))
        end

        it 'returns expected error messages in json response' do
          expect(json_response['error']).to(eq(expected_error_message))
        end
      end

      context 'when invalid params' do
        let(:params) { { files: [1] } }
        let(:expected_error_message) { 'files is invalid' }

        it 'has 400 response code' do
          expect(response).to(have_http_status(400))
        end

        it 'returns expected error messages in json response' do
          expect(json_response['error']).to(eq(expected_error_message))
        end
      end
    end
  end
end
