require_relative 'format_validators/nl_postcode_validator'
require_relative 'format_validators/be_postcode_validator'
require_relative 'format_validators/gb_postcode_validator'
require_relative 'format_validators/fr_postcode_validator'

class FormatValidator
   def for country
     case country
     when 'NL'
       NLPostcodeValidator.new
     when 'GB'
       GBPostcodeValidator.new
     when 'BE'
       BEPostcodeValidator.new
     when 'FR'
       FRPostcodeValidator.new
     end
   end
end
