# frozen_string_literal: true

class EntryParser
  attr_reader :entry_string

  def initialize(entry_string)
    @entry_string = entry_string
  end

  def url
    parsed_entry_string.first
  end

  def ip_address
    parsed_entry_string.last
  end

  private

  def parsed_entry_string
    @_parsed_entry_string ||= entry_string.split(/\s/)
  end
end
