require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
require "mail"
require "./spec/helper.rb"
require "./spec/before.rb"
require "./spec/after.rb"
require "./spec/user.rb"
require "./spec/plan.rb"
include RSpec::Expectations

include Before
include After
include User
include Plan

describe "Edit and Delete Plan" do

  setup
  
  teardown
  
  before(:all) do
    begin
      create_and_verify_user
    rescue
    end
  end
  
  after(:all) do
    begin
      remove_previously_added_user('dmp_user')
    rescue
    end
  end
  
  it "edit and delete plan" do
    puts "create_and_verify_plan"
    create_and_verify_plan
    puts "edit_plan"
    edit_plan
    delete_plan
    sign_out_user
  end

end

