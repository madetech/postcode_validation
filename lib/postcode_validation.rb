require 'postcode_validation/version'

module PostcodeValidation
  require 'httparty'
  require 'postcode_validation/domain/potential_address_match'
  require 'postcode_validation/error/request_error'
  require 'postcode_validation/gateway/pca_potential_address_match'
  require 'postcode_validation/use_case/validate_address'
end
