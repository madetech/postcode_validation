require_relative 'regex_validator'
class FRPostcodeValidator < RegexValidator
  REGEX = /^(F-)?((2[A|B])|[0-9]{2})[0-9]{3}$/
end
