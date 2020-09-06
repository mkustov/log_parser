# frozen_string_literal: true

require_relative '../log_processor'

describe LogProcessor do
  let(:fixture_page_views) { [['/contact', 5], ['/home', 4], ['/help_page/1', 2]] }
  let(:fixture_unique_views) { [['/home', 4], ['/contact', 3], ['/help_page/1', 2]] }

  subject { described_class.new('spec/fixtures/input.log').process }

  it 'sorts log entries and saves results to files' do
    expect(OutputSaver).to receive(:new).with(fixture_page_views, 'sorted_by_page_views')
                                        .and_return(double(save: true))
    expect(OutputSaver).to receive(:new).with(fixture_unique_views, 'sorted_by_unique_views')
                                        .and_return(double(save: true))
    subject
  end
end
