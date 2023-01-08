#!/Users/sugamshakya/.rbenv/shims/ruby
# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'optparse'
require 'service/http'
require 'service/store'
require 'service/metadata'

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
  # print "Fetching URL: #{url} ...\n"
  url = HttpService.valid_url(_url)
  page = HttpService.get(url)
  domain = URI.parse(url)&.host
  # print "Fetch complete. Initiate parsing ...\n"

  metadata = Metadata.new(domain, page).get_metadata
  metadata.each do |key, value|
    print "#{key}: #{value} \n"
  end

  # print "Saving records ... \n"
  Store.new(domain).save(page)
  # print "Processing complete for url: #{url} \n\n"
  print "\n\n"
rescue StandardError => e
  print "Error while processing URL: #{url}\n"
  print "#{e} \n\n"
end

# TODO: Archive the downloaded web page's assets to run as html pages.

