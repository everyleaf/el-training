module RetryTestSupport
  def retry_on_stale_element_reference_error(&block)
    first_try = true
    begin
      block.call
    rescue Selenium::WebDriver::Error::StaleElementReferenceError
      warn 'Retry on StaleElementReferenceError'
      if first_try
        first_try = false
        retry
      end
      raise
    end
  end
end

RSpec.configure do |config|
  config.include RetryTestSupport
end
