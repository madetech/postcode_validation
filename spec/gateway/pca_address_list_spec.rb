describe PostcodeValidation::Gateway::PCAAddressList do

  context do
    it 'Searches locally' do
      search_term = 'SE1 0SW'
      country = 'GB'

      VCR.use_cassette('PCA-address-list') do
        subject = described_class.new.query(search_term: search_term, country: country)

        expect(
          subject[0].street_address
        ).to eq(
          'A J Wealth Management Ltd, 138-140 Southwark Street London SE1'
        )

        expect(
          subject[1].street_address
        ).to eq(
          'Abbott Mead Vickers Group Ltd, 90 Southwark Street London SE1'
        )
      end
    end

    it 'Searches internationally' do
      search_term = 'CA90210'
      country = 'US'

      VCR.use_cassette('PCA-address-list-international') do
        subject = described_class.new.query(search_term: search_term, country: country)

        expect(subject[0].street_address).to eq('2390 W Pico Blvd Unit 90210, Los Angeles CA 90006')
        expect(subject[1].street_address).to eq('7435 N Figueroa St Unit 90210, Los Angeles CA 90041')
      end
    end
  end
end
