describe PostcodeValidation::Gateway::PCAAddressList do

  context do
    let(:search_term) { 'SE1 0SW' }
    let(:country) { 'GB' }

    it do
      VCR.use_cassette('PCA-address-list') do
        subject = described_class.new.query(search_term: search_term, country: country)

        expect(subject.first.street_address).to eq('A J Wealth Management Ltd')
        expect(subject.first.place).to eq('138-140 Southwark Street London SE1')
      end
    end
  end
end
