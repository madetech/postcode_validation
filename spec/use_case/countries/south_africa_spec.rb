describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is South Africa' do
    let(:potential_address_matches) { [] }
    let(:country) { 'ZA' }

    valid_postcode_test(postcode: '0699')
    invalid_postcode_test('is in the wrong format', postcode: 'Z699')
    invalid_postcode_test('is too short', postcode: '699')
    invalid_postcode_test('is too long', postcode: '06990')
  end
end
