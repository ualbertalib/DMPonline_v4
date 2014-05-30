require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
require "mail"
require "./spec/helper.rb"
require "./spec/before.rb"
require "./spec/user.rb"
require "./spec/plan.rb"
include RSpec::Expectations

include Before
include User
include Plan

describe "Export Plan" do

  setup
  
  before(:each) do
    create_and_verify_user
    create_and_verify_plan
  end
  
  after(:each) do
    sign_out_user
    destroy_plan
    remove_previously_added_user('dmp_user')
    
    @driver.quit
    @verification_errors.should == []
  end
  
  it "export plan as webpage" do
    win_handle = @driver.window_handle
    visit_export_page
    @driver.find_element(:link, "View as a web page").click
    sleep 3
    @driver.switch_to.window(@driver.window_handles[1])
    (@driver.find_element(:css, "h1").text).should == @properties['dmp_plan']['name']
    (@driver.find_element(:xpath, "//div[@id='export_font']/div/div/h3[6]").text).should == "Responsibilities and Resources"
    @driver.close
    @driver.switch_to.window(win_handle)
  end

end
