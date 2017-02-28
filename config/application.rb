require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module TaskManager
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       controller_specs: true,
                       view_specs: false,
                       helpers_specs: false,
                       routing_specs: false,
                       requests_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
