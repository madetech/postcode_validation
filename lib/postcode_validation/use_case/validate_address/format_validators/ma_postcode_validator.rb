require_relative 'regex_validator'
require_relative 'use_format_check_only'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class MAPostcodeValidator < RegexValidator
          include UseFormatCheckOnly

          REGEX = /^\d{2}\s?\d{3}$/
        end
      end
    end
  end
end
