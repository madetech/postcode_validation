describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Brunei' do
    let(:potential_address_matches) { [] }
    let(:country) { 'BN' }

    valid_postcode_test(postcode: 'BE3119')
    invalid_postcode_test('is in the wrong format', postcode: 'B33119')
    invalid_postcode_test('is in the wrong format', postcode: 'BEE119')
    invalid_postcode_test('is too short', postcode: 'BE311')
    invalid_postcode_test('is too long', postcode: 'BE31199')
  end
end
