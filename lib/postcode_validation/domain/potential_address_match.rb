module PostcodeValidation
  module Domain
    class PotentialAddressMatch
      def initialize(text:)
        @text = text
      end

      def postcode_matches?(postcode)
        letters_and_numbers_only(text).include?(letters_and_numbers_only(postcode))
      end

      attr_reader :text

      private

      def letters_and_numbers_only(postcode)
        postcode.gsub(/[^0-9a-zA-Z]/, '')
      end
    end
  end
end
