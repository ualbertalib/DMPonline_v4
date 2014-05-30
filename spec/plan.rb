module Plan

def destroy_plan

    login_as_admin
    # destroy plan
    @driver.get(@base_url + "/admin/projects")
    verify { (@driver.find_element(:css, "td.title").text).should == @properties['dmp_plan']['name'] }
    dmp_plan = @driver.find_element(:xpath, "//td[text()='#{@properties['dmp_plan']['name']}']").find_element(:xpath, '..')
    dmp_plan.find_element(:link, "Delete").click
    close_alert_and_get_its_text().should =~ /^Are you sure you want to delete this[\s\S]$/
    verify { (@driver.find_element(:css, "div.flash.flash_notice").text).should == "Project was successfully destroyed." }
    sign_out_user

end

def create_and_verify_plan
    verify_as_user('dmp_user')
    create_a_new_plan
    @driver.find_element(:id, "project_title").clear
    @driver.find_element(:id, "project_title").send_keys @properties['dmp_plan']['name']
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
    !60.times{ break if (@driver.find_element(:id, "confirm-template").text == "University of Alberta Template" rescue false); sleep 1 }
    verify { (@driver.find_element(:xpath, "//*[@id='project-confirmation-dialog']/div[1]/p").text).should == "You are using the generic University of Alberta data management template. If you have suggestions on how to improve the existing template, or if you would like to add additional templates based on funding agency requirements or disciplinary needs, please contact us at data@ualberta.ca." }
    verify { (@driver.find_element(:xpath, "//*[@id='confirm-template']").text).should == "University of Alberta Template" }
    verify { element_present?(:id, "new-project-confirmed").should be_true }
    verify { element_present?(:id, "new-project-confirmed").should be_true }
    @driver.find_element(:id, "new-project-confirmed").click
    verify { (@driver.find_element(:css, "p.alert.alert-notice").text).should == "Project was successfully created." }
end

def share_plan(access_level)
    verify {element_present?(:link, "My plans").should be_true }
    @driver.find_element(:link, "My plans").click
    verify { (@driver.find_element(:link, "no one else could possibly have the same name as this except Tricia").text).should == "no one else could possibly have the same name as this except Tricia" }
    verify { element_present?(:link, "Share").should be_true }
    @driver.find_element(:link, "Share").click
    @driver.find_element(:id, "project_group_email").clear
    @driver.find_element(:id, "project_group_email").send_keys @properties['dmp_share_user']['name']
    #select = @driver.find_element(:id, "project_group_access_level")
    #all_options = select.find_element(:tag_name, "option")
    #all_options.each do |option|
    #    puts "Value is: " + option.attribute("value")
    #    if option.attribute("value") == access_level
    #        option.click
    #    end
    #end

    #@driver.find_element(:id, "project_group_access_level").find_element(:tag_name, "option").find do |option| option.text==access_level end.click
    @driver.find_element(:name, "commit").click
    verify { (@driver.find_element(:css, "p.alert.alert-notice").text).should == "Invitation issued successfully." }
    sign_out_user
    
end

def verify_shared_plan(access_level)
    verify_as_user('dmp_share_user')
    verify{element_present?(:link, "My plans").should be_true}
    @driver.find_element(:link, "My plans").click
    puts "before verify links"
    puts access_level
    verify {element_present?(:xpath, "//td[contains(text(),'no one else could possibly have the same name as this except Tricia')]//a.dmp_table_link[text()='View']")}
    verify {element_present?(:xpath, "//td[contains(text(),'no one else could possibly have the same name as this except Tricia')]//a.dmp_table_link[text()='Export']")}
    verify {element_present?(:xpath, "//td[contains(text(),'no one else could possibly have the same name as this except Tricia')]//a.dmp_table_link[text()='Share']")}
    verify {element_present?(:xpath, "//td[contains(text(),'no one else could possibly have the same name as this except Tricia')]//a.dmp_table_link[text()='Edit']")}
    puts "check if links don't exist"
    #if (access_level == "Read Only" )

     #   expect {verify {element_present?(:xpath, "//td[contains(text(),'no one else could possibly have the same name as this except Tricia')]//a.dmp_table_link[text()='Share']")}}.to raise_error(Selenium::WebDriver::Error::NoSuchElementError)
      #  expect {verify {element_present?(:xpath, "//td[contains(text(),'no one else could possibly have the same name as this except Tricia')]//a.dmp_table_link[text()='Edit']")}}.to raise_error(Selenium::WebDriver::Error::NoSuchElementError)
    #else 
    #    puts (access_level)
    #end
   
end

def share_and_verify_plan(access_level)
    create_and_verify_plan
    share_plan(access_level)
    verify_invited_user
    verify_shared_plan(access_level)
    sign_out_user
    #destroy_plan
    remove_previously_added_user('dmp_user')
    remove_previously_added_user('dmp_share_user')
end


def visit_export_page
    @driver.get(@base_url + "/projects")
    (@driver.find_element(:link, @properties['dmp_plan']['name']).text).should == @properties['dmp_plan']['name']
    @driver.find_element(:link, "Export").click
end


end