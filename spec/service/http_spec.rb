require 'spec/spec_helper.rb'

describe HttpService do
  describe ".get" do
    let(:method) { described_class.get(url) }

    context 'when url is valid' do
      let(:url) { 'https://google.com' }
      let(:web_page) { 'hello world!' }

      before do
        allow(Net::HTTP).to receive(:get).and_return(web_page)
      end

      it 'fetches the url' do
        expect(method).to eq(web_page)
      end
    end

    xcontext 'when the url is invalid' do

    end

    context 'when there is an error fetching the url' do
      let(:url) { 'https://google.com' }
      let(:web_page) { 'hello world!' }

      before do
        allow(Net::HTTP).to receive(:get).and_raise(Net::OpenTimeout.new)
      end

      it 'fetches the url' do
        expect{ method }.to raise_error(Net::OpenTimeout)
      end
    end
  end
end