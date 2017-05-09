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
      'Text' => '136 Southwark Street - 46 Adresses',
      'Description' => 'MadeTech',
      'Type' => 'Postcode',
      'Id' => 'SomeId'
    }

    let(:address_list_response) { [PostcodeValidation::Domain::Address.new(row: row)] }
    let(:postcode) { 'SE10SW' }
    let(:country) { 'GB' }

    it 'returns a list of addresses' do
      expect(subject.first[:street_address]).to eq('136 Southwark Street - 46 Adresses, MadeTech')
    end
  end
end
