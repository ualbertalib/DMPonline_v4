require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
require "mail"
include RSpec::Expectations

describe "TestcreateuserSpec" do

  before(:each) do
    @properties = YAML.load_file('properties.yml') 
    @driver = Selenium::WebDriver.for :firefox
    @base_url = @properties['base_url']
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.find_element(:link, "Sign in").click
    @driver.find_element(:id, "user_email").clear
    @driver.find_element(:id, "user_email").send_keys @properties['admin_user']['name'] 
    @driver.find_element(:id, "user_password").clear
    @driver.find_element(:id, "user_password").send_keys @properties['admin_user']['password'] 
    @driver.find_element(:name, "commit").click
    @driver.get(@base_url + "admin/users")
    verify { element_present?(:link, @properties['dmp_user']['name']).should be_true }
    dmp_user = @driver.find_element(:link, @properties['dmp_user']['name']).find_element(:xpath, '../..')
    dmp_user.find_element(:link, "Delete").click
    close_alert_and_get_its_text().should =~ /^Are you sure you want to delete this[\s\S]$/
    verify { (@driver.find_element(:css, "div.flash.flash_notice").text).should == "User was successfully destroyed." }
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_createuser_spec" do
    date = Time.now
    @driver.get(@base_url + "/")
    (@driver.title).should == "DMP Tool - University of Alberta Libraries"
    @driver.find_element(:link, "Sign up").click
    @driver.find_element(:xpath, "(//input[@id='user_email'])[2]").clear
    @driver.find_element(:xpath, "(//input[@id='user_email'])[2]").send_keys @properties['dmp_user']['name'] 
    @driver.find_element(:xpath, "(//input[@id='user_password'])[2]").clear
    @driver.find_element(:xpath, "(//input[@id='user_password'])[2]").send_keys @properties['dmp_user']['password'] 
    @driver.find_element(:id, "user_password_confirmation").clear
    @driver.find_element(:id, "user_password_confirmation").send_keys @properties['dmp_user']['password'] 
    @driver.find_element(:id, "user_accept_terms").click
    verify { element_present?(:xpath, "(//input[@name='commit'])[2]").should be_true }
    @driver.find_element(:xpath, "(//input[@name='commit'])[2]").click
    !60.times{ break if (element_present?(:css, "p.alert.alert-notice") || element_present?(:css, "p.alert.alert-error") rescue false); sleep 1 }
    verify { (@driver.find_element(:css, "p.alert.alert-notice").text).should == "A message with a confirmation link has been sent to your email address. Please open the link to activate your account." }
    sleep 5
    email =  @properties["email_user"]["name"]
    password =  @properties["email_user"]["password"]
    
    Mail.defaults do
      retriever_method :imap, :address => "imap.gmail.com",
                              :port    => 993,
                              :user_name => email,
                              :password => password,
                              :enable_ssl => true
    end
    mail = Mail.find(:what => :last, :delete_after_find => true, :count => 1, :keys => ['SUBJECT', 'Confirm your DMPonline account','SINCE', date.strftime("%d-%b-%Y")])
    expect(mail).not_to be_nil
    confirmation_url = mail.body.decoded.scan(/href="(.*)"/)[0]
 
    @driver.get(confirmation_url)
    verify { (@driver.find_element(:css, "a.dropdown-toggle").text).should == "Signed in as dit.test@ualberta.ca" }
    @driver.find_element(:css, "b.caret").click
    @driver.find_element(:link, "Sign out").click 
    	
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
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


end
