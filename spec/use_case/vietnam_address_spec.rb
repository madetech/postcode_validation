describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) do
    double(query: potential_address_matches)
  end

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Vietnam' do
    let(:potential_address_matches) { [] }
    let(:country) { 'VN' }

    context 'and the postcode format is valid' do
      let(:text) { '882983' }
      let(:postcode) { '882983' }

      it { expect(subject[:valid?]).to be_truthy }
    end

    context 'and the postcode format is valid' do
      let(:text) { '238495' }
      let(:postcode) { '238495' }

      it { expect(subject[:valid?]).to be_truthy }
    end

    context 'and the postcode is not valid' do
      context 'postcode format is not a number' do
        let(:text) { 'abcdef' }
        let(:postcode) { 'abcdef' }

        it { expect(subject[:valid?]).to be_falsey }
      end

      context 'postcode format is too short' do
        let(:text) { '12345' }
        let(:postcode) { '12345' }

        it { expect(subject[:valid?]).to be_falsey }
      end

      context 'postcode format is too long' do
        let(:text) { '1234534' }
        let(:postcode) { '1234534' }

        it { expect(subject[:valid?]).to be_falsey }
      end
    end
  end
end
