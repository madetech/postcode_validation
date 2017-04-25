describe PostcodeValidation::UseCase::AddressList do
  let(:address_list_gateway) do
    double(query: address_list_response)
  end
  subject do
    described_class.new(address_list_gateway: address_list_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given a valid postcode and country' do
    let(:address_list_response) { [{'StreetAddress': 'Southwark Street', 'Place': '136'}] }
    let(:postcode) { 'SE10SW' }
    let(:country) { 'GB' }
    it 'returns a list of addresses' do
      expected_result = [PostcodeValidation::Domain::Address.new(street_address: 'Southwark Street', place: '136')]
      expect(expected_result.first.street_address).to eq('Southwark Street')
      expect(expected_result.first.place).to eq('136')
    end
  end
end
