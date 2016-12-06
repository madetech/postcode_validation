describe PostcodeValidation::Gateway::PCAPotentialAddressMatch do
  subject do
    described_class.new.query(search_term: search_term, country: country)
  end

  context do
    let(:search_term) { 'SE1 0SW' }
    let(:country) { 'GB' }

    it do
      VCR.use_cassette('PCA-address-matching') do
        expect(subject.first.text).to eq('SE1 0SW')
      end
    end
  end

  context 'when the request country is invalid' do
    let(:search_term) { 'SE1 0SW' }
    let(:country) { 'UK' }

    it do
      VCR.use_cassette('PCA-address-invalid-request') do
        expect { subject }.to raise_error(described_class::PCARequestError)
      end
    end
  end
end
