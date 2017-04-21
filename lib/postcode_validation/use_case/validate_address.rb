module PostcodeValidation
  module UseCase
    require_relative 'format_validator'
    class ValidateAddress
      def initialize(address_match_gateway:, logger: nil)
        @format_validator = FormatValidator.new
        @address_match_gateway = address_match_gateway
        @logger = logger
        @errors = []
      end

      def execute(postcode:, country:)
        ensure_country(country)
        ensure_postcode_format(postcode, country)
        result = matched_addresses(postcode, country)

        ensure_results(result)

        result_payload(result, postcode)
      rescue PostcodeValidation::Error::RequestError => e
        gracefully_handle_error(e)
      end

      private

      attr_reader :address_match_gateway, :logger, :postcode, :country

      def result_payload(result, postcode)
        return { valid?: false, reason: @errors } unless @errors.empty?

        result.each do |address|
          return { valid?: true, reason: 'valid_postcode' } if address.postcode_matches? postcode
        end
      end

      def on_error(e)
        logger.error(e) unless logger.nil?
      end

      def matched_addresses(postcode, country)
        @address_match_gateway.query(search_term: postcode,
                                     country: country)
      end

      def ensure_results(result)
        @errors << 'no_matches' if result.first.nil?
      end

      def ensure_country(country)
        @errors << 'no_country_provided' if country.nil?
      end

      def ensure_postcode_format(postcode, country)
        return if country.nil?
        validator = @format_validator.for(country)
        @errors << 'invalid_format' if !validator.valid?(postcode)
      end

      def gracefully_handle_error(error)
        on_error(error)
        { valid?: true, reason: 'unable_to_reach_service' }
      end
    end
  end
end
