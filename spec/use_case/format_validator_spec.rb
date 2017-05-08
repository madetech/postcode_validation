describe PostcodeValidation::UseCase::ValidateAddress::FormatValidator do
  context 'NL' do
    it 'allows lowercase postcodes' do
      country = 'NL'
      postcode = '2271 av'

      expect(described_class.new.for(country).valid?(postcode)).to be true
    end
  end
end
