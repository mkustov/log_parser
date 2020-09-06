# frozen_string_literal: true

require_relative '../page_visits_sorter'

describe PageVisitsSorter do
  let(:page_views) { [['/home', 5], ['/profile', 1], ['/about', 3]] }

  subject { described_class.new(page_views).sort }

  it 'sorts array of arrays in a reverse order by last argument' do
    expect(subject).to eq [['/home', 5], ['/about', 3], ['/profile', 1]]
  end
end
