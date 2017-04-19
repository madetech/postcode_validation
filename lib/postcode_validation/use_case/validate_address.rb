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
        return false if invalid_postcode_format?
        matches = potential_address_matches
        return false if matches.first.nil?

        matches.each { |address| return true if address.postcode_matches? postcode }
        false
      end

      def potential_address_matches
        @address_match_gateway.query(search_term: postcode,
                                     country: country)
      end

      def invalid_postcode_format?
        downcase_country = country.downcase
        regex = send("#{downcase_country}_postcode_regex")
        !regex.match? postcode
      end

      def nl_postcode_regex
        /(NL-)?(\d{4})\s*([A-Z]{2})/
      end

      def gb_postcode_regex
        /(?i)([A-Z]{1,2}[0-9]{1,2}[A-Z]?)\s*([0-9][A-Z]{2})/
      end

      def fr_postcode_regex
        /^(F-)?((2[A|B])|[0-9]{2})[0-9]{3}$/
      end

      def be_postcode_regex
        /^[1-9]{1}[0-9]{3}$/
      end
    end
  end
end
