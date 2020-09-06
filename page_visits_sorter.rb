# frozen_string_literal: true

class PageVisitsSorter
  attr_reader :page_visits

  def initialize(page_visits)
    @page_visits = page_visits
  end

  def sort
    page_visits.sort_by { |entry| -entry.last }
  end
end
