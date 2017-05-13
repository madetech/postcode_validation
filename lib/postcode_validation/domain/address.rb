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

      def url
        "https://services.postcodeanywhere.co.uk/Capture/Interactive/Retrieve/1.00/json.ws?Id=#{row['Id']}&Key=#{key}"
      end

      private

      attr_reader :row, :key
    end
  end
end
