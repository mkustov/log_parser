# frozen_string_literal: true

require_relative '../entry_parser'

describe EntryParser do
  describe 'spits string by space character' do
    let(:entry_string) { '/help_page/1 126.318.035.038' }
    subject { described_class.new(entry_string) }

    it 'assumes first part is an URL' do
      expect(subject.url).to eq '/help_page/1'
    end

    it 'assumes second part is an ip_address' do
      expect(subject.ip_address).to eq '126.318.035.038'
    end
  end
end
