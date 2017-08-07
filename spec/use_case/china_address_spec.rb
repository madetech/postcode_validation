describe PostcodeValidation::UseCase::ValidateAddress do
  let(:address_match_gateway) do
    double(query: potential_address_matches)
  end
  subject do
    described_class.new(address_match_gateway: address_match_gateway)
      .execute(postcode: postcode, country: country)
  end

  context 'given the country is China' do
    let(:potential_address_matches) { [] }
    let(:country) { 'CN' }

    context 'and the postcode format is valid' do
      let(:text) { '1928' }
      let(:postcode) { '1928' }

      it { expect(subject[:valid?]).to be_truthy }
    end

    context 'and the postcode format is valid' do
      let(:text) { '101928' }
      let(:postcode) { '101928' }

      it { expect(subject[:valid?]).to be_truthy }
    end

    context 'and the postcode is not valid' do
      context 'postcode format is not a number' do
        let(:text) { 'abcdf' }
        let(:postcode) { 'abcdf' }

        it { expect(subject[:valid?]).to be_falsey }
      end

      context 'postcode format is too short' do
        let(:text) { '123' }
        let(:postcode) { '123' }

        it { expect(subject[:valid?]).to be_falsey }
      end

      context 'postcode format is five digits long' do
        let(:text) { '12312' }
        let(:postcode) { '12312' }

        it { expect(subject[:valid?]).to be_falsey }
      end

      context 'postcode format is too long' do
        let(:text) { '123456789' }
        let(:postcode) { '123456789' }

        it { expect(subject[:valid?]).to be_falsey }
      end
    end
  end
end
