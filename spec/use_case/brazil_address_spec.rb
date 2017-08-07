describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) do
    double(query: potential_address_matches)
  end

  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is Brazil' do
    let(:potential_address_matches) { [] }
    let(:country) { 'BR' }

    context 'and the postcode format is valid' do
      let(:text) { '03999' }
      let(:postcode) { '03999' }

      it { expect(subject[:valid?]).to be_truthy }
    end

    context 'and the postcode format is valid' do
      let(:text) { '28999-273' }
      let(:postcode) { '28999-273' }

      it { expect(subject[:valid?]).to be_truthy }
    end

    context 'and the postcode is not valid' do
      context 'postcode format is not a number' do
        let(:text) { 'abcdf' }
        let(:postcode) { 'abcdf' }

        it { expect(subject[:valid?]).to be_falsey }
      end

      context 'postcode format is too short' do
        let(:text) { '1234' }
        let(:postcode) { '1234' }

        it { expect(subject[:valid?]).to be_falsey }
      end

      context 'postcode format is too long' do
        let(:text) { '1234543' }
        let(:postcode) { '1234543' }

        it { expect(subject[:valid?]).to be_falsey }
      end
    end
  end
end
