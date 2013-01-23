require_relative '../lib/ruby-chess-board'

require_all('spec/support/')
require_all('spec/support/matchers')

RSpec.configure do |config|
  config.order = :random
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
