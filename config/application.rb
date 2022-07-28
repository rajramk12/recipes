require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Recipes
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # I am tryig eager load mode!
    config.autoloader = :Zeitwerk

    config.assets.paths << Rails.root.join("app", "assets", "images")

    # config.action_cable.mount_path  = '/cable'
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # "Zeitwerk confirmation
    config.eager_load_paths << Rails.root.join("app/assets/images")


  end
end
