require_relative 'regex_validator'
require_relative 'use_external_postcode_validator'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class NoOpPostcodeValidator < RegexValidator
          include UseExternalPostcodeValidator

          REGEX = /.*/
        end
      end
    end
  end
end
