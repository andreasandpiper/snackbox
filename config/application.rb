# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'securerandom'

Bundler.require(*Rails.groups)

module SnackboxRails
  class Application < Rails::Application
    config.load_defaults 6.0
    config.active_job.queue_adapter = :sidekiq
  end
end
