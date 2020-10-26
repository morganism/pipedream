#!/usr/bin/env ruby

require 'json'
require 'net/http'
webhook_id = 'en5x2cjbh61w9pj'
https_address = "https://#{webhook_id}.m.pipedream.net"
uri = URI(https_address)
req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
 
req.body = {"name":"Princess Leia"}.to_json
 
Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
  http.request(req)
end
