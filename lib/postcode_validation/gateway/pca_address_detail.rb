module PostcodeValidation
  module Gateway
    class PCAAddressDetail
      include HTTParty

      class PCARequestError < PostcodeValidation::Error::RequestError; end

      KEY = ENV['POSTCODE_ANYWHERE_KEY']
      base_uri 'https://services.postcodeanywhere.co.uk'

      def find(id:)
        PostcodeValidation::Domain::AddressDetail.new(result: address(id))
      end

      private

      def error_message(row)
        "#{row['Error']} #{row['Cause']} #{row['Resolution']}"
      end

      def address(id)
        JSON.parse(
          self.class.get(
            '/Capture/Interactive/Retrieve/1.00/json.ws',
            {
              query: {
                Id: id,
                Key: KEY
              }
            }
          ).body
        ).first
      end
    end
  end
end
