module PostcodeValidation
  module Gateway
    class PCAPotentialAddressMatch
      include HTTParty

      class PCARequestError < PostcodeValidation::Error::RequestError; end

      KEY = ENV['POSTCODE_ANYWHERE_KEY']
      base_uri 'https://services.postcodeanywhere.co.uk'

      def query(search_term:, country:)
        response = find_postcode(country, search_term)

        response.map do |row|
          raise PCARequestError, error_message(row) if row.key?('Error')

          PostcodeValidation::Domain::PotentialAddressMatch.new(text: row['Text'],
                                                                description: row['Description'])
        end
      end

      private

      def error_message(row)
        "#{row['Error']} #{row['Cause']} #{row['Resolution']}"
      end

      def find_postcode(country, search_term)
        JSON.parse(self.class.get('/Capture/Interactive/Find/v1.00/json.ws', lookup_parameters(country, search_term)).body)
      end

      def lookup_parameters(country, search_term)
        {
          query: {
            Key: KEY,
            Countries: country,
            Text: search_term
          }
        }
      end
    end
  end
end
