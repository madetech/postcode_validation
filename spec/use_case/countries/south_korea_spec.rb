describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is South Korea' do
    let(:potential_address_matches) { [] }
    let(:country) { 'KR' }

    valid_postcode_test(postcode: '01033')
    valid_postcode_test(postcode: '18299')
    invalid_postcode_test('is in the wrong format', postcode: '010BB')
    invalid_postcode_test('is in the wrong format', postcode: 'BBB11')
    invalid_postcode_test('is too short', postcode: '0103')
    invalid_postcode_test('is too long', postcode: '182999')
  end
end
