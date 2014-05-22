require "yaml"

module Before

  def setup

  before(:each) do
    @properties = YAML.load_file('properties.yml')
    @driver = Selenium::WebDriver.for :firefox
    @base_url = @properties['base_url']
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  end

end
