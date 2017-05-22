require_relative 'validate_address/format_validator'

module PostcodeValidation
  module UseCase
    class AddressList
      def initialize(address_list_gateway:, logger: nil)
        @address_list_gateway = address_list_gateway
        @logger = logger
        @errors = []
      end

      def execute(postcode:, country:)
        check_country(country)
        addresses = matched_addresses(postcode, country)

        formatted(addresses)
      rescue PostcodeValidation::Error::RequestError => e
        log_error(e)
      end

      private

      attr_reader :address_match_gateway, :logger

      def formatted(addresses)
        return { errors: @errors } unless @errors.empty?

        addresses.map do |address|
          {
            id: address.id,
            label: address.label
          }
        end
      end

      def log_error(e)
        logger.error(e) unless logger.nil?
      end

      def matched_addresses(postcode, country)
        @address_list_gateway.query(search_term: postcode,
                                    country: country)
      end

      def check_country(country)
        @errors << 'no_country_provided' if country.nil?
      end
    end
  end
end
