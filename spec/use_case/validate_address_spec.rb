describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) do
    double(query: potential_address_matches)
  end
  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given no potential address matches' do
    let(:potential_address_matches) { [] }
    let(:postcode) { 'SE10SW' }
    let(:country) { 'GB' }
    it { expect(subject[:valid?]).to be_falsey }
    it do
      subject
      expect(address_match_gateway).to have_received(:query).with(search_term: postcode, country: country)
    end

    context 'and the address match gateway raises error' do
      before { allow(address_match_gateway).to receive(:query).and_raise(PostcodeValidation::Error::RequestError) }
      it 'reports as valid address' do
        expect(subject[:valid?]).to be_truthy
      end
    end
  end

  context 'given one potential address match' do
    let(:potential_address_matches) { [PostcodeValidation::Domain::PotentialAddressMatch.new(text: text)] }

    context 'and the country is NL' do
      let(:country) { 'NL' }

      context 'when the postcode matches' do
        let(:text) { '6423 ZA' }
        let(:postcode) { '6423ZA' }
        it { expect(subject[:valid?]).to be_truthy }
      end
      context 'when the postcode contains formatting differences' do
        let(:text) { '6423 ZA' }
        let(:postcode) { '6423 ZA' }
        it { expect(subject[:valid?]).to be_truthy }
      end
      context 'when there are extreme formatting differences in the postcode' do
        let(:text) { '6423 ZA' }
        let(:postcode) { '6423-Z A ' }
        it { expect(subject[:valid?]).to be_truthy }
      end
    end

    context 'and the country is UK' do
      let(:country) { 'GB' }

      context 'when the postcode matches' do
        let(:text) { 'SE1 0SW' }
        let(:postcode) { 'SE10SW' }
        it { expect(subject[:valid?]).to be_truthy }
      end
    end
  end

  context 'given two matches and the first is not exact' do
    let(:potential_address_matches) do
      [
        PostcodeValidation::Domain::PotentialAddressMatch.new(text: 'N10, Danesgate House, 49 Clasketgate'),
        PostcodeValidation::Domain::PotentialAddressMatch.new(text: 'N1 0ED')
      ]
    end
    let(:postcode) { 'N1 0ED' }
    let(:country) { 'GB' }
    it { expect(subject[:valid?]).to be_truthy }
  end
end
