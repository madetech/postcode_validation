describe PostcodeValidation::Gateway::PCAAddressList do
  context 'GB' do
    it 'returns the Id for retrieving address details' do
      VCR.use_cassette('PCA-address-list-gb') do
        subject = described_class.new.query(
          search_term: 'SE15HG',
          country: 'GB'
        )

        expect(subject[0].id).to eq('GB|RM|A|21456992')
        expect(subject[0].label).to eq('Tesco Stores Ltd, 107 Dunton Road, London, SE1 5HG')
      end
    end
  end
end
