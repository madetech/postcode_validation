require_relative 'regex_validator'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class NLPostcodeValidator < RegexValidator
          REGEX = /(NL-)?(\d{4})\s*([A-Za-z]{2})/
        end
      end
    end
  end
end
