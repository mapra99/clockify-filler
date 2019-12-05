# frozen_string_literal: true

require 'json'
require_relative 'request_builder'

module DataRetriever
  include RequestBuilder

  def workspaces(opts = {})
    if !(File.file? './data/workspaces.json') || opts[:reload]
      puts "\nRetrieving workspaces from API"
      response = RequestBuilder.new_get_request '/workspaces'
      File.open('./data/workspaces.json', 'w') { |file| file.puts response.body }
    end

    file = File.open('./data/workspaces.json', 'r')
    JSON.load file
  end

  def projects(opts)
    if !(File.file? "./data/#{opts[:workspace_id]}_projects.json") || opts[:reload]
      puts "\nRetrieving workspace projects from API"
      response = RequestBuilder.new_get_request "/workspaces/#{opts[:workspace_id]}/projects"
      File.open("./data/#{opts[:workspace_id]}_projects.json", 'w') { |file| file.puts response.body }
    end
    file = File.open("./data/#{opts[:workspace_id]}_projects.json", 'r')
    JSON.load file
  end
end
