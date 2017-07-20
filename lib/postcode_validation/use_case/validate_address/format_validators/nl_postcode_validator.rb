require_relative 'regex_validator'
require_relative 'use_external_postcode_validator'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class NLPostcodeValidator < RegexValidator
          include UseExternalPostcodeValidator

          REGEX = /(NL-)?(\d{4})\s*([A-Za-z]{2})/
        end
      end
    end
  end
end
