require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
require "mail"
require "./spec/helper.rb"
require "./spec/before.rb"
include RSpec::Expectations

include Before

def remove_previously_added_user

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

end

def create_a_new_user

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

end

def get_confirmation_url_from_email(date)

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
    mail.body.decoded.scan(/href="(.*)"/)[0]

end

describe "TestcreateuserSpec" do

  setup 
  
  after(:each) do
    remove_previously_added_user
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_createuser_spec" do
    date = Time.now
    create_a_new_user
    sleep 5
    confirmation_url = get_confirmation_url_from_email(date)
 
    @driver.get(confirmation_url)
    verify { (@driver.find_element(:css, "a.dropdown-toggle").text).should == "Signed in as dit.test@ualberta.ca" }
    @driver.find_element(:css, "b.caret").click
    @driver.find_element(:link, "Sign out").click 
    	
  end
  
end
