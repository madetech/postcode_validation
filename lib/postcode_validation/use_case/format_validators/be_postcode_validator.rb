class BEPostcodeValidator
  def valid?(postcode)
    /^[1-9]{1}[0-9]{3}$/.match?(postcode)
  end
end
