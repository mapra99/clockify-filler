# frozen_string_literal: true

require 'net/http'
require 'uri'

module DataRetriever
  def workspaces
    uri = URI.parse('https://api.clockify.me/api/v1/workspaces')
    request = Net::HTTP::Get.new(uri)
    request.content_type = 'application/json'
    request['X-Api-Key'] = ENV['API_KEY']

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end

  def projects(workspace); end
end
