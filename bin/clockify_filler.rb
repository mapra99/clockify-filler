require 'dotenv/load'
require_relative '../lib/data_retriever'

# Selecting Workspace
workspaces = DataRetriever.workspaces
puts "Select a Workspace"