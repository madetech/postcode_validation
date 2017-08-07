describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Austria' do
    let(:potential_address_matches) { [] }
    let(:country) { 'AT' }

    valid_postcode_test(postcode: '2491')
    invalid_postcode_test('is in the wrong format', postcode: 'B491')
    invalid_postcode_test('is too short', postcode: '249')
    invalid_postcode_test('is too long', postcode: '24912')
  end
end
