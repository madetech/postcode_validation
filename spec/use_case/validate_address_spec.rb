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
    let(:potential_address_matches) do
      [PostcodeValidation::Domain::PotentialAddressMatch.new(text: text,
                                                             description: '')]
    end

    context 'and the country is NL' do
      let(:country) { 'NL' }

      context 'when the postcode matches' do
        let(:text) { '6423 ZA' }
        let(:postcode) { '6423ZA' }
        it { expect(subject[:valid?]).to be_truthy }
        it { expect(subject[:reason]).to eq(['valid_postcode']) }
      end
      context 'when the postcode contains formatting differences' do
        let(:text) { '6423 ZA' }
        let(:postcode) { '6423 ZA' }
        it { expect(subject[:valid?]).to be_truthy }
      end
      context 'when there are extreme formatting differences in the postcode' do
        let(:text) { '6423 ZA' }
        let(:postcode) { '6423-Z A ' }
        it { expect(subject[:valid?]).to be_falsey }
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

    context 'and the country bypasses local REGEX validation' do
      let(:country) { 'SOME_UNSUPPORTED_COUNTRY_CODE' }

      let(:postcode) { '123' }
      let(:text) { '123' }
      it { expect(subject[:valid?]).to be_truthy }
    end
  end

  context 'given two matches and the first is not exact' do
    let(:potential_address_matches) do
      [
        PostcodeValidation::Domain::PotentialAddressMatch.new(text: 'N10, Danesgate House, 49 Clasketgate',
                                                              description: '5 Addresses'),
        PostcodeValidation::Domain::PotentialAddressMatch.new(text: 'N1 0ED',
                                                              description: '10 Addresses')
      ]
    end
    let(:postcode) { 'N1 0ED' }
    let(:country) { 'GB' }
    it { expect(subject[:valid?]).to be_truthy }
    context 'and the postcode is lowercase' do
      let(:postcode) { 'n1 0ed' }
      it { expect(subject[:valid?]).to be_truthy }
    end
  end

  context 'given two matches with the postcode contained the description field' do
    let(:potential_address_matches) do
      [
        PostcodeValidation::Domain::PotentialAddressMatch.new(text: 'Welgelegenstraat',
                                                              description: '2012JC Haarlem - 13 Addresses'),
        PostcodeValidation::Domain::PotentialAddressMatch.new(text: 'Spijkermanslaan',
                                                              description: '2012CJ Haarlem - 39 Addresses')
      ]
    end
    let(:postcode) { '2012 JC' }
    let(:country) { 'NL' }
    it { expect(subject[:valid?]).to be_truthy }
  end

  context 'given an invalid postcode format' do
    let(:potential_address_matches) do
      [PostcodeValidation::Domain::PotentialAddressMatch.new(text: text,
                                                             description: '')]
    end
    context 'and the country is NL' do
      let(:country) { 'NL' }
      let(:text) { '3584 EG' }
      let(:postcode) { '3584 E' }
      it { expect(subject[:valid?]).to be_falsey }

      it 'returns a message saying the format is invalid' do
        expect(subject[:reason]).to eq(['invalid_format'])
      end
    end

    context 'and the country is UK' do
      let(:country) { 'GB' }
      let(:text) { 'SE10SW' }
      let(:postcode) { 'SE10-SW' }
      it { expect(subject[:valid?]).to be_falsey }
    end

    context 'and the country is FR' do
      let(:country) { 'FR' }
      let(:text) { 'F-12345' }
      let(:postcode) { 'F-12345Y' }
      it { expect(subject[:valid?]).to be_falsey }
    end

    context 'and the country is BE' do
      let(:country) { 'BE' }
      let(:text) { '1234' }
      let(:postcode) { '123A' }
      it { expect(subject[:valid?]).to be_falsey }
    end
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

  context 'when no country is provided' do
    let(:potential_address_matches) { [] }
    let(:postcode) { '3584 EG' }
    let(:country) { nil }
    it { expect(subject[:valid?]).to be_falsey }
    it { expect(subject[:reason]).to include('no_country_provided') }
  end
end
