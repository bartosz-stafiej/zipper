# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { is_expected.to(have_db_column(:created_at).of_type(:datetime).with_options(null: false)) }
  it { is_expected.to(have_db_column(:updated_at).of_type(:datetime).with_options(null: false)) }

  it { is_expected.to(have_one_attached(:zip_file)) }

  it do
    should(
      belong_to(:owner)
        .class_name('User')
        .inverse_of(:attachments)
    )
  end
end
