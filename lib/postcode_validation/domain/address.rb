module PostcodeValidation
  module Domain
    class Address
      def initialize(street_address:)
        @street_address = street_address
      end

      attr_reader :street_address
    end
  end
end
