# typed: strict
require 'factory_bot'
require 'rspec/its'

require_relative '../lib/ruby-chess-board'

require_all 'spec/support'
require_all 'spec/factories'
require_all 'spec/support/matchers'
require_all 'spec/ruby-chess-board/shared_examples'

RSpec.configure do |config|
  config.include BoardHelpers
  config.include FactoryBot::Syntax::Methods

  config.expect_with(:rspec) { |c| c.syntax = :expect } 
  config.format_docstrings   { |ds| ds.strip.gsub(/\s+/, ' ') }
  config.mock_with :mocha
  config.order = :random
end
