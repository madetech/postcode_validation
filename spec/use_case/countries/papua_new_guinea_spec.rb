describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Papua New Guinea' do
    let(:potential_address_matches) { [] }
    let(:country) { 'PG' }

    valid_postcode_test(postcode: '633')
    invalid_postcode_test('is in the wrong format', postcode: 'B33')
    invalid_postcode_test('is in the wrong format', postcode: 'BBB')
    invalid_postcode_test('is too short', postcode: '63')
    invalid_postcode_test('is too long', postcode: '6333')
  end
end
