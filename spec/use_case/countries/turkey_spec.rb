describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Turkey' do
    let(:potential_address_matches) { [] }
    let(:country) { 'TR' }

    valid_postcode_test(postcode: '20590')
    invalid_postcode_test('is in the wrong format', postcode: 'B0490')
    invalid_postcode_test('is in the wrong format', postcode: '2059B')
    invalid_postcode_test('is too short', postcode: '2059')
    invalid_postcode_test('is too long', postcode: '205902')
  end
end
