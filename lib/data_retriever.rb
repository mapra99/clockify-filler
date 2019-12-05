# frozen_string_literal: true

require 'json'
require_relative 'request_builder'

module DataRetriever
  include RequestBuilder

  def workspaces(opts = {})
    Dir.mkdir("./data") unless File.exist?('./data')
    file_path = './data/workspaces.json'

    if !(File.file? file_path) || opts[:reload]
      puts "\nRetrieving workspaces from API"
      response = RequestBuilder.new_get_request '/workspaces'
      File.open(file_path, 'w') { |file| file.puts response.body }
    end

    file = File.open(file_path, 'r')
    JSON.load file
  end

  def projects(opts)
    Dir.mkdir("./data/#{opts[:workspace_id]}") unless File.exist?("./data/#{opts[:workspace_id]}")
    file_path = "./data/#{opts[:workspace_id]}/projects.json"

    if !(File.file? file_path) || opts[:reload]
      puts "\nRetrieving workspace projects from API"
      response = RequestBuilder.new_get_request "/workspaces/#{opts[:workspace_id]}/projects"
      File.open(file_path, 'w') { |file| file.puts response.body }
    end
    file = File.open(file_path, 'r')
    JSON.load file
  end
end
