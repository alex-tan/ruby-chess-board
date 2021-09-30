source 'https://rubygems.org'

gem "require_all", "~> 3.0.0"
gem "terminal-table", "~> 3.0.2"
gem 'sorbet-runtime'

group :test do
  gem "factory_bot", "~> 6.2.0"
  gem "mocha", "~> 1.13.0"
  gem "rspec", "~> 3.10.0"
  gem 'rspec-sorbet'
  gem 'rspec-its'
end

group :development do
  gem 'sorbet'
  gem 'guard'
  gem 'guard-sorbet'
  gem 'guard-rspec', require: false
end

group :test, :development do
  gem "yard", "~> 0.9.26"
end
