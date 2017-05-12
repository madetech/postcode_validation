describe PostcodeValidation::Gateway::PCAAddressList do
  context 'Address list without further lookups' do
    context 'GB' do
      it 'returns the final results' do
        VCR.use_cassette('PCA-address-list-gb') do
          subject = described_class.new.query(
            search_term: 'SE15HG',
            country: 'GB'
          )

          expect(subject[0].url).to eq('https://services.postcodeanywhere.co.uk/Capture/Interactive/Retrieve/1.00/json.ws?Id=GB|RM|A|21456992&Key=FAKEKEY')
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

          expect(subject[0].url).to eq('https://services.postcodeanywhere.co.uk/Capture/Interactive/Retrieve/1.00/json.ws?Id=GB|RM|A|53929787&Key=FAKEKEY')
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

          expect(subject[0].url).to eq('https://services.postcodeanywhere.co.uk/Capture/Interactive/Retrieve/1.00/json.ws?Id=FR|TT|A|12500000945356|52&Key=FAKEKEY')
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

          expect(subject[0].url).to eq('https://services.postcodeanywhere.co.uk/Capture/Interactive/Retrieve/1.00/json.ws?Id=GB|RM|A|53929787&Key=FAKEKEY')
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

          expect(subject[0].url).to eq('https://services.postcodeanywhere.co.uk/Capture/Interactive/Retrieve/1.00/json.ws?Id=FR|TT|A|12500000945356|52&Key=FAKEKEY')
        end
      end
    end
  end
end
