describe PostcodeValidation::Gateway::PCAAddressList do
  context 'Address list without further lookups' do
    context 'GB' do
      it 'returns the final results' do
        VCR.use_cassette('PCA-address-list-gb') do
          subject = described_class.new.query(
            search_term: 'SE15HG',
            country: 'GB'
          )

          expect(subject[0].street_address).to eq('Tesco Stores Ltd, 107 Dunton Road, London, SE1 5HG')
        end
      end
    end

    context 'FR' do
      it 'returns the final results' do
        VCR.use_cassette('PCA-address-list-fr') do
          subject = described_class.new.query(
            search_term: '7552',
            country: 'FR'
          )

          expect(subject[0].street_address).to eq('7552 Route des Clues, 06440 Peille')
        end
      end
    end
  end

  context 'Multiple addresses for a postcode' do
    context 'GB' do
      it 'finds a result that needs an additional lookup' do
        VCR.use_cassette('PCA-postcode-result-gb') do
          subject = described_class.new.query(
            search_term: 'SE1 0SW',
            country: 'GB'
          )

          expect(subject[0].street_address).to eq('Abbott Mead Vickers Group Ltd, 90 Southwark Street, London, SE1 0SW')
        end
      end
    end

    context 'FR' do
      it 'finds a result that needs an additional lookup' do
        VCR.use_cassette('PCA-postcode-result-fr') do
          subject = described_class.new.query(
            search_term: '75020',
            country: 'FR'
          )

          expect(subject[0].street_address).to eq('52 Avenue Gambetta, 20e Arrondissement Paris, 75020 Paris')
        end
      end
    end
  end

  context 'Address lookup given the ID of a previous result' do
    context 'GB' do
      it 'returns an address list using a previous result ID' do
        VCR.use_cassette('PCA-address-list-by-id-gb') do
          subject = described_class.new.query(
            search_term: 'SE1 0SW',
            country: 'GB',
            more_results_id: 'GB|RM|ENG|0SW-SE1'
          )

          expect(subject[0].street_address).to eq('Abbott Mead Vickers Group Ltd, 90 Southwark Street, London, SE1 0SW')
          expect(subject[1].street_address).to eq('Code Worldwide Ltd, 90 Southwark Street, London, SE1 0SW')
        end
      end
    end

    context 'FR' do
      it 'returns an address list using a previous result ID' do
        VCR.use_cassette('PCA-address-list-by-id-fr') do
          subject = described_class.new.query(
            search_term: '75020',
            country: 'FR',
            more_results_id: 'FR|TT|FRE|75020'
          )

          expect(subject[0].street_address).to eq('52 Avenue Gambetta, 20e Arrondissement Paris, 75020 Paris')
        end
      end
    end
  end
end
