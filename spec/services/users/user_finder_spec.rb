# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Users::UserFinder) do
  describe '#self.find_by_credentials' do
    let(:results) { described_class.find_by_credentials(email:, password:) }

    let(:user) { create(:user, password: valid_password) }
    let(:valid_password) { 'password' }

    context 'when valid credentials' do
      let(:email) { user.email }
      let(:password) { valid_password }

      it 'returns found and validated user' do
        expect(results).to(eq(user))
      end
    end

    context 'when invalid credentials' do
      context 'when invalid email' do
        let(:email) { 'invalid_email' }
        let(:password) { valid_password }

        it 'returns nil' do
          expect(results).to(be(nil))
        end
      end

      context 'when invalid password' do
        let(:email) { user.email }
        let(:password) { 'invalid' }

        it 'returns nil' do
          expect(results).to(be(nil))
        end
      end

      context 'when params are missing' do
        let(:email) { '' }
        let(:password) { '' }

        it 'returns nil' do
          expect(results).to(be(nil))
        end
      end
    end
  end
end
