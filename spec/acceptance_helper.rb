require "rails_helper"

RSpec.configure do |config|
  Capybara.server_host = "0.0.0.0"
  Capybara.server_port = 3001
  Capybara.default_max_wait_time = 2
  Capybara.always_include_port = true
  Capybara.server = :puma

  config.use_transactional_fixtures = false

  config.before(:suite) { DatabaseCleaner.clean_with(:truncation) }
  config.before(:each) { DatabaseCleaner.strategy = :transaction }
  config.before(:each, js: true) { DatabaseCleaner.strategy = :truncation }
  config.before(:each) { DatabaseCleaner.start }

  config.append_after(:each) do
    Capybara.reset_sessions!
    DatabaseCleaner.clean
  end
end
