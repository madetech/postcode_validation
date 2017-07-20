require_relative 'validate_address/format_validator'

module PostcodeValidation
  module UseCase
    class ValidateAddress
      def initialize(address_match_gateway:, logger: nil)
        @format_validator = FormatValidator.new
        @address_match_gateway = address_match_gateway
        @logger = logger
      end

      def execute(postcode:, country:)
        @errors = []
        check_country(country)

        postcode = postcode_without_spaces(postcode)
        return the_postcode_is_valid if use_local_validator?(country) && format_valid_for_country?(country, postcode)

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
          return the_postcode_is_valid if address.postcode_matches? postcode
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
        @errors << 'invalid_format' unless format_valid_for_country?(country, postcode)
      end

      def format_valid_for_country?(country, postcode)
        validator = @format_validator.for(country)
        format_valid?(postcode, validator)
      end

      def format_valid?(postcode, validator)
        validator.valid?(postcode)
      end

      def use_local_validator?(country)
        format_check_only?(@format_validator.for(country))
      end

      def format_check_only?(validator)
        validator.format_check_only?
      end

      def gracefully_handle_error(error)
        on_error(error)
        { valid?: true, reason: ['unable_to_reach_service'] }
      end

      def postcode_without_spaces(postcode)
        postcode.gsub(' ', '')
      end

      def the_postcode_is_valid
        { valid?: true, reason: ['valid_postcode'] }
      end
    end
  end
end
