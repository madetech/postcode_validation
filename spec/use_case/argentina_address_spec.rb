describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) do
    double(query: potential_address_matches)
  end

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Argentina' do
    let(:potential_address_matches) { [] }
    let(:country) { 'AR' }

    context 'and the postcode format is valid' do
      let(:postcode) { 'a2399akh' }

      it { expect(subject[:valid?]).to be_truthy }
    end

    context 'and the postcode format is valid' do
      let(:postcode) { 'f9387ppl' }

      it { expect(subject[:valid?]).to be_truthy }
    end

    context 'and the postcode is not valid' do
      context 'postcode format is not a number' do
        let(:postcode) { 'abcdf' }

        it { expect(subject[:valid?]).to be_falsey }
      end

      context 'postcode format is too short' do
        let(:postcode) { 'a1234a' }

        it { expect(subject[:valid?]).to be_falsey }
      end

      context 'postcode format is too long' do
        let(:postcode) { 'abc12345lsk' }

        it { expect(subject[:valid?]).to be_falsey }
      end
    end
  end
end
