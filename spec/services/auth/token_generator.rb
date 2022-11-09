# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Auth::TokenGenerator) do
  describe '#call' do
    let(:results) { described_class.new(user: user).call }
    let(:user) { create(:user) }

    it 'generates valid jwt token' do
      expect(results[:token]).not_to(be(nil))
    end
  end
end
