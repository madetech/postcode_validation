describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Latvia' do
    let(:potential_address_matches) { [] }
    let(:country) { 'LV' }

    valid_postcode_test(postcode: 'LV1234')
    invalid_postcode_test('is in the wrong format', postcode: '1234LV')
    invalid_postcode_test('is too short', postcode: '123456')
    invalid_postcode_test('is too long', postcode: 'LVV123')
  end
end
