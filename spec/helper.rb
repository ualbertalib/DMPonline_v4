# Selenium helper methods
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
    @driver.save_screenshot "#{@screenshots_dir}/#{example.metadata[:description]}-#{Time.now.strftime('failshot__%d_%m_%Y__%H_%M_%S')}.png"
  end
  
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
    @driver.save_screenshot "#{@screenshots_dir}/#{example.metadata[:description]}-#{Time.now.strftime('failshot__%d_%m_%Y__%H_%M_%S')}.png"
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
    @driver.save_screenshot "#{@screenshots_dir}/#{example.metadata[:description]}-#{Time.now.strftime('failshot__%d_%m_%Y__%H_%M_%S')}.png"
  end
  
  def close_alert_and_get_its_text()
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
