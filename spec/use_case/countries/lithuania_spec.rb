describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Lithuania' do
    let(:potential_address_matches) { [] }
    let(:country) { 'LT' }

    valid_postcode_test(postcode: 'LT12345')
    valid_postcode_test(postcode: 'LT-12345')
    invalid_postcode_test('is in the wrong format', postcode: '1234-LT')
    invalid_postcode_test('is too short', postcode: 'LT-1234')
    invalid_postcode_test('is too long', postcode: 'LT-123456')
  end
end
