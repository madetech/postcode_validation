module PostcodeValidation
  module Domain
    class AddressDetail
      def initialize(row:)
        @row = row
      end

      def address_line_1
        "https://services.postcodeanywhere.co.uk/Capture/Interactive/Retrieve/1.00/json.ws?Id=#{row['Id']}&Key=#{key}"
      end

      def company
        row['Company']
      end

      def address_line_1
        row['Line1']
      end

      def address_line_2
        row['Line2']
      end

      def city
        row['City']
      end

      def country
        row['CountryName']
      end

      private

      attr_reader :row
    end
  end
end
