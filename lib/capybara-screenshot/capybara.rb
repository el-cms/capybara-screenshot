module Capybara
  class << self
    module ScreenshotOverrides
      def using_session(name, &block)
        original_session_name = Capybara.session_name
        Capybara::Screenshot.final_session_name = name
        super(name, &block)
        Capybara::Screenshot.final_session_name = original_session_name
      end

      # No longer needed. Kept for backwards compatibility only.
      alias_method :using_session_with_screenshot, :using_session
    end

    prepend ScreenshotOverrides
  end

  module DSL
    # Adds class methods to Capybara module and gets mixed into
    # the current scope during Cucumber and RSpec tests

    def screenshot_and_save_page(prefix: nil, html: true)
      Capybara::Screenshot.screenshot_and_save_page(prefix: prefix, html: html)
    end

    def screenshot_and_open_image(prefix: nil)
      Capybara::Screenshot.screenshot_and_open_image(prefix: prefix)
    end
  end
end
