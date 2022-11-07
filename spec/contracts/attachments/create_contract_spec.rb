# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Attachments::CreateContract) do
  describe '#call' do
    let(:results) { described_class.new.call(params) }

    context 'when valid params' do
      let(:params) { { files: [Tempfile.new] } }

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

        let(:expected_error_messages) { { files: ['is missing'] } }

        it 'fails' do
          expect(results.failure?).to(be(true))
        end

        it 'returns expected error messages in response' do
          expect(results.errors.to_h).to(eq(expected_error_messages))
        end
      end

      context 'when too many files' do
        let(:params) { { files: too_many_files_arr } }
        let(:too_many_files_arr) do
          (1..11).map { Tempfile.new }
        end

        let(:expected_error_messages) { { files: ['size cannot be greater than 10'] } }

        it 'fails' do
          expect(results.failure?).to(be(true))
        end

        it 'returns expected error messages in response' do
          expect(results.errors.to_h).to(eq(expected_error_messages))
        end
      end

      context 'when too big file in size' do
        let(:params) { { files: [huge_file] } }
        let(:expected_error_messages) do
          {
            files: {
              0 => [I18n.t('dry_validation.errors.attachments.create.rules.files.size_too_big')]
            }
          }
        end

        let(:huge_file) { Tempfile.new }

        before { expect(huge_file).to(receive(:size).and_return(10_000_000_000)) }

        it 'fails' do
          expect(results.failure?).to(be(true))
        end

        it 'returns expected error messages in response' do
          expect(results.errors.to_h).to(eq(expected_error_messages))
        end
      end
    end
  end
end
