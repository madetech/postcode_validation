describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) do
    double(query: potential_address_matches)
  end

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Hungary' do
    let(:potential_address_matches) { [] }
    let(:country) { 'HU' }

    context 'and the postcode format is valid' do
      let(:text) { '6128' }
      let(:postcode) { '6128' }

      it { expect(subject[:valid?]).to be_truthy }
    end

    context 'and the postcode format is valid' do
      let(:text) { '1100' }
      let(:postcode) { '1100' }

      it { expect(subject[:valid?]).to be_truthy }
    end

    context 'and the postcode format is not valid' do
      context 'postcode format is not a number' do
        let(:text) { 'abcdef' }
        let(:postcode) { 'abcdef' }

        it { expect(subject[:valid?]).to be_falsey }
      end

      context 'postcode format is too short' do
        let(:text) { '238' }
        let(:postcode) { '238' }

        it { expect(subject[:valid?]).to be_falsey }
      end

      context 'postcode format is too long' do
        let(:text) { '2388532' }
        let(:postcode) { '2388532' }

        it { expect(subject[:valid?]).to be_falsey }
      end
    end
  end
end
