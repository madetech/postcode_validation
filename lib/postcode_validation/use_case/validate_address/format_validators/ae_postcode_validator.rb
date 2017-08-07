require_relative 'regex_validator'
require_relative 'use_format_check_only'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class AEPostcodeValidator < RegexValidator
          include UseFormatCheckOnly

          REGEX = /(?:)/
        end
      end
    end
  end
end
