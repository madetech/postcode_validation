require_relative 'regex_validator'
class BEPostcodeValidator < RegexValidator
  REGEX = /^[1-9]{1}[0-9]{3}$/
end
