describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Ukraine' do
    let(:potential_address_matches) { [] }
    let(:country) { 'UA' }

    valid_postcode_test(postcode: '65029')
    valid_postcode_test(postcode: '65000')
    invalid_postcode_test('is in the wrong format', postcode: 'B5029')
    invalid_postcode_test('is in the wrong format', postcode: '6500B')
    invalid_postcode_test('is too short', postcode: '6500')
    invalid_postcode_test('is too long', postcode: '650290')
  end
end
