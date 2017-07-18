require_relative 'format_validators/nl_postcode_validator'
require_relative 'format_validators/be_postcode_validator'
require_relative 'format_validators/gb_postcode_validator'
require_relative 'format_validators/fr_postcode_validator'
require_relative 'format_validators/sg_postcode_validator'
require_relative 'format_validators/no_op_postcode_validator'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      class FormatValidator
        def for country
          case country
            when 'NL'
              FormatValidators::NLPostcodeValidator.new
            when 'GB'
              FormatValidators::GBPostcodeValidator.new
            when 'BE'
              FormatValidators::BEPostcodeValidator.new
            when 'FR'
              FormatValidators::FRPostcodeValidator.new
            when 'SG'
              FormatValidators::SGPostcodeValidator.new
            else
              FormatValidators::NoOpPostcodeValidator.new
          end
        end
      end
    end
  end
end
