require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ApiTest
  class Application < Rails::Application
    config.eager_load_paths << Rails.root.join('lib')
    config.api_only = true
    config.action_dispatch.default_headers.merge!({
  		'Access-Control-Allow-Origin' => '*',
  		'Access-Control-Request-Method' => '*'
	})
  end
end
