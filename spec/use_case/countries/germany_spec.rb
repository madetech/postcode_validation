describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Germany' do
    let(:potential_address_matches) { [] }
    let(:country) { 'DE' }

    valid_postcode_test(postcode: '10439')
    invalid_postcode_test('is in the wrong format', postcode: 'C0439')
    invalid_postcode_test('is too short', postcode: '1043')
    invalid_postcode_test('is too long', postcode: '104390')
  end
end
