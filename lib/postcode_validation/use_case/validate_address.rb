module PostcodeValidation
  module UseCase
    require_relative 'format_validator'
    class ValidateAddress
      def initialize(address_match_gateway:, logger: nil)
        @format_validator = FormatValidator.new
        @address_match_gateway = address_match_gateway
        @logger = logger
      end

      def execute(postcode:, country:)
        @postcode = postcode
        @country = country
        return { valid?: false, reason: 'invalid_format' } if invalid_postcode_format?
        matches = potential_address_matches
        return { valid?: false, reason: 'no_matches' } if matches.first.nil?
        matches.each do |address|
          return { valid?: true, reason: 'valid_postcode' } if address.postcode_matches? postcode
        end
        { valid?: false, reason: 'no_matches' }
      rescue PostcodeValidation::Error::RequestError => e
        on_error(e)
        { valid?: true, reason: 'unable_to_reach_service' }
      end

      private

      attr_reader :address_match_gateway, :logger, :postcode, :country

      def on_error(e)
        logger.error(e) unless logger.nil?
      end

      def potential_address_matches
        @address_match_gateway.query(search_term: postcode,
                                     country: country)
      end

      def invalid_postcode_format?
        validator = @format_validator.for(country)
        !validator.valid?(postcode)
      end
    end
  end
end
