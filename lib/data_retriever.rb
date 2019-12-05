# frozen_string_literal: true

require 'json'
require_relative 'request_builder'

module DataRetriever
  include RequestBuilder

  def workspaces(opts = {})
    if !(File.file? './data/workspaces.json') || opts[:reload]
      puts 'retrieving workspaces from API'
      response = RequestBuilder.new_get_request '/workspaces'
      File.open('./data/workspaces.json', 'w') { |file| file.puts response.body }
    end

    file = File.open('./data/workspaces.json', 'r')
    JSON.load file
  end

  def projects(workspace); end
end
