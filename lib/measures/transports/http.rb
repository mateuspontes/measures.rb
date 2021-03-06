require "faraday"
require "faraday_middleware"
require "uri"

module Measures
  module Transports
    class HTTP
      def initialize(host, port = 80, url = "/")
        @host = host
        @port = port
        @url = url
      end

      def send(data)
        client = Faraday.new(url: URI::HTTP.build(host: @host, port: @port)) do |c|
          c.request :json

          c.response :raise_error
          c.adapter Faraday.default_adapter
        end

        client.post do |req|
          req.url @url
          req.headers["Content-Type"] = "application/json"
          req.body = data
        end
      end
    end
  end
end
