module PostcodeValidation
  module Domain
    class AddressDetail
      def initialize(result:)
        @result = result
      end

      def company
        result['Company']
      end

      def address_line_1
        result['Line1']
      end

      def address_line_2
        result['Line2']
      end

      def city
        result['City']
      end

      def country
        result['CountryName']
      end

      private

      attr_reader :result
    end
  end
end
