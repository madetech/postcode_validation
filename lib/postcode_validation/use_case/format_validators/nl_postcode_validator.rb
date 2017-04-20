require_relative 'regex_validator'
class NLPostcodeValidator < RegexValidator
  REGEX = /(NL-)?(\d{4})\s*([A-Z]{2})/
end
