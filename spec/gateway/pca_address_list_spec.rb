describe PostcodeValidation::Gateway::PCAAddressList do
  context 'Address list without further lookups' do
    context 'GB' do
      it 'returns the final results' do
        VCR.use_cassette('PCA-address-list-gb') do
          subject = described_class.new.query(
            search_term: 'SE15HG',
            country: 'GB'
          )

          expect(subject[0].url).to eq('https://services.postcodeanywhere.co.uk/Capture/Interactive/Retrieve/1.00/json.ws?Id=GB|RM|A|21456992&Key=FAKEKEY')
        end
      end
    end
  end
end
