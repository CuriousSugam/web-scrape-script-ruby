# frozen_string_literal: true

require 'service/store'
require 'service/parser'

class Metadata
  attr_reader :domain, :page

  DEFAULT_OPTIONS = { links_count: true, images_count: true }.freeze

  def initialize(domain, page)
    @domain = domain
    @page = page
  end

  def get_metadata
    metadata = {
      site: domain
    }
    metadata.merge(Parser.new(page).metadata, Store.new(domain).select_metadata)
  end
end
