class FRPostcodeValidator
  def valid?(postcode)
    /^(F-)?((2[A|B])|[0-9]{2})[0-9]{3}$/.match?(postcode)
  end
end
