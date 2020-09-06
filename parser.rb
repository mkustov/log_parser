# frozen_string_literal: true

require 'logger'
require_relative './log_processor'

class Parser
  attr_reader :logger, :args

  def initialize(args)
    @args = args
    @logger = Logger.new(STDOUT)
  end

  def run
    if args.empty?
      logger.error("Provide a filename in a fillowing format: \
        \nruby parser.rb <your_path_to_the_file>")
      return
    end

    unless File.exist?(args[0])
      logger.error("File #{args[0]} doesn't exist")
      return
    end

    process_log(args[0])
  end

  private

  def process_log(log_filename)
    LogProcessor.new(log_filename).process
  end
end

Parser.new(ARGV).run
