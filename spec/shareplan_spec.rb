
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

describe "Share Plan" do

  setup
  
  
  after(:all) do
   
    @driver.quit
    @verification_errors.should == []
  end
  
  it "share plan" do

    share_and_verify_plan('Read only')
    sleep 10
    share_and_verify_plan('Edit')
    sleep 10
    share_and_verify_plan('Co-owner')


  end

end
