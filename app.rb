#!/usr/local/bin/ruby
# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'optparse'
require 'service/http'
require 'service/store'
require 'service/metadata'
require 'service/log'

options = {}
OptionParser.new do |opts|
  opts.on('-m', '--[no-]metadata', 'Display metadata') do |v|
    options[:metadata] = v
  end
end.parse!

urls = []
ARGV.each do |a|
  urls << a
end

urls.each do |_url|
  LogService.debug "Fetching URL: #{_url} ...\n"
  url = HttpService.valid_url(_url)
  page = HttpService.get(url)
  domain = URI.parse(url)&.host
  LogService.debug "Fetch complete. Initiate parsing ...\n"

  if options[:metadata]
    metadata = Metadata.new(domain, page).get_metadata
    metadata.each do |key, value|
      LogService.log "#{key}: #{value} \n"
    end
  end

  LogService.debug "Saving records ... \n"
  Store.new(domain).save(page)
  LogService.debug "Processing complete for url: #{url} \n\n"
  LogService.debug "\n\n"
rescue StandardError => e
  LogService.log "Error while processing URL: #{url}\n"
  LogService.log "#{e} \n\n"
end

# TODO: Archive the downloaded web page's assets to run as html pages.

