require_relative 'regex_validator'
require_relative 'use_format_check_only'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class CNPostcodeValidator < RegexValidator
          include UseFormatCheckOnly

          REGEX = /^[0-9]{6}(?:\s*,\s*[0-9]{6})*$|^[0-9]{4}(?:\s*,\s*[0-9]{6})*$/
        end
      end
    end
  end
end
