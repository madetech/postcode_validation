describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Morocco' do
    let(:potential_address_matches) { [] }
    let(:country) { 'MA' }

    valid_postcode_test(postcode: '80 000')
    valid_postcode_test(postcode: '85200')
    invalid_postcode_test('is too short', postcode: '1234')
    invalid_postcode_test('is too long', postcode: '123456')
  end
end
