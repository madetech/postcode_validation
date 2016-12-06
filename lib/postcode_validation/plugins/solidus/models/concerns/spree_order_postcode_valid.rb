module PostcodeValidation
  class RailsLogger
    def error(error)
      Rails.logger.tagged('Remote-Validate-Address') { Rails.logger.error(error.message) }
    end
  end

  module SpreeOrderPostcodeValid
    extend ActiveSupport::Concern

    included do
      state_machine.before_transition to: :delivery,
                                      do: :validate_delivery_postcode
    end

    private

    def validate_delivery_postcode
      return if valid_postcode?

      errors.add(:ship_address_zipcode, Spree.t(:couldnt_find_postcode))
      false
    end

    def valid_postcode?
      use_case.execute(postcode: ship_address.zipcode, country: shipping_country_iso)[:valid?]
    end

    def shipping_country_iso
      ship_address.country.iso
    end

    def use_case
      PostcodeValidation::UseCase::ValidateAddress.new(
        address_match_gateway: PostcodeValidation::Gateway::PCAPotentialAddressMatch.new,
        logger: PostcodeValidation::RailsLogger.new
      )
    end
  end
end
