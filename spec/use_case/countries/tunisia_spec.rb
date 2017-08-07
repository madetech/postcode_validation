describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Tunisia' do
    let(:potential_address_matches) { [] }
    let(:country) { 'TN' }

    valid_postcode_test(postcode: '2011')
    invalid_postcode_test('is in the wrong format', postcode: 'BB20')
    invalid_postcode_test('is in the wrong format', postcode: '20BB')
    invalid_postcode_test('is too short', postcode: '201')
    invalid_postcode_test('is too long', postcode: '20122')
  end
end
