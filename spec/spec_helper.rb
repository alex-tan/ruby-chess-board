require_relative '../lib/ruby-chess-board'

Dir['./spec/support/*.rb'].each { |f| require f }
Dir['./spec/support/matchers/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.order = :random
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
