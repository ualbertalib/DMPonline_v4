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

describe "Create Plan" do

  setup
  
  teardown
  
  before(:all) do
    create_and_verify_user
  end
  
  after(:all) do
    destroy_plan
    remove_previously_added_user('dmp_user')
  end
  
  it "create plan" do

    create_and_verify_plan
    sign_out_user

  end

end
