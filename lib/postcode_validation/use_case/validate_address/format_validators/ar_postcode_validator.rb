require_relative 'regex_validator'
require_relative 'use_format_check_only'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class ARPostcodeValidator < RegexValidator
          include UseFormatCheckOnly

          REGEX = /^([A-HJ-TP-Z]{1}\d{4}[A-Z]{3}|[a-z]{1}\d{4}[a-hj-tp-z]{3})$/
        end
      end
    end
  end
end
