module PostcodeTestHelpers
  def valid_postcode_test(postcode:)
    context 'and the postcode format is valid' do
      let(:postcode) { postcode }
      it { expect(subject[:valid?]).to be_truthy }
    end
  end

  def invalid_postcode_test(test_name, postcode:)
    context 'and the postcode is not valid' do
      context "because it #{test_name}" do
        let(:postcode) { postcode }
        it { expect(subject[:valid?]).to be_falsy }
      end
    end
  end
end
