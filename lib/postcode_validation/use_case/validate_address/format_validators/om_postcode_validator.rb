require_relative 'regex_validator'
require_relative 'use_format_check_only'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class OMPostcodeValidator < RegexValidator
          include UseFormatCheckOnly

          REGEX = /^(\d{3})$/
        end
      end
    end
  end
end
