# frozen_string_literal: true

class OutputSaver
  attr_reader :page_views, :output_filename

  def initialize(page_views, output_filename)
    @page_views = page_views
    @output_filename = output_filename
  end

  def save
    File.open("#{output_filename}.txt", 'w') do |file|
      page_views.map do |page_view|
        file.write("#{format_line(page_view)}\n")
      end
    end
  end

  private

  def format_line(line)
    "#{line.first} - #{line.last} visit(s)"
  end
end
