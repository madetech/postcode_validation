require_relative 'validate_address/format_validator'

module PostcodeValidation
  module UseCase
    class AddressList
      def initialize(address_list_gateway:, logger: nil)
        @address_list_gateway = address_list_gateway
        @logger = logger
      end

      def execute(postcode:, country:, more_results_id: nil)
        addresses = matched_addresses(postcode, country, more_results_id)

        formatted(addresses)
      rescue PostcodeValidation::Error::RequestError => e
        log_error(e)
      end

      private

      attr_reader :address_match_gateway, :logger

      def formatted(addresses)
        addresses.map do |address|
          {
            street_address: address.street_address,
            more_results_id: address.more_results_id
          }
        end
      end

      def log_error(e)
        logger.error(e) unless logger.nil?
      end

      def matched_addresses(postcode, country, more_results_id)
        @address_list_gateway.query(search_term: postcode,
                                    country: country,
                                    more_results_id: more_results_id)
      end
    end
  end
end
