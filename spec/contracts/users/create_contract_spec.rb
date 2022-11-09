# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Users::CreateContract) do
  describe '#call' do
    let(:results) { described_class.new.call(params) }

    context 'when valid params' do
      let(:params) { attributes_for(:user) }

      it 'is successful' do
        expect(results.success?).to(be(true))
      end

      it 'returns params in response' do
        expect(results.to_h).to(eq(params))
      end
    end

    context 'when invalid params' do
      context 'when missing params' do
        let(:params) { {} }
        let(:expected_errors) do
          {
            email: ['is missing'],
            password: ['is missing']
          }
        end

        it 'fails' do
          expect(results.failure?).to(be(true))
        end

        it 'returns errors in response' do
          expect(results.errors.to_h).to(eq(expected_errors))
        end
      end

      context 'when invalid formatted params' do
        let(:params) { { email: 'invalid', password: 'invalid' } }
        let(:expected_errors) do
          {
            email: ['is in invalid format'],
            password: ['is in invalid format']
          }
        end

        it 'fails' do
          expect(results.failure?).to(be(true))
        end

        it 'returns errors in response' do
          expect(results.errors.to_h).to(eq(expected_errors))
        end
      end

      context 'when email has already been taken' do
        let(:params) { { email: taken_email, password: attributes_for(:user)[:password] } }
        let(:taken_email) { 'taken@email.com' }
        let(:expected_errors) do
          {
            email: [I18n.t('dry_validation.errors.users.create.rules.email.taken')]
          }
        end

        before { create(:user, email: taken_email) }

        it 'fails' do
          expect(results.failure?).to(be(true))
        end

        it 'returns errors in response' do
          expect(results.errors.to_h).to(eq(expected_errors))
        end
      end
    end
  end
end
