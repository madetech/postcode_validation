require_relative 'format_validators/nl_postcode_validator'
require_relative 'format_validators/be_postcode_validator'
require_relative 'format_validators/gb_postcode_validator'
require_relative 'format_validators/fr_postcode_validator'
require_relative 'format_validators/sg_postcode_validator'
require_relative 'format_validators/in_postcode_validator'
require_relative 'format_validators/vn_postcode_validator'
require_relative 'format_validators/th_postcode_validator'
require_relative 'format_validators/my_postcode_validator'
require_relative 'format_validators/no_op_postcode_validator'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      class FormatValidator
        def for(country)
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
            when 'IN'
              FormatValidators::INPostcodeValidator.new
            when 'VN'
              FormatValidators::VNPostcodeValidator.new
            when 'TH'
              FormatValidators::THPostcodeValidator.new
            when 'MY'
              FormatValidators::MYPostcodeValidator.new
            else
              FormatValidators::NoOpPostcodeValidator.new
          end
        end
      end
    end
  end
end
