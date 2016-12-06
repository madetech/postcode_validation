module PostcodeValidation
  module UseCase
    class ValidateAddress
      def initialize(address_match_gateway:, logger: nil)
        @address_match_gateway = address_match_gateway
        @logger = logger
      end

      def execute(postcode:, country:)
        @postcode = postcode
        @country = country
        { valid?: valid_postcode? }
      rescue PostcodeValidation::Error::RequestError => e
        on_error(e)
        { valid?: true }
      end

      private

      attr_reader :address_match_gateway, :logger, :postcode, :country

      def on_error(e)
        logger.error(e) unless logger.nil?
      end

      def valid_postcode?
        address = first_potential_address
        return false if address.nil?

        address.postcode_matches? postcode
      end

      def first_potential_address
        potential_address_matches = @address_match_gateway.query(search_term: postcode,
                                                                 country: country)
        potential_address_matches.first
      end
    end
  end
end
