
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
  
  before(:each) do
    create_and_verify_user
  end
  
  after(:each) do
   
    @driver.quit
    @verification_errors.should == []
  end
  
  it "share plan" do

    share_and_verify_plan('Read Only')

    #share_and_verify_plan('edit')
    #share_and_verify_plan('coowner')


  end

end
