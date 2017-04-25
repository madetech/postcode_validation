module PostcodeValidation
  module Domain
    class Address
      def initialize(street_address:, place:)
        @street_address = street_address
        @place = place
      end

      attr_reader :street_address, :place
    end
  end
end
