describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Russia' do
    let(:potential_address_matches) { [] }
    let(:country) { 'RU' }

    valid_postcode_test(postcode: '191028')
    invalid_postcode_test('is in the wrong format', postcode: 'B19102')
    invalid_postcode_test('is too short', postcode: '19102')
    invalid_postcode_test('is too long', postcode: '1910281')
  end
end
