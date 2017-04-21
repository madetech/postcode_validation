module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        class RegexValidator
          def valid? postcode
            validation = self.class::REGEX =~ postcode
            !validation.nil?
          end
        end
      end
    end
  end
end
