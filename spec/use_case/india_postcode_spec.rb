describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) do
    double(query: potential_address_matches)
  end

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is India' do
    let(:potential_address_matches) { [] }
    let(:country) { 'IN' }

    context 'and the postcode format is valid' do
      let(:text) { '612804' }
      let(:postcode) { '612804' }

      it { expect(subject[:valid?]).to be_truthy }
    end

    context 'and the postcode format is valid' do
      let(:text) { '110002' }
      let(:postcode) { '110002' }

      it { expect(subject[:valid?]).to be_truthy }
    end

    context 'and the postcode format is not valid' do
      context 'postcode format is not a number' do
        let(:text) { 'abcdef' }
        let(:postcode) { 'abcdef' }

        it { expect(subject[:valid?]).to be_falsey }
      end

      context 'postcode format is too short' do
        let(:text) { '23885' }
        let(:postcode) { '23885' }

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
