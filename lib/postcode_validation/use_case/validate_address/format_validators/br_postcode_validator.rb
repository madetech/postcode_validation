require_relative 'regex_validator'
require_relative 'use_format_check_only'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class BRPostcodeValidator < RegexValidator
          include UseFormatCheckOnly

          REGEX = /^\d{5}(-\d{3})?$/
        end
      end
    end
  end
end
