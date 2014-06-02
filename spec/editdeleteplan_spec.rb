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

describe "Edit and Delete Plan" do

  setup
  
  before(:all) do
    create_and_verify_user
  end
  
  after(:all) do
    
    remove_previously_added_user('dmp_user')
    
    @driver.quit
    @verification_errors.should == []
  end
  
  it "edit and delete plan" do

    create_and_verify_plan
    edit_plan
    delete_plan
    sign_out_user

  end

end

