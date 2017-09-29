require_relative 'regex_validator'
require_relative 'use_format_check_only'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class NLPostcodeValidator < RegexValidator
          include UseFormatCheckOnly

          REGEX = /(NL-)?(\d{4})\s*([A-Za-z]{2})/
        end
      end
    end
  end
end
