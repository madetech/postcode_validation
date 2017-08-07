describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Laos' do
    let(:potential_address_matches) { [] }
    let(:country) { 'LA' }

    valid_postcode_test(postcode: '17000')
    invalid_postcode_test('is not a number', postcode: 'abcde')
    invalid_postcode_test('is too short', postcode: '1700')
    invalid_postcode_test('is too long', postcode: '170001')
  end
end
