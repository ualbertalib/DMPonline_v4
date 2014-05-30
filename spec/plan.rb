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
    verify { (@driver.find_element(:link, @properties['dmp_plan']['name']).text).should == @properties['dmp_plan']['name'] }
    verify { element_present?(:link, "Share").should be_true }
    @driver.find_element(:link, "Share").click
    @driver.find_element(:id, "project_group_email").clear
    @driver.find_element(:id, "project_group_email").send_keys @properties['dmp_share_user']['name']
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "project_group_access_level")).select_by(:text, access_level)
    @driver.find_element(:name, "commit").click
    !60.times{ break if (element_present?(:css, "p.alert.alert-notice") || element_present?(:css, "p.alert.alert-error") rescue false); sleep 1 }
    verify { (@driver.find_element(:css, "p.alert.alert-notice").text).should == "Invitation issued successfully." }
    sign_out_user
    
end

def verify_shared_plan(access_level)
    verify_as_user('dmp_share_user')
    verify{element_present?(:link, "My plans").should be_true}
    @driver.find_element(:link, "My plans").click

    verify { element_present?(:link, @properties['dmp_plan']['name']).should be_true }
    verify {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Export"]').text.should == "Export"}
       
    if (access_level == "Read only" )
       verify {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="View"]').text.should == "View"}
       expect {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Edit"]').to raise_error(Selenium::WebDriver::Error::NoSuchElementError)}
       expect {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Delete"]').to raise_error(Selenium::WebDriver::Error::NoSuchElementError)}
       expect {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Share"]').to raise_error(Selenium::WebDriver::Error::NoSuchElementError)}

    elsif (access_level == "Edit")
       verify {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Edit"]').text.should == "Edit"}
       expect {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="View"]').to raise_error(Selenium::WebDriver::Error::NoSuchElementError)}
       expect {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Delete"]').to raise_error(Selenium::WebDriver::Error::NoSuchElementError)}
       expect {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Share"]').to raise_error(Selenium::WebDriver::Error::NoSuchElementError)}
    else
       verify {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Delete"]').text.should == "Delete"}
       verify {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Edit"]').text.should == "Edit"}
       verify {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Share"]').text.should == "Share"}
       expect {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="View"]').to raise_error(Selenium::WebDriver::Error::NoSuchElementError)}

    end
   
end

def share_and_verify_plan(access_level)
    create_and_verify_user
    create_and_verify_plan
    share_plan(access_level)
    verify_invited_user
    verify_shared_plan(access_level)
    sign_out_user
    destroy_plan
    remove_previously_added_user('dmp_user')
    remove_previously_added_user('dmp_share_user')
end


def visit_export_page
    @driver.get(@base_url + "/projects")
    (@driver.find_element(:link, @properties['dmp_plan']['name']).text).should == @properties['dmp_plan']['name']
    @driver.find_element(:link, "Export").click
end

def edit_plan
    @driver.find_element(:link, "My plans").click
    @driver.find_element(:link, "Edit").click
    verify {element_present?(:link, "Edit plan details").should be_true}
    @driver.find_element(:link, "Edit plan details").click
    @driver.find_element(:id, "project_principal_investigator").clear
    @driver.find_element(:id, "project_principal_investigator").send_keys "Dit Test"
    @driver.find_element(:name, "commit").click

    @driver.find_element(:link, "Answer questions").click
    verify (@driver.find_element(:xpath, "//div[@class='progress']/span").text.should == "No questions have been answered")

    @driver.find_element(:xpath, "//div[@id='sections-accordion']/div/div/a/span").click
    @driver.find_element(:css, "span.plus-laranja").click

    verify(@driver.find_element(:css, "span.label.label-warning.answer-status").text.should == "Not answered yet")
    tinymce_frame = @driver.find_element(:xpath, "//div[@class='question-div']//iframe[starts-with(@id, 'answer-text-')]")
    @driver.switch_to.frame(tinymce_frame)
    @driver.find_element(:tag_name, 'body').send_keys ("<p>Sample Answer. </p>")
    @driver.find_element(:xpath, "//*[@id='answer_submit_action']/input").click
    verify(@driver.find_element(:css, "span.label.answer-status.label-success").text.should include @properties['dmp_user']['name'])
    verify (@driver.find_element(:id, "questions-progress").text.should == "1/19")

end

def delete_plan

    verify {element_present?(:link, "My plans").should be_true }
    @driver.find_element(:link, "My plans").click
    verify { (@driver.find_element(:link, @properties['dmp_plan']['name']).text).should == @properties['dmp_plan']['name'] }
    verify { element_present?(:link, "Delete").should be_true }
    @driver.find_element(:link, "Delete").click
    close_alert_and_get_its_text().should =~ /^Are you sure you want to delete this[\s\S]$/
    verify { (@driver.find_element(:css, "div.flash.flash_notice").text).should == "Project was successfully destroyed." }
    expect { (@driver.find_element(:link, @properties['dmp_plan']['name'])).to raise_error (Selenium::WebDriver::Error::NoSuchElementError) }
end

end