class RegexValidator
  def valid? postcode
    validation = self.class::REGEX =~ postcode
    !validation.nil?
  end
end
