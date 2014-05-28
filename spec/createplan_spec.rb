require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
require "mail"
require "./spec/helper.rb"
require "./spec/before.rb"
require "./spec/user.rb"
include RSpec::Expectations

include Before
include User

describe "Create Plan" do

  setup
  
  before(:each) do
    create_and_verify_user
  end
  
  after(:each) do
    sign_out_user
    login_as_admin
    # destrpy plan
    @driver.get(@base_url + "admin/projects")
    verify { (@driver.find_element(:css, "td.title").text).should == "no one else could possibly have the same name as this" }
    dmp_plan = @driver.find_element(:xpath, "//td[contains(text(),'no one else could possibly have the same name as this')]").find_element(:xpath, '../..')
    dmp_plan.find_element(:link, "Delete").click
    close_alert_and_get_its_text().should =~ /^Are you sure you want to delete this[\s\S]$/
    verify { (@driver.find_element(:css, "div.flash.flash_notice").text).should == "Project was successfully destroyed." }
    sign_out_user
    remove_previously_added_user
    
    @driver.quit
    @verification_errors.should == []
  end
  
  it "create plan" do
    @driver.get(@base_url + "/users/edit")
    verify { (@driver.find_element(:css, "a.dropdown-toggle").text).should == "Signed in as " + @properties['dmp_user']['name']  }
    verify { element_present?(:link, "Create plan").should be_true }
    @driver.find_element(:link, "Create plan").click
    verify { element_present?(:id, "no-funder").should be_true }
    @driver.find_element(:id, "no-funder").click
    verify { element_present?(:id, "create-plan-button").should be_true }
    @driver.find_element(:id, "create-plan-button").click
    
    !60.times{ break if (@driver.find_element(:id, "confirm-template").text == "University of Alberta Template" rescue false); sleep 1 }
    verify { (@driver.find_element(:xpath, "//*[@id='project-confirmation-dialog']/div[1]/p").text).should == "You are using the generic University of Alberta data management template. If you have suggestions on how to improve the existing template, or if you would like to add additional templates based on funding agency requirements or disciplinary needs, please contact us at data@ualberta.ca." }
    verify { (@driver.find_element(:xpath, "//*[@id='confirm-template']").text).should == "University of Alberta Template" }
    verify { element_present?(:id, "new-project-confirmed").should be_true }
    @driver.find_element(:id, "new-project-confirmed").click
    verify { (@driver.find_element(:css, "p.alert.alert-notice").text).should == "Project was successfully created." }
    @driver.find_element(:id, "project_title").clear
    @driver.find_element(:id, "project_title").send_keys "no one else could possibly have the same name as this"
    @driver.find_element(:name, "commit").click
    verify { (@driver.find_element(:css, "p.alert.alert-notice").text).should == "Project was successfully updated." }
  end

end
