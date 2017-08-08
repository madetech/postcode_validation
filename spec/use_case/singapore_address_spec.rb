describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) do
    double(query: potential_address_matches)
  end

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Singapore' do
    let(:potential_address_matches) { [] }
    let(:country) { 'SG' }

    context 'and the postcode format is valid' do
      let(:text) { '238858' }
      let(:postcode) { '238858' }

      it { expect(subject[:valid?]).to be_truthy }
    end

    context 'and the postcode format is valid' do
      let(:text) { '236658' }
      let(:postcode) { '238668' }

      it { expect(subject[:valid?]).to be_truthy }
    end

    context 'and the postcode format is not valid' do
      context 'postcode format is not a number' do
        let(:text) { 'abcdef' }
        let(:postcode) { 'abcdef' }

        it { expect(subject[:valid?]).to be_falsey }
      end

      context 'postcode format is too short' do
        let(:text) { '23665' }
        let(:postcode) { '23665' }

        it { expect(subject[:valid?]).to be_falsey }
      end

      context 'postcode format is too long' do
        let(:text) { '2366534' }
        let(:postcode) { '2366534' }

        it { expect(subject[:valid?]).to be_falsey }
      end
    end
  end
end
