require_relative 'validate_address/format_validator'

module PostcodeValidation
  module UseCase
    class AddressList
      def initialize(address_list_gateway:, logger: nil)
        @address_list_gateway = address_list_gateway
        @logger = logger
      end

      def execute(postcode:, country:)
        result = matched_addresses(postcode, country)

        result_payload(result)
      rescue PostcodeValidation::Error::RequestError => e
        log_error(e)
      end

      private

      attr_reader :address_match_gateway, :logger

      def result_payload(result)
        result.map do |address|
          { street_address: address.street_address, place: address.place }
        end
      end

      def log_error(e)
        logger.error(e) unless logger.nil?
      end

      def matched_addresses(postcode, country)
        @address_list_gateway.query(search_term: postcode,
                                    country: country)
      end
    end
  end
end
