# frozen_string_literal: true

require_relative '../entry_counter'

describe EntryCounter do
  let(:log_entry) { double(url: '/help_page/1', ip_address: '126.318.035.038') }
  let(:entries_hash) { {} }

  subject { described_class.new(log_entry).count!(entries_hash) }

  it 'adds log entry to hash for new URLs with default values' do
    expected_result = {
      '/help_page/1' => { ip_addresses: ['126.318.035.038'],
                          page_views: 1,
                          unique_views: 1 }
    }
    expect { subject }.to change { entries_hash }.from({}).to(expected_result)
  end

  context 'for exising records' do
    let(:entries_hash) do
      { '/help_page/1' => { ip_addresses: [ip_address],
                            page_views: 1,
                            unique_views: 1 } }
    end

    context 'unique views' do
      let(:ip_address) { '184.123.665.067' }

      it 'changes visits and IPs list for unique views' do
        expected_result = {
          '/help_page/1' => { ip_addresses: ['184.123.665.067', '126.318.035.038'],
                              page_views: 2,
                              unique_views: 2 }
        }
        expect { subject }.to change { entries_hash }.to(expected_result)
      end
    end

    context 'not unique views' do
      let(:ip_address) { log_entry.ip_address }

      it 'changes visits and IPs list for unique views' do
        expected_result = {
          '/help_page/1' => { ip_addresses: ['126.318.035.038'],
                              page_views: 2,
                              unique_views: 1 }
        }
        expect { subject }.to change { entries_hash }.to(expected_result)
      end
    end
  end
end
