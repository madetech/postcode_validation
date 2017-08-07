describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Poland' do
    let(:potential_address_matches) { [] }
    let(:country) { 'PL' }

    valid_postcode_test(postcode: '41-300')
    invalid_postcode_test('is in the wrong format', postcode: '41300')
    invalid_postcode_test('is in the wrong format', postcode: '41--300')
    invalid_postcode_test('is too short', postcode: '4-300')
    invalid_postcode_test('is too long', postcode: '413-3001')
  end
end
