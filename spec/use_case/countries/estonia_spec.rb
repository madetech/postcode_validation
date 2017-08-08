describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Estonia' do
    let(:potential_address_matches) { [] }
    let(:country) { 'EE' }

    valid_postcode_test(postcode: '74401')
    invalid_postcode_test('is in the wrong format', postcode: 'B4401')
    invalid_postcode_test('is too short', postcode: '7440')
    invalid_postcode_test('is too long', postcode: '744011')
  end
end
