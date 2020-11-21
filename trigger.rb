#!/usr/bin/env ruby
# morgan.sziraki@gmail.com
# Sat 21 Nov 2020 09:49:49 GMT
require 'json'
require 'net/http'
require 'openssl'
require 'optparse'
require 'ostruct'
require 'uri'

DEFAULT_OPTIONS = { :verify_mode => OpenSSL::SSL::VERIFY_NONE }

module Pipedream
  class Trigger

    def initialize(workflow_id)
      @workflow_id = workflow_id
      @json = doit
    end
 
    def access_token
      JSON.parse(@json)['access_token']
    end

    private
       
    def doit
      resp = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(req(uri))
      end
      resp.body
    end

    def req(uri, options = {})
      Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    end

    def uri
      @uri ||= URI("https://#{@workflow_id}.m.pipedream.net")
    end
  end
end

# if running as a script
if __FILE__ == $0

  def processOptions
    options = OpenStruct.new
    OptionParser.new do |opts|
      opts.banner = 'Usage: SCRIPT_NAME [options] ...'
      opts.on('-i', '--id ', 'Thw Pupedream Workflow ID') { |o| options.workflow_id = o }
      opts.on_tail('-h', '--help') {
        puts opts
        exit
      }
    end.parse!

    return options
  end

  options = processOptions
  obj = Pipedream::Trigger.new(options.workflow_id)
  puts obj.access_token
end
