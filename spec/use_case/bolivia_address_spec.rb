describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Bolivia' do
    let(:potential_address_matches) { [] }
    let(:country) { 'BO' }

    valid_postcode_test(postcode: '1928')
    invalid_postcode_test('is not a number', postcode: 'abcd')
    invalid_postcode_test('is too short', postcode: '123')
    invalid_postcode_test('is five digits long', postcode: '12312')
    invalid_postcode_test('is too long', postcode: '123456789')
  end
end
