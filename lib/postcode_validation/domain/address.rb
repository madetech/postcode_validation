module PostcodeValidation
  module Domain
    class Address
      def initialize(row:)
        @row = row
      end

      def street_address
        "#{row['Text']}, #{row['Description']}"
      end

      def more_results_id
        row['Id'] if more_results_available?
      end

      private

      attr_reader :row

      def more_results_available?
        row['Type'] == 'Postcode'
      end
    end
  end
end
