module PostcodeValidation
  module Domain
    class Address
      def initialize(row:, key:)
        @row = row
        @key = key
      end

      def label
        "#{row['Text']}, #{row['Description']}"
      end

      def id
        row['Id']
      end

      private

      attr_reader :row, :key
    end
  end
end
