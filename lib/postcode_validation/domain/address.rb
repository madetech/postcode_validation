module PostcodeValidation
  module Domain
    class Address
      def initialize(row:)
        @row = row
      end

      def street_address
        "#{row['Text']}, #{row['Description']}"
      end

      private

      attr_reader :row
    end
  end
end
