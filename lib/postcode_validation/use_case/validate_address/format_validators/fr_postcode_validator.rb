require_relative 'regex_validator'
require_relative 'use_external_postcode_validator'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class FRPostcodeValidator < RegexValidator
          include UseExternalPostcodeValidator

          REGEX = /^(F-)?((2[A|B])|[0-9]{2})[0-9]{3}$/
        end
      end
    end
  end
end
