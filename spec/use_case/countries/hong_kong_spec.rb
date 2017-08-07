describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) { double(query: potential_address_matches) }

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Hong Kong' do
    let(:potential_address_matches) { [] }
    let(:country) { 'HK' }

    valid_postcode_test(postcode: '12345')
    valid_postcode_test(postcode: 'ABCDE')
    valid_postcode_test(postcode: 'AB123')
    valid_postcode_test(postcode: '123DE')
  end
end
