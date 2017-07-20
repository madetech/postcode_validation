require_relative 'regex_validator'
require_relative 'use_external_postcode_validator'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class GBPostcodeValidator < RegexValidator
          include UseExternalPostcodeValidator

          REGEX = /(?i)([A-Z]{1,2}[0-9]{1,2}[A-Z]?)\s*([0-9][A-Z]{2})/
        end
      end
    end
  end
end
