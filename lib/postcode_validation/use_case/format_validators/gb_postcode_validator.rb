class GBPostcodeValidator
  def valid? postcode
    validation = /(?i)([A-Z]{1,2}[0-9]{1,2}[A-Z]?)\s*([0-9][A-Z]{2})/ =~ postcode
    validation.nil? ? false : true
  end
end
