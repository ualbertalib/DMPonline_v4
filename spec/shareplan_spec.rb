
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

describe "Share Plan" do

  setup
  
  teardown
  
  before(:all) do
    create_and_verify_user
    sign_out_user
  end
  before(:each) do
    login_as_user(@properties['dmp_user']['name'], @properties['dmp_user']['password'])
    create_and_verify_plan  
  end
  
  after(:all) do
    remove_previously_added_user('dmp_user')  
  end
  after(:each) do
    destroy_plan
    remove_previously_added_user('dmp_share_user')
  end
  
  it "share read only plan" do
    share_and_verify_plan('Read only')
  end

  it "share edit plan" do
    share_and_verify_plan('Edit')
  end
  
  it "share co-owner plan" do
    share_and_verify_plan('Co-owner')
  end

end
