require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bbs
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.time_zone = 'Beijing'
    config.autoload_paths += %W(#{config.root}/lib #{config.root}/lib/utils)
    # config.active_record.belongs_to_required_by_default = true

    config.action_cable.mount_path = '/cable'
  end
end
