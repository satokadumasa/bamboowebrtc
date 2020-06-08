require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SquareRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    # Don't generate system test files.
    config.generators.system_tests = nil
    config.site_name = ENV['BAMBOO_SITE_NAME']
    config.active_record.default_timezone = :local
    config.time_zone = ENV['BAMBOO_TIMEZONE']
    # 有効にする言語のホワイトリスト
    config.i18n.available_locales = %i(ja en)

    # ホワイトリストをチェックするかどうか
    config.i18n.enforce_available_locales = true

    # 言語を指定されなかった場合のデフォルト値
    config.i18n.default_locale = :ja
  end
end
