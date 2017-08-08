describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Switzerland' do
    let(:potential_address_matches) { [] }
    let(:country) { 'CH' }

    valid_postcode_test(postcode: '3436')
    invalid_postcode_test('is in the wrong format', postcode: 'BB38')
    invalid_postcode_test('is in the wrong format', postcode: '3BBB')
    invalid_postcode_test('is too short', postcode: '343')
    invalid_postcode_test('is too long', postcode: '34366')
  end
end
