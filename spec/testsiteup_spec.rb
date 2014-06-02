require "json"
require "selenium-webdriver"
require "rspec"
require "./spec/helper.rb"
require "./spec/before.rb"
include RSpec::Expectations

include Before

describe "Simplest" do

  setup

  after(:all) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "site is up" do
    @driver.get(@base_url + "/")
    (@driver.title).should == "DMP Tool - University of Alberta Libraries"
    verify { (@driver.find_element(:css, "h3.subhead").text).should == "Data Management Planning Tool" }
  end
  
end
