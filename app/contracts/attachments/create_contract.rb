# frozen_string_literal: true

module Attachments
  class CreateContract < ApplicationContract
    ONE_GIGABYTE_IN_BYTES = 1_073_741_824

    config.messages.namespace = 'attachments.create'

    json do
      required(:files).value(:array, min_size?: 1, max_size?: 10)
    end

    rule(:files).each do |index:|
      key([:files, index]).failure(:size_too_big) if value.size > ONE_GIGABYTE_IN_BYTES
    end
  end
end
