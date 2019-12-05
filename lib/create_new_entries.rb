# frozen_string_literal: true

require 'dotenv/load'
require 'net/http'
require 'uri'

microverse_workspace = '5a747087b07987649ce7cd3f'

uri = URI.parse("https://api.clockify.me/api/v1/workspaces/#{microverse_workspace}/time-entries")
request = Net::HTTP::Post.new(uri)

# Header Content
request.content_type = 'application/json'
request['X-Api-Key'] = ENV['API_KEY']

[2019].each do |year|      # Loop to make entries over multiple years
  [12].each do |month|     # Loop to make entries over multiple months
    (5..31).each do |day|  # Loop to make entries over multiple days
      formated_year = year.to_s.rjust(4, '0')
      formated_month = month.to_s.rjust(2, '0')
      formated_day = day.to_s.rjust(2, '0')
      date = [formated_year, formated_month, formated_day].join('-')

      # Body Content
      request.body = '{
        "start": "' + date + 'T14:00:00.000Z",
        "billable": "false",
        "description": "Peer to Peer Review",
        "projectId": "5dbae1f6fa232856dbdbef57",
        "end": "' + date + 'T15:00:00.000Z"
      }'

      req_options = {
        use_ssl: uri.scheme == 'https'
      }

      # Send Request
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      # Show response
      puts(response.body)
    end
  end
end
