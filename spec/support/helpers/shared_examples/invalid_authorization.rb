# frozen_string_literal: true

RSpec.shared_examples 'invalid_authorization' do
  context 'when could not authorize user' do
    let(:expected_message) { I18n.t('errors.api.unauthorized.default_message') }

    it 'has 401 response code' do
      expect(response).to(have_http_status(401))
    end

    it 'returns error message id json_response' do
      expect(json_response['error']).to(eq(expected_message))
    end
  end
end
