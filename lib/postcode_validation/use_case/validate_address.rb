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
        matches = potential_address_matches
        return false if matches.first.nil?

        matches.map { |address| return true if address.postcode_matches? postcode }
        false
      end

      def potential_address_matches
        @address_match_gateway.query(search_term: postcode,
                                     country: country)
      end
    end
  end
end
