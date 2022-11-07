# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Attachments::Creator) do
  let(:results) { described_class.new(data: params, user: user, password: password).call }
  let(:user) { create(:user) }
  let(:password) { SecureRandom.hex(16) }

  let(:tempfile) { { tempfile: Tempfile.new, filename: 'filename' }.with_indifferent_access }

  describe 'when valid request' do
    let(:params) { { files: [tempfile] } }

    it 'creates attachment' do
      expect { results }.to(change(Attachment, :count).from(0).to(1))
    end

    it 'attach zip file to attachment' do
      results
      expect(Attachment.find_each.all? { |a| a.zip_file.attached? }).to(be(true))
    end
  end
end
