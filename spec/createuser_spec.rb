require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
require "mail"
require "./spec/helper.rb"
require "./spec/before.rb"
require "./spec/user.rb"
include RSpec::Expectations

include Before
include User

describe "Create User" do

  setup 
  
  after(:all) do
    remove_previously_added_user('dmp_user')
    @driver.quit
    @verification_errors.should == []
  end
  
  it "create user" do
    create_and_verify_user
    sign_out_user 
    	
  end
  
end
