# frozen_string_literal: true

require_relative '../output_saver'

describe OutputSaver do
  let(:page_views) { [['/home', 5], ['/profile', 1]] }
  let(:output_filename) { 'my_awesome_file' }

  subject { described_class.new(page_views, output_filename).save }

  it 'writes formatted page_views data into file' do
    file = double('file')
    expect(File).to receive(:open).with('my_awesome_file.txt', 'w').and_yield(file)
    expect(file).to receive(:write).with("/home - 5 visit(s)\n")
    expect(file).to receive(:write).with("/profile - 1 visit(s)\n")
    subject
  end
end
