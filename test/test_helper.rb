# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

require "capybara/rails"
Rails.backtrace_cleaner.remove_silencers!
Capybara.default_driver = :rack_test

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Run any available migration
ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)
