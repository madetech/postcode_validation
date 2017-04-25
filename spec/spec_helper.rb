$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'dotenv'
Dotenv.load('.env')

require 'vcr'
require 'webmock'
require 'postcode_validation'
require 'pry'

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/cassettes'
end
