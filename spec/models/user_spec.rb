# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to(have_db_column(:email).of_type(:string).with_options(null: false)) }
  it { is_expected.to(have_db_column(:password_digest).of_type(:string).with_options(null: false)) }

  it { is_expected.to(have_db_column(:created_at).of_type(:datetime).with_options(null: false)) }
  it { is_expected.to(have_db_column(:updated_at).of_type(:datetime).with_options(null: false)) }

  it { is_expected.to(have_secure_password) }

  it do
    should(
      have_many(:attachments)
        .inverse_of(:owner)
        .dependent(:destroy)
    )
  end
end
