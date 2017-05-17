require_relative 'regex_validator'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class NoOpPostcodeValidator < RegexValidator
          REGEX = /.*/
        end
      end
    end
  end
end
