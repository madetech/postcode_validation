require_relative 'regex_validator'
require_relative 'use_format_check_only'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class BOPostcodeValidator < RegexValidator
          include UseFormatCheckOnly

          REGEX = /^\d{4}$/
        end
      end
    end
  end
end
