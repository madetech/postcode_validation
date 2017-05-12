describe PostcodeValidation::Gateway::PCAAddressDetail do
  context 'GB' do
    it 'returns the final results' do
      VCR.use_cassette('PCA-address-detail-gb') do
        subject = described_class.new.find(id: 'GB|RM|A|8224138')

        expect(subject.address_line_1).to eq('755/2 Ferry Road')
        expect(subject.address_line_2).to eq('')
        expect(subject.city).to eq('Edinburgh')
        expect(subject.country).to eq('United Kingdom')
      end
    end
  end
end
