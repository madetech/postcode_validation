class BEPostcodeValidator
  def valid? postcode
    validation = /^[1-9]{1}[0-9]{3}$/ =~ postcode
    validation.nil? ? false : true
  end
end
