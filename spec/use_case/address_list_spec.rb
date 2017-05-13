describe PostcodeValidation::UseCase::AddressList do
  let(:address_list_gateway) do
    double(query: address_list_response)
  end

  subject do
    described_class.new(address_list_gateway: address_list_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given a valid postcode and country' do
    row = {
      'Text' => 'Tesco Stores Ltd, 107 Dunton Road',
      'Description' => 'London, SE1 5HG',
      'Type' => 'Postcode',
      'Id' => 'SomeId'
    }

    let(:address_list_response) { [PostcodeValidation::Domain::Address.new(row: row, key: 'some_key')] }
    let(:postcode) { 'SE10SW' }
    let(:country) { 'GB' }

    it 'returns a list of addresses' do
      expect(subject.first[:id]).to eq('SomeId')
      expect(subject.first[:label]).to eq('Tesco Stores Ltd, 107 Dunton Road, London, SE1 5HG')
    end
  end
end
