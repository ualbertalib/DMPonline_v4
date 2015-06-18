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
  
  after(:each) do
    if !example.instance_variable_get(:@exception).nil? 
      screen_capture
    end
  end
  
  it "site is up" do
    @driver.get(@base_url + "/")
    expect(@driver.title).to eq "DMP Builder - University of Alberta Libraries"
    expect(@driver.find_element(:css, "h3.subhead").text).to eq "A Tool for Data Management Plans"
  end
  
end
