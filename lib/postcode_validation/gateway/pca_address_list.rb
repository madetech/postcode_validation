module PostcodeValidation
  module Gateway
    class PCAAddressList
      include HTTParty

      class PCARequestError < PostcodeValidation::Error::RequestError; end

      KEY = ENV['POSTCODE_ANYWHERE_KEY']
      base_uri 'https://services.postcodeanywhere.co.uk'

      def query(search_term:, country:, more_results_id: nil)
        address_list_for_postcode(country, search_term, more_results_id).map do |row|
          raise PCARequestError, error_message(row) if row.key?('Error')

          PostcodeValidation::Domain::Address.new(row: row)
        end
      end

      private

      def error_message(row)
        "#{row['Error']} #{row['Cause']} #{row['Resolution']}"
      end

      def address_list_for_postcode(country, search_term, more_results_id)
        JSON.parse(
          self.class.get(
            '/Capture/Interactive/Find/1.00/json.ws',
            lookup_parameters(country, search_term, more_results_id)
          ).body
        )
      end

      def lookup_parameters(country, search_term, more_results_id)
        result = {
          query: {
            Countries: country,
            Key: KEY,
            Text: search_term,
            Limit: 8
          }
        }

        result[:query].merge!(Container: more_results_id) unless more_results_id.nil?
        result
      end
    end
  end
end
