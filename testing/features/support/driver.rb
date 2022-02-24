# frozen_string_literal: true

class Driver
  include Helpers::EnvVariables

  def initialize
    setup_capybara
    setup_site_prism
    setup_selenium_webdriver
  end

  def register
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(
        app,
        browser: browser,
        desired_capabilities: capabilities
      )
    end
  end

  private

  def capabilities
    Selenium::WebDriver::Chrome::Options.new.tap { |opts| opts.headless! if headless? }
  end

  def setup_capybara
    Capybara.configure do |config|
      config.run_server = false
      config.default_driver = :selenium
      config.default_max_wait_time = 0
      config.app_host = base_url
      config.default_normalize_ws = true if safari?
    end
  end

  def setup_site_prism
    SitePrism.configure do |config|
      config.log_path = "#{ENV['BASE_ARTIFACTS_PATH']}/logs/site_prism.log"
      config.log_level = log_level

      # This will be required until v4 of SitePrism is released
      require "site_prism/all_there"
      config.use_all_there_gem = true
    end
  end

  def setup_selenium_webdriver
    Selenium::WebDriver.logger.level = log_level
    Selenium::WebDriver.logger.output = "#{ENV['BASE_ARTIFACTS_PATH']}/logs/webdriver.log"
  end
end
