module PostcodeValidation
  module Gateway
    class PCAAddressList
      include HTTParty

      class PCARequestError < PostcodeValidation::Error::RequestError; end

      KEY = ENV['POSTCODE_ANYWHERE_KEY']
      base_uri 'https://services.postcodeanywhere.co.uk'

      def query(search_term:, country:)
        response = address_list_for_postcode(country, search_term)

        response.map do |row|
          raise PCARequestError, error_message(row) if row.key?('Error')

          PostcodeValidation::Domain::Address.new(street_address: row['StreetAddress'],
                                                  place: row['Place'])
        end
      end

      private

      def error_message(row)
        "#{row['Error']} #{row['Cause']} #{row['Resolution']}"
      end

      def address_list_for_postcode(country, search_term)
        JSON.parse(self.class.get('/PostcodeAnywhere/Interactive/Find/1.1/json.ws', lookup_parameters(country, search_term)).body)
      end

      def lookup_parameters(country, search_term)
        {
          query: {
            Country: country,
            Key: KEY,
            SearchTerm: search_term,
            Filter: 'None'
          }
        }
      end
    end
  end
end
