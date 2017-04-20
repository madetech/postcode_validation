class NLPostcodeValidator
  def valid? postcode
    validation = /(NL-)?(\d{4})\s*([A-Z]{2})/ =~ postcode
    validation.nil? ? false : true
  end
end
