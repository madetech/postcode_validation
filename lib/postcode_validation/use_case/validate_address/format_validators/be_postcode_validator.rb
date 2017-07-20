require_relative 'regex_validator'
require_relative 'use_external_postcode_validator'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class BEPostcodeValidator < RegexValidator
          include UseExternalPostcodeValidator

          REGEX = /^[1-9]{1}[0-9]{3}$/
        end
      end
    end
  end
end
