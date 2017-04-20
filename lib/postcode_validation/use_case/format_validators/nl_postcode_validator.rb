class NLPostcodeValidator
  def valid?(postcode)
    /(NL-)?(\d{4})\s*([A-Z]{2})/.match?(postcode)
  end
end
