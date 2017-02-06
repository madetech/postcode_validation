module PostcodeValidation
  module Domain
    class PotentialAddressMatch
      def initialize(text:, description:)
        @text = text
        @description = description
      end

      def postcode_matches?(postcode)
        normalised_postcode = letters_and_numbers_only(postcode.upcase)

        text_includes?(normalised_postcode) or description_includes?(normalised_postcode)
      end

      attr_reader :text, :description

      private

      def text_includes?(postcode)
        letters_and_numbers_only(text).include?(postcode)
      end

      def description_includes?(postcode)
        letters_and_numbers_only(description).include?(postcode)
      end

      def letters_and_numbers_only(postcode)
        postcode.gsub(/[^0-9a-zA-Z]/, '')
      end
    end
  end
end
