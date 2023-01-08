# frozen_string_literal: true

require 'nokogiri'

class Parser
  attr_reader :page

  DEFAULT_OPTIONS = { links_count: true, images_count: true }.freeze

  def initialize(page)
    @page = page
  end

  def metadata(opts = DEFAULT_OPTIONS)
    metadata = {}
    doc = Nokogiri::HTML(page)
    metadata[:images_count] = doc.search('img').length if opts[:images_count]
    metadata[:links_count] = doc.search('a').length if opts[:links_count]

    metadata
  rescue StandardError => e
    print "Error: Could not parse the page. \n #{e}"
    {}
  end
end
