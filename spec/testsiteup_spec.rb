require "json"
require "selenium-webdriver"
require "rspec"
require "./spec/helper.rb"
require "./spec/before.rb"
include RSpec::Expectations

include Before

describe "TestsiteupSpec" do

  setup

  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_siteup_spec" do
    @driver.get(@base_url + "/")
    (@driver.title).should == "DMP Tool - University of Alberta Libraries"
    verify { (@driver.find_element(:css, "h3.subhead").text).should == "Data Management Planning Tool" }
  end
  
end
