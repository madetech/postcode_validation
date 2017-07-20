require_relative 'regex_validator'
require_relative 'use_format_check_only'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class INPostcodeValidator < RegexValidator
          include UseFormatCheckOnly

          REGEX = /^[1-9][0-9]{5}$/
        end
      end
    end
  end
end
