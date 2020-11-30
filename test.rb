#!/usr/bin/env ruby
#

require 'json'
require 'net/http'
 
url=ARGV.shift
uri = URI(url)
req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
 
req.body = {
  "mock_data": "true",
  "ip_address": "92.188.61.181",
  "email": "user@example.com",
  "user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_4) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.100 Safari/534.30",
  "url": "http://example.com/"
}.to_json
 
Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
  puts http.request(req).body
end
