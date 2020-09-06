# frozen_string_literal: true

require_relative './entry_parser'
require_relative './entry_counter'
require_relative './page_visits_sorter'
require_relative './output_saver'

class LogProcessor
  attr_reader :filename
  attr_accessor :entries_with_counts

  def initialize(filename)
    @filename = filename
    @entries_with_counts = {}
  end

  def process
    File.foreach(filename) { |log_entry| count_visits!(parse(log_entry)) }
    save_results(:page_views)
    save_results(:unique_views)
  end

  private

  def parse(log_entry)
    EntryParser.new(log_entry)
  end

  def count_visits!(entry)
    EntryCounter.new(entry).count!(entries_with_counts)
  end

  def save_results(ordering_key)
    page_visits = entries_with_counts.map { |url, values| [url, values[ordering_key]] }
    sorted_page_visits = PageVisitsSorter.new(page_visits).sort
    OutputSaver.new(sorted_page_visits, "sorted_by_#{ordering_key}").save
  end
end
