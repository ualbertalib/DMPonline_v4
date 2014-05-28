module Plan

def destroy_plan

    login_as_admin
    # destroy plan
    @driver.get(@base_url + "/admin/projects")
    verify { (@driver.find_element(:css, "td.title").text).should == "no one else could possibly have the same name as this" }
    dmp_plan = @driver.find_element(:xpath, "//td[contains(text(),'no one else could possibly have the same name as this')]").find_element(:xpath, '../..')
    dmp_plan.find_element(:link, "Delete").click
    close_alert_and_get_its_text().should =~ /^Are you sure you want to delete this[\s\S]$/
    verify { (@driver.find_element(:css, "div.flash.flash_notice").text).should == "Project was successfully destroyed." }
    sign_out_user

end

def create_and_verify_plan
    verify_as_user
    create_a_new_plan
    @driver.find_element(:id, "project_title").clear
    @driver.find_element(:id, "project_title").send_keys "no one else could possibly have the same name as this"
    @driver.find_element(:name, "commit").click
    verify { (@driver.find_element(:css, "p.alert.alert-notice").text).should == "Project was successfully updated." }
end



def create_a_new_plan
    verify { element_present?(:link, "Create plan").should be_true }
    @driver.find_element(:link, "Create plan").click
    verify { element_present?(:id, "no-funder").should be_true }
    @driver.find_element(:id, "no-funder").click
    verify { element_present?(:id, "create-plan-button").should be_true }
    @driver.find_element(:id, "create-plan-button").click
    #verify { (@driver.find_element(:css, "div.modal-header > p").text).should == "You are using the generic University of Alberta data management template. If you have suggestions on how to improve the existing template, or if you would like to add additional templates based on funding agency requirements or disciplinary needs, please contact us at data@ualberta.ca." }
    #verify { (@driver.find_element(:xpath, "//div[@id='project-confirmation-dialog']/div[2]/div[3]/p").text).should == "Template: University of Alberta Template" }
    verify { element_present?(:id, "new-project-confirmed").should be_true }
    @driver.find_element(:id, "new-project-confirmed").click
    verify { (@driver.find_element(:css, "p.alert.alert-notice").text).should == "Project was successfully created." }
end

  
end