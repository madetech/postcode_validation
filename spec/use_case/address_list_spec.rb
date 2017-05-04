describe PostcodeValidation::UseCase::AddressList do
  let(:address_list_gateway) do
    double(query: address_list_response)
  end

  subject do
    described_class.new(address_list_gateway: address_list_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given a valid postcode and country' do
    let(:address_list_response) { [PostcodeValidation::Domain::Address.new(street_address: 'Southwark Street')] }
    let(:postcode) { 'SE10SW' }
    let(:country) { 'GB' }
    it 'returns a list of addresses' do
      expect(subject.first[:street_address]).to eq('Southwark Street')
    end
  end
end
