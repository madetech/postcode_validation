module PostcodeValidation
  module Gateway
    class PCAAddressList
      include HTTParty

      class PCARequestError < PostcodeValidation::Error::RequestError; end

      KEY = ENV['POSTCODE_ANYWHERE_KEY']
      base_uri 'https://services.postcodeanywhere.co.uk'

      def query(search_term:, country:)
        address_list_for_postcode(country, search_term).map do |row|
          raise PCARequestError, error_message(row) if row.key?('Error')

          address_payload(row, country, search_term)
        end.compact.flatten
      end

      private

      def address_payload(row, country, search_term)
        if row['Type'] == 'Address'
          PostcodeValidation::Domain::Address.new(
            street_address: row['Description'],
            place: row['Text']
          )
        elsif row['Type'] == 'Postcode'
          PostcodeValidation::Gateway::PCAPostcodeToAddresses.new(
            search_term: search_term,
            country: country
          ).execute
        end
      end

      def error_message(row)
        "#{row['Error']} #{row['Cause']} #{row['Resolution']}"
      end

      def address_list_for_postcode(country, search_term)
        JSON.parse(self.class.get('/Capture/Interactive/Find/1.0/json.ws', lookup_parameters(country, search_term)).body)
      end

      def lookup_parameters(country, search_term)
        {
          query: {
            Countries: country,
            Key: KEY,
            Text: search_term
          }
        }
      end
    end
  end
end
