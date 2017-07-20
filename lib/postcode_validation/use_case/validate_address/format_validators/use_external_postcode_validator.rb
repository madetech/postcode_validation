module PostcodeValidation
  module UseCase
    class ValidateAddress
      module FormatValidators
        module UseExternalPostcodeValidator
          def format_check_only?
            false
          end
        end
      end
    end
  end
end
