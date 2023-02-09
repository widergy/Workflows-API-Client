# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'faker'
require File.expand_path('../spec/dummy/config/environment', __dir__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')
Dir[File.join(ENGINE_RAILS_ROOT, 'spec/support/**/*.rb')].sort.each { |f| require f }

# simplecov
require 'simplecov'
SimpleCov.start

# VCR Configuration
require 'vcr'
require 'webmock/rspec'

# HTTParty
require 'httparty'

ActiveRecord::Migration.maintain_test_schema!

VCR_LOGGER_PATH = Rails.root.join("/log/#{Rails.env}/vcr.log").freeze

VCR.configure do |c|
  c.before_record do |cassette|
    cassette.response.body.force_encoding('UTF-8')
  end
  c.ignore_hosts 'codeclimate.com'
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = false
end

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  Faker::Config.random = Random.new(config.seed)

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
