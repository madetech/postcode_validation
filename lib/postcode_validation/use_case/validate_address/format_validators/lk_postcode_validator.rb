require_relative 'regex_validator'
require_relative 'use_format_check_only'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class LKPostcodeValidator < RegexValidator
          include UseFormatCheckOnly

          REGEX = /^\d{5}$/
        end
      end
    end
  end
end
