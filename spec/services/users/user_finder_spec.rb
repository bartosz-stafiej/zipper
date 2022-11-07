# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Users::UserFinder) do
  describe '#self.find_by_credentials' do
    let(:results) { described_class.find_by_credentials(email: email, password: password) }

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

  describe '#self.find_from_auth_token' do
    let(:results) { described_class.find_by_token(token) }
    let(:user) { create(:user) }

    context 'when valid request' do
      let(:token) { JsonWebToken.encode({ user_id: user.id }) }

      it 'returns user' do
        expect(results).to(eq(user))
      end
    end

    context 'when invalid request' do
      context 'when invalid JWT token format' do
        let(:token) { 'InvalidToken' }

        it 'raises JWT::DecodeError error' do
          expect { results }.to(raise_error(JWT::DecodeError))
        end
      end

      context 'when user from token could not be found' do
        let(:token) { JsonWebToken.encode({ user_id: 0 }) }

        it 'raises ActiveRecord::RecordNotFound error' do
          expect { results }.to(raise_error(ActiveRecord::RecordNotFound))
        end
      end
    end
  end
end
