# frozen_string_literal: true

require_relative '../log_parser'

describe LogParser do
  describe '#run' do
    subject { described_class.new(args).run }

    context 'missing filename' do
      let(:args) { [] }

      it 'logs an error if no filename is given' do
        error_message = /Provide a filename in a fillowing format/
        expect_any_instance_of(Logger).to receive(:error).with(error_message)
        subject
      end
    end

    context 'missing file' do
      let(:args) { ['log'] }

      it "logs an error if given file doesn't exist" do
        error_message = "File log doesn't exist"
        expect_any_instance_of(Logger).to receive(:error).with(error_message)
        subject
      end
    end

    context 'filename passed and file exists' do
      let(:filename) { 'exitsing_log_file.log' }
      let(:args) { [filename] }

      it 'processes log file if file exists' do
        allow(File).to receive(:exist?).with(filename).and_return(true)
        expect_any_instance_of(Logger).not_to receive(:error)
        expect_any_instance_of(described_class).to receive(:process_log).with(filename)
        subject
      end
    end
  end
end
