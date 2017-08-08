require_relative 'regex_validator'
require_relative 'use_format_check_only'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class ZAPostcodeValidator < RegexValidator
          include UseFormatCheckOnly

          REGEX = /^(\d{4})$/
        end
      end
    end
  end
end
