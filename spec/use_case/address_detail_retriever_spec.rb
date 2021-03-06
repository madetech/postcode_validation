describe PostcodeValidation::UseCase::AddressDetailRetriever do
  let(:address_detail_retriever_gateway) do
    double(find: address_list_response)
  end

  subject do
    described_class.new(address_detail_retriever_gateway: address_detail_retriever_gateway)
      .execute(id: 'GB|RM|A|8224138')
  end

  context 'given a valid postcode and country' do
    result = {
      'Company' => 'MadeTech',
      'Line1' => '136 Southwark Street',
      'Line2' => 'Southwark',
      'City' => 'London',
      'CountryName' => 'United Kingdom',
      'PostalCode' => 'SE10SW'
    }

    let(:address_list_response) { PostcodeValidation::Domain::AddressDetail.new(result: result) }
    let(:postcode) { 'SE10SW' }
    let(:country) { 'GB' }

    it 'returns a list of addresses' do
      expect(subject[:address_line_1]).to eq('136 Southwark Street')
      expect(subject[:address_line_2]).to eq('Southwark')
      expect(subject[:city]).to eq('London')
      expect(subject[:company]).to eq('MadeTech')
      expect(subject[:country]).to eq('United Kingdom')
      expect(subject[:postcode]).to eq('SE10SW')
    end
  end
end
