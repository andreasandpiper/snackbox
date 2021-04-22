# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'securerandom'

Bundler.require(*Rails.groups)

module SnackboxRails
  class Application < Rails::Application
    config.load_defaults 6.0
    config.active_job.queue_adapter = :sidekiq

    config.before_initialize do
      dev = File.join(Rails.root, 'config', 'config.yml')
      YAML.load(File.open(dev)).each do |key,value|
        ENV[key.to_s] = value
      end if File.exists?(dev)
    end
  end
end
