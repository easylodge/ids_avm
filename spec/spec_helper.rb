require "bundler/setup"
require 'pry'
require 'shoulda/matchers'
require "ids_avm"
Bundler.setup

ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => ':memory:'
)
require 'schema'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.include Rails::StringHelpers
  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
