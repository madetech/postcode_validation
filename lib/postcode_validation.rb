require 'postcode_validation/version'

module PostcodeValidation
  require 'httparty'
  require 'postcode_validation/domain/potential_address_match'
  require 'postcode_validation/domain/address'
  require 'postcode_validation/error/request_error'
  require 'postcode_validation/gateway/pca_potential_address_match'
  require 'postcode_validation/gateway/pca_address_list'
  require 'postcode_validation/use_case/validate_address'
  require 'postcode_validation/use_case/address_list'
end
