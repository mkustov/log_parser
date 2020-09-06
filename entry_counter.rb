# frozen_string_literal: true

class EntryCounter
  attr_reader :log_entry

  def initialize(log_entry)
    @log_entry = log_entry
  end

  def count!(entries_hash)
    entries_hash.key?(log_entry.url) ? update_entry(entries_hash[log_entry.url]) : add_entry(entries_hash)
  end

  private

  def add_entry(entries_hash)
    entries_hash[log_entry.url] = {
      ip_addresses: [log_entry.ip_address],
      page_views: 1,
      unique_views: 1
    }
  end

  def update_entry(existing_row)
    existing_row[:page_views] += 1
    return if existing_row[:ip_addresses].include?(log_entry.ip_address)

    existing_row[:ip_addresses] << log_entry.ip_address
    existing_row[:unique_views] += 1
  end
end
