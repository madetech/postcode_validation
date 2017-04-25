module PostcodeValidation
  module Domain
    class Address
      def initialize(address_row)
        @address_row = address_row
      end

      def street_address
        address_row.fetch('StreetAddress')
      end

      def place
        address_row.fetch('Place')
      end

      private

      attr_reader :address_row
    end
  end
end
