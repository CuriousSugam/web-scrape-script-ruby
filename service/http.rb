# frozen_string_literal: true

require 'net/http'

class HttpService
  def self.get(url)
    uri = URI(valid_url(url))
    Net::HTTP.get(uri)
  rescue StandardError => e
    print "Error: Could not fetch URL: #{url}. \n #{e}"
    raise e
  end

  def self.valid_url(str)
    uri = URI.parse(str)
    uri.scheme = 'https' if uri.scheme.nil?
    if uri.host.nil? && !uri.path.nil?
      uri.host = uri.path
      uri.path = ''
    end

    uri.to_s
  end
end
