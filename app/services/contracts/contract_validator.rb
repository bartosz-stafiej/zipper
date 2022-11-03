# frozen_string_literal: true

module Contracts
  class ContractValidator
    def initialize(contract:, params:)
      @contract = contract
      @params = params
    end

    def validate!
      validation_results = @contract.call(@params)
      raise(Api::Errors::ValidationFailed.new(details: validation_results.errors.to_h)) if validation_results.failure?

      validation_results.to_h
    end
  end
end
