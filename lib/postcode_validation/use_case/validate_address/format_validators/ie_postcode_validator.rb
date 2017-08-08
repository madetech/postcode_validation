require_relative 'regex_validator'
require_relative 'use_format_check_only'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class IEPostcodeValidator < RegexValidator
          include UseFormatCheckOnly

          REGEX = /\A([AC-FHKNPRTV-Y]\d{2}|D6W)[0-9AC-FHKNPRTV-Y]{4}\z/
        end
      end
    end
  end
end
