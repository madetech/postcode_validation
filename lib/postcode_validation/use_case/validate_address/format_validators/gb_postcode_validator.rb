require_relative 'regex_validator'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class GBPostcodeValidator < RegexValidator
          REGEX = /(?i)([A-Z]{1,2}[0-9]{1,2}[A-Z]?)\s*([0-9][A-Z]{2})/
        end
      end
    end
  end
end
