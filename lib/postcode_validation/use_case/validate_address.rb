require_relative 'validate_address/format_validator'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      def initialize(address_match_gateway:, logger: nil)
        @format_validator = FormatValidator.new
        @address_match_gateway = address_match_gateway
        @logger = logger
        @errors = []
      end

      def execute(postcode:, country:)
        check_country(country)

        if country == 'SG'
          if check_postcode_format(postcode_without_spaces(postcode), country)
            return { valid?: true, reason: ['valid_postcode'] }
          end
        end

        check_postcode_format(postcode, country)
        result = matched_addresses(postcode, country)

        check_matched_addresses(result)

        result_payload(result, postcode)
      rescue PostcodeValidation::Error::RequestError => e
        gracefully_handle_error(e)
      end

      private

      attr_reader :address_match_gateway, :logger, :postcode, :country

      def result_payload(result, postcode)
        return { valid?: false, reason: @errors } unless @errors.empty?

        result.each do |address|
          return { valid?: true, reason: ['valid_postcode'] } if address.postcode_matches? postcode
        end

        { valid?: false, reason: ['no_postcode_matches_found'] }
      end

      def on_error(e)
        logger.error(e) unless logger.nil?
      end

      def matched_addresses(postcode, country)
        @address_match_gateway.query(search_term: postcode,
                                     country: country)
      end

      def check_matched_addresses(result)
        @errors << 'no_matches' if result.first.nil?
      end

      def check_country(country)
        @errors << 'no_country_provided' if country.nil?
      end

      def check_postcode_format(postcode, country)
        return if country.nil?
        validator = @format_validator.for(country)
        @errors << 'invalid_format' if !validator.valid?(postcode)
      end

      def gracefully_handle_error(error)
        on_error(error)
        { valid?: true, reason: ['unable_to_reach_service'] }
      end

      def postcode_without_spaces(postcode)
        postcode.gsub(' ', '')
      end
    end
  end
end
