# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Attachments::FilesZipper) do
  describe '#call' do
    let(:results) { described_class.new(files: files, password: password).call }
    let(:tempfile) { { tempfile: Tempfile.new, filename: 'filename' }.with_indifferent_access }

    context 'when valid request' do
      let(:files) { [tempfile] }
      let(:password) { SecureRandom.hex(16) }

      it 'returns zipped files binary' do
        expect(results.is_a?(StringIO)).to(be(true))
      end
    end
  end
end
