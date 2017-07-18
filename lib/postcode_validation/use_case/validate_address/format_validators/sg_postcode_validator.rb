require_relative 'regex_validator'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class SGPostcodeValidator < RegexValidator
          REGEX = /^\d{6}$/
        end
      end
    end
  end
end
