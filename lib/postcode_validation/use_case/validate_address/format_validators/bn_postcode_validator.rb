require_relative 'regex_validator'
require_relative 'use_format_check_only'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class BNPostcodeValidator < RegexValidator
          include UseFormatCheckOnly

          REGEX = /^[A-Z]{2}\d{4}$/
        end
      end
    end
  end
end
