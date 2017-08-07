require_relative 'format_validators/nl_postcode_validator'
require_relative 'format_validators/be_postcode_validator'
require_relative 'format_validators/gb_postcode_validator'
require_relative 'format_validators/fr_postcode_validator'
require_relative 'format_validators/sg_postcode_validator'
require_relative 'format_validators/in_postcode_validator'
require_relative 'format_validators/vn_postcode_validator'
require_relative 'format_validators/th_postcode_validator'
require_relative 'format_validators/my_postcode_validator'
require_relative 'format_validators/es_postcode_validator'
require_relative 'format_validators/br_postcode_validator'
require_relative 'format_validators/ar_postcode_validator'
require_relative 'format_validators/dk_postcode_validator'
require_relative 'format_validators/no_postcode_validator'
require_relative 'format_validators/cn_postcode_validator'
require_relative 'format_validators/bo_postcode_validator'
require_relative 'format_validators/la_postcode_validator'
require_relative 'format_validators/bd_postcode_validator'
require_relative 'format_validators/mm_postcode_validator'
require_relative 'format_validators/uy_postcode_validator'
require_relative 'format_validators/pk_postcode_validator'
require_relative 'format_validators/id_postcode_validator'
require_relative 'format_validators/gr_postcode_validator'
require_relative 'format_validators/ie_postcode_validator'
require_relative 'format_validators/hu_postcode_validator'
require_relative 'format_validators/lk_postcode_validator'
require_relative 'format_validators/bn_postcode_validator'
require_relative 'format_validators/kh_postcode_validator'

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
            when 'ES'
              FormatValidators::ESPostcodeValidator.new
            when 'BR'
              FormatValidators::BRPostcodeValidator.new
            when 'AR'
              FormatValidators::ARPostcodeValidator.new
            when 'DK'
              FormatValidators::DKPostcodeValidator.new
            when 'NO'
              FormatValidators::NOPostcodeValidator.new
            when 'CN'
              FormatValidators::CNPostcodeValidator.new
            when 'BO'
              FormatValidators::BOPostcodeValidator.new
            when 'LA'
              FormatValidators::LAPostcodeValidator.new
            when 'BD'
              FormatValidators::BDPostcodeValidator.new
            when 'MM'
              FormatValidators::MMPostcodeValidator.new
            when 'UY'
              FormatValidators::UYPostcodeValidator.new
            when 'PK'
              FormatValidators::PKPostcodeValidator.new
            when 'ID'
              FormatValidators::IDPostcodeValidator.new
            when 'GR'
              FormatValidators::GRPostcodeValidator.new
            when 'IE'
              FormatValidators::IEPostcodeValidator.new
            when 'HU'
              FormatValidators::HUPostcodeValidator.new
            when 'LK'
              FormatValidators::LKPostcodeValidator.new
            when 'BN'
              FormatValidators::BNPostcodeValidator.new
            when 'KH'
              FormatValidators::KHPostcodeValidator.new
            else
              FormatValidators::NoOpPostcodeValidator.new
          end
        end
      end
    end
  end
end
