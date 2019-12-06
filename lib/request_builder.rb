# frozen_string_literal: true

require 'net/http'
require 'uri'

module RequestBuilder
  def new_get_request(url)
    uri = URI.parse("https://api.clockify.me/api/v1#{url}")
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

  def new_post_request(url, body)
    uri = URI.parse("https://api.clockify.me/api/v1#{url}")
    request = Net::HTTP::Post.new(uri)
    request.content_type = 'application/json'
    request['X-Api-Key'] = ENV['API_KEY']
    request.body = body
    req_options = {
      use_ssl: uri.scheme == 'https'
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    puts response.body
  end
end

# [2019].each do |year|      # Loop to make entries over multiple years
#   [12].each do |month|     # Loop to make entries over multiple months
#     (5..31).each do |day|  # Loop to make entries over multiple days
#       formated_year = year.to_s.rjust(4, '0')
#       formated_month = month.to_s.rjust(2, '0')
#       formated_day = day.to_s.rjust(2, '0')
#       date = [formated_year, formated_month, formated_day].join('-')

#       # Body Content
#       request.body = '{
#         "start": "' + date + 'T14:00:00.000Z",
#         "billable": "false",
#         "description": "Peer to Peer Review",
#         "projectId": "5dbae1f6fa232856dbdbef57",
#         "end": "' + date + 'T15:00:00.000Z"
#       }'

#       # Send Request
#

#       # Show response
#       puts(response.body)
#     end
#   end
# end
