$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'dotenv'
Dotenv.load('.env')

require 'vcr'
require 'webmock'
require 'postcode_validation'

Dir["#{__dir__}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |c|
  c.extend PostcodeTestHelpers
end

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/cassettes'
end
