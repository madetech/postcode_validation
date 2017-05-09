describe PostcodeValidation::Gateway::PCAAddressList do

  context do
    it 'Searches locally with a postcode that has multiple hits' do
      search_term = 'SE1 0SW'
      country = 'GB'

      VCR.use_cassette('PCA-address-list') do
        subject = described_class.new.query(search_term: search_term, country: country)

        expect(subject[0].street_address).to eq('SE1 0SW, Southwark Street, London - 46 Addresses')
        expect(subject[0].more_results_id).to eq('GB|RM|ENG|0SW-SE1')
      end
    end

    it 'Searches locally' do
      search_term = 'SE1 0SW'
      country = 'GB'

      VCR.use_cassette('PCA-address-list-by-id') do
        subject = described_class.new.query(search_term: search_term, country: country, more_results_id: 'GB|RM|ENG|0SW-SE1')

        expect(subject[0].street_address).to eq('Abbott Mead Vickers Group Ltd, 90 Southwark Street, London, SE1 0SW')
        expect(subject[1].street_address).to eq('Code Worldwide Ltd, 90 Southwark Street, London, SE1 0SW')
        expect(subject[0].more_results_id).to eq(nil)
      end
    end

    it 'Searches internationally' do
      VCR.use_cassette('PCA-address-list-international') do
        search_term = '7552'
        country = 'FR'

        subject = described_class.new.query(search_term: search_term, country: country)

        expect(subject[0].street_address).to eq('7552 Route des Clues, 06440 Peille')
        expect(subject[0].more_results_id).to eq(nil)
      end
    end

    it 'Searches internationally' do
      VCR.use_cassette('PCA-address-list-international-id') do
        search_term = '75020'
        country = 'FR'

        subject = described_class.new.query(search_term: search_term, country: country)

        expect(subject[0].street_address).to eq('75020, Paris - 95967 Addresses')
        expect(subject[0].more_results_id).to eq('FR|TT|FRE|75020')
      end
    end

    it 'Searches internationally' do
      VCR.use_cassette('PCA-address-list-international-id-2') do
        search_term = '75020'
        country = 'FR'

        subject = described_class.new.query(search_term: search_term, country: country, more_results_id: 'FR|TT|FRE|75020')

        expect(subject[0].street_address).to eq('52 Avenue Gambetta, 20e Arrondissement Paris, 75020 Paris')
        expect(subject[0].more_results_id).to eq(nil)
      end
    end
  end
end
