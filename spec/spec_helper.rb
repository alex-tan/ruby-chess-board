require 'factory_girl'

require_relative '../lib/ruby-chess-board'

require_all 'spec/support',
            'spec/factories',
            'spec/support/matchers',
            'spec/ruby-chess-board/shared_examples'

RSpec.configure do |config|
  config.include BoardHelpers
  config.include FactoryGirl::Syntax::Methods

  config.expect_with(:rspec) { |c| c.syntax = :expect } 
  config.format_docstrings   { |ds| ds.strip.gsub(/\s+/, ' ') }
  config.mock_with :mocha
  config.order = :random
end
