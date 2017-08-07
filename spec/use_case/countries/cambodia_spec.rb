describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Cambodia' do
    let(:potential_address_matches) { [] }
    let(:country) { 'KH' }

    valid_postcode_test(postcode: '12101')
    invalid_postcode_test('is in the wrong format', postcode: 'B2101')
    invalid_postcode_test('is too short', postcode: '1210')
    invalid_postcode_test('is too long', postcode: '121011')
  end
end
