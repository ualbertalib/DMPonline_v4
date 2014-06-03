require "json"
require "selenium-webdriver"
require "rspec"
require "./spec/helper.rb"
require "./spec/before.rb"
require "./spec/after.rb"
include RSpec::Expectations

include Before
include After

describe "Simplest" do

  setup

  teardown
  
  it "site is up" do
    @driver.get(@base_url + "/")
    (@driver.title).should == "DMP Tool - University of Alberta Libraries"
    verify { (@driver.find_element(:css, "h3.subhead").text).should == "Data Management Planning Tool" }
  end
  
end
