require_relative 'validate_address/format_validator'

module PostcodeValidation
  module UseCase
    class AddressDetailRetriever
      def initialize(address_detail_retriever_gateway:, logger: nil)
        @address_detail_retriever_gateway = address_detail_retriever_gateway
        @logger = logger
      end

      def execute(id:)
        address = find_address(id)

        formatted(address)
      rescue PostcodeValidation::Error::RequestError => e
        log_error(e)
      end

      private

      attr_reader :address_detail_retriever_gateway, :logger

      def formatted(address)
        {
          address_line_1: address.address_line_1,
          address_line_2: address.address_line_2,
          company: address.company,
          city: address.city,
          country: address.country
        }
      end

      def log_error(e)
        logger.error(e) unless logger.nil?
      end

      def find_address(id)
        @address_detail_retriever_gateway.find(id: id)
      end
    end
  end
end
