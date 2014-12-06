require 'spec_helper'

describe OmniAuth::Strategies::OutOfOffice do
  let(:request) { double('Request', :params => {}, :cookies => {}, :env => {}) }

  subject do
    args = ['appid', 'secret', @options || {}].compact
    OmniAuth::Strategies::OutOfOffice.new(*args).tap do |strategy|
      allow(strategy).to receive(:request) {
        request
      }
    end
  end

  describe 'client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('out_of_office')
    end

    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://outofoffice.travel')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('/oauth/authorize')
    end
  end

  describe 'skip_info option' do
    context 'when skip info option is enabled' do
      it 'should not include raw_info in extras hash' do
        @options = { :skip_info => true }
        allow(subject).to receive(:raw_info).and_return({:foo => 'bar'})
        expect(subject.extra[:raw_info]).to eq(nil)
      end
    end
  end
end
