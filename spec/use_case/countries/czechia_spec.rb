describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Czechia' do
    let(:potential_address_matches) { [] }
    let(:country) { 'CZ' }

    valid_postcode_test(postcode: '160 00')
    valid_postcode_test(postcode: '16000')
    invalid_postcode_test('is in the wrong format', postcode: '16-000')
    invalid_postcode_test('is too short', postcode: '16 00')
    invalid_postcode_test('is too long', postcode: '160 000')
  end
end
