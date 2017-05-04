module PostcodeValidation
  module Gateway
    class PCAPostcodeToAddresses
      include HTTParty

      KEY = ENV['POSTCODE_ANYWHERE_KEY']
      base_uri 'https://services.postcodeanywhere.co.uk'

      def initialize(search_term:, country:)
        @search_term = search_term
        @country = country
      end

      def execute
        postcode_to_street_addresses.map do |row|
          PostcodeValidation::Domain::Address.new(street_address: "#{row['StreetAddress']}, #{row['Place']}")
        end
      end

      private

      attr_reader :search_term, :country

      def postcode_to_street_addresses
        JSON.parse(
          self.class.get(
            '/PostcodeAnywhere/Interactive/Find/1.1/json.ws', lookup_parameters(country, search_term)
          ).body
        )
      end

      def lookup_parameters(country, search_term)
        {
          query:
          {
            Key: KEY,
            SearchTerm: search_term,
            Countries: country
          }
        }
      end
    end
  end
end
