# frozen_string_literal: true

require 'json'
require 'date'
require_relative 'request_builder'

module NewEntries
  include RequestBuilder

  def time_entry(start_date, end_date, start_time, end_time, task_description, project, workspace)
    date1 = Date.strptime(start_date, '%Y-%m-%d')
    date2 = Date.strptime(end_date, '%Y-%m-%d')

    date1.upto(date2) do |date|
      next if date.sunday? || date.saturday?

      time1 = Time.local(date.year, date.month, date.day,
                         start_time.split(':')[0].to_i,
                         start_time.split(':')[1].to_i)

      time2 = Time.local(date.year, date.month, date.day,
                         end_time.split(':')[0].to_i,
                         end_time.split(':')[1].to_i)

      body = '{"start": "' + time1.utc.strftime('%Y-%m-%dT%H:%M:00.000Z') + '","description": "' + task_description + '","projectId": "' + project + '","end": "' + time2.utc.strftime('%Y-%m-%dT%H:%M:00.000Z') + '"}'

      RequestBuilder.new_post_request "/workspaces/#{workspace}/time-entries", body
    end
  end
end

