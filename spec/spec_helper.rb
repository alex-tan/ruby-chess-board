require 'factory_girl'

require_relative '../lib/ruby-chess-board'

require_all 'spec/support',
            'spec/factories',
            'spec/support/matchers',
            'spec/ruby-chess-board/shared_examples'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include BoardHelpers

  config.expect_with(:rspec) { |c| c.syntax = :expect } 
  config.mock_with :mocha
  config.order = :random
end
