require_relative 'regex_validator'
require_relative 'use_format_check_only'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class LTPostcodeValidator < RegexValidator
          include UseFormatCheckOnly

          REGEX = /^LT(-|\s)?(\d{5})$/
        end
      end
    end
  end
end
