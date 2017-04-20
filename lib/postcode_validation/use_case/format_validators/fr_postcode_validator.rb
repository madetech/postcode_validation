class FRPostcodeValidator
  def valid? postcode
    validation = /^(F-)?((2[A|B])|[0-9]{2})[0-9]{3}$/ =~ postcode
    validation.nil? ? false : true
  end
end
