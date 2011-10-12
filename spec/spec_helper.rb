# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'remarkable/active_record'

# Debugging
require 'ap'
require 'pry'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["spec/support/**/*.rb"].map { |f| f.gsub(%r{.rb$}, '') }.each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.filter_run :focus => true
  config.filter_run_excluding :external => true
  config.run_all_when_everything_filtered = true

  # If you'd prefer not to run each of your examples within a transaction,
  # uncomment the following line.
  #config.use_transactional_examples false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation # :transaction strategy currently does not work
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each)  { DatabaseCleaner.start }
  config.after(:each)   { DatabaseCleaner.clean }
end
