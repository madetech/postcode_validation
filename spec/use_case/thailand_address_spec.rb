describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) do
    double(query: potential_address_matches)
  end

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Thailand' do
    let(:potential_address_matches) { [] }
    let(:country) { 'TH' }

    context 'and the postcode format is valid' do
      let(:text) { '57250' }
      let(:postcode) { '57250' }

      it { expect(subject[:valid?]).to be_truthy }
    end

    context 'and the postcode format is valid' do
      let(:text) { '20170' }
      let(:postcode) { '20170' }

      it { expect(subject[:valid?]).to be_truthy }
    end

    context 'and the postcode is not valid' do
      context 'postcode format is not a number' do
        let(:text) { 'abcdef' }
        let(:postcode) { 'abcdef' }

        it { expect(subject[:valid?]).to be_falsey }
      end

      context 'postcode format is too short' do
        let(:text) { '1234' }
        let(:postcode) { '1234' }

        it { expect(subject[:valid?]).to be_falsey }
      end

      context 'postcode format is too long' do
        let(:text) { '123454' }
        let(:postcode) { '123454' }

        it { expect(subject[:valid?]).to be_falsey }
      end
    end
  end
end
