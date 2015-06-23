module Plan

def destroy_plan

    login_as_admin
    # destroy plan
    @driver.get(@base_url + "/admin/projects")
    expect(@driver.find_element(:css, "td.title").text).to eq @properties['dmp_plan']['name']
    dmp_plan = @driver.find_element(:xpath, "//td[text()='#{@properties['dmp_plan']['name']}']").find_element(:xpath, '..')
    dmp_plan.find_element(:link, "Delete").click
    expect(close_alert_and_get_its_text()).to start_with "Are you sure you want to delete this"
    expect(@driver.find_element(:css, "div.flash.flash_notice").text).to eq "Project was successfully destroyed."
    sign_out_user

end

def create_and_verify_plan
    
    verify_as_user('dmp_user')
    puts "user verified"
    create_a_new_plan
    puts "plan created"
    @driver.find_element(:id, "project_title").clear
    @driver.find_element(:id, "project_title").send_keys @properties['dmp_plan']['name']
    @driver.find_element(:name, "commit").click
    expect(@driver.find_element(:css, "p.alert.alert-notice").text).to eq "Project was successfully updated."
end



def create_a_new_plan
    expect(element_present?(:link, "Create plan")).to be true
    @driver.find_element(:link, "Create plan").click
    # expect(element_present?(:id, "no-funder")).to be true
    # @driver.find_element(:id, "no-funder").click
    expect(element_present?(:id, "create-plan-button")).to be true
    @driver.find_element(:id, "create-plan-button").click
    !60.times{ break if (@driver.find_element(:id, "confirm-template").text == "University of Alberta Template" rescue false); sleep 1 }
    expect(@driver.find_element(:xpath, "//*[@id='project-confirmation-dialog']/div[1]/p").text).to eq "You are using the generic University of Alberta data management template. If you have suggestions on how to improve the existing template, or if you would like to add additional templates based on funding agency requirements or disciplinary needs, please contact us at data@ualberta.ca." 
    expect(@driver.find_element(:xpath, "//*[@id='confirm-template']").text).to eq "University of Alberta Template"
    expect(element_present?(:id, "new-project-confirmed")).to be true
    expect(element_present?(:id, "new-project-confirmed")).to be true
    @driver.find_element(:id, "new-project-confirmed").click
    expect(@driver.find_element(:css, "p.alert.alert-notice").text).to eq "Plan was successfully created." 
end

def share_plan(access_level)
    expect(element_present?(:link, "My plans")).to be true
    @driver.find_element(:link, "My plans").click
    expect(@driver.find_element(:link, @properties['dmp_plan']['name']).text).to eq @properties['dmp_plan']['name'] 
    expect(element_present?(:link, "Share")).to be true 
    @driver.find_element(:link, "Share").click
    @driver.find_element(:id, "project_group_email").clear
    @driver.find_element(:id, "project_group_email").send_keys @properties['dmp_share_user']['name']
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "project_group_access_level")).select_by(:text, access_level)
    @driver.find_element(:name, "commit").click
    !60.times{ break if (element_present?(:css, "p.alert.alert-notice") || element_present?(:css, "p.alert.alert-error") rescue false); sleep 1 }
    expect(@driver.find_element(:css, "p.alert.alert-notice").text).to eq "Invitation issued successfully." 
    sign_out_user
    
end

def verify_shared_plan(access_level)
    verify_as_user('dmp_share_user')
    expect(element_present?(:link, "My plans")).to be true
    @driver.find_element(:link, "My plans").click

    expect(element_present?(:link, @properties['dmp_plan']['name'])).to be true 
    expect(@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Export"]').text).to eq "Export"
       
    if (access_level == "Read only" )
       expect(@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="View"]').text).to eq "View"
       expect {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Edit"]').to raise_error(Selenium::WebDriver::Error::NoSuchElementError)}
       expect {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Delete"]').to raise_error(Selenium::WebDriver::Error::NoSuchElementError)}
       expect {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Share"]').to raise_error(Selenium::WebDriver::Error::NoSuchElementError)}

    elsif (access_level == "Edit")
       expect(@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Edit"]').text).to eq "Edit"
       expect {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="View"]').to raise_error(Selenium::WebDriver::Error::NoSuchElementError)}
       expect {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Delete"]').to raise_error(Selenium::WebDriver::Error::NoSuchElementError)}
       expect {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Share"]').to raise_error(Selenium::WebDriver::Error::NoSuchElementError)}
    else
       expect(@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Delete"]').text).to eq "Delete"
       expect(@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Edit"]').text).to eq "Edit"
       expect(@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="Share"]').text).to eq "Share"
       expect {@driver.find_element(:link, @properties['dmp_plan']['name']).find_element(:xpath, '../..//a[text()="View"]').to raise_error(Selenium::WebDriver::Error::NoSuchElementError)}

    end
   
end

def share_and_verify_plan(access_level)
    date = Time.now
    share_plan(access_level)
    verify_invited_user(date)
    verify_shared_plan(access_level)
    sign_out_user
end


def visit_export_page
    @driver.get(@base_url + "/projects")
    expect(@driver.find_element(:link, @properties['dmp_plan']['name']).text).to eq @properties['dmp_plan']['name']
    @driver.find_element(:link, "Export").click
 
end

def get_plan_section_headings
    @driver.get(@base_url + "/projects")
    @driver.find_element(:link, "Edit").click
    @driver.find_elements(:class, "dmp_th_border").map{|e| e.text }
end

def edit_plan
    @driver.find_element(:link, "My plans").click
    @driver.find_element(:link, "Edit").click
    expect(element_present?(:link, "Edit plan details")).to be true
    @driver.find_element(:link, "Edit plan details").click
    @driver.find_element(:id, "project_principal_investigator").clear
    @driver.find_element(:id, "project_principal_investigator").send_keys "Dit Test"
    @driver.find_element(:name, "commit").click
    expect (@driver.find_element(:css, "p.alert.alert-notice").text).to eq "Project was successfully updated." 
    puts("now editing answers")

    @driver.find_element(:link, "University of Alberta Data Management Questions").click
    tinymce_frame = @driver.find_elements(:xpath, "//div[@class='question-div']//iframe[starts-with(@id, 'answer-text-')]")
    current_status = "0/" + tinymce_frame.size.to_s
    expect(@driver.find_element(:id, "questions-progress-title").text).to include current_status
    @driver.find_element(:xpath, "//a[contains(@href, '#collapse-1')]").click
    iframe = @driver.find_element(:id, "answer-text-3_ifr")
    @driver.find_element(:xpath, "//a[contains(@href, '#collapse-guidance-3')]").click
    puts("now switch to iframe")

    @driver.switch_to.frame(iframe)
    editor_body = @driver.find_element(:css => "body")
    @driver.execute_script("arguments[0].innerHTML = '<h3>Sample Answer</h3>DIT Test'", editor_body)
    @driver.switch_to.default_content
    expect(@driver.find_element(:id, "3-status").text).to eq "Not answered yet" 
    save_button=@driver.find_element(:xpath, "//div[@id='question-form-3']//input[@value='Save']") 
    save_button.click
  
    sleep 30
    save_button.click


    @driver.find_element(:link, "My plans").click
    expect(@driver.find_element(:link, @properties['dmp_plan']['name']).text).to eq @properties['dmp_plan']['name'] 
    @driver.find_element(:link, @properties['dmp_plan']['name']).click
    expect(@driver.find_element(:css, "table.dmp_details_table").find_element(:xpath, "//td[contains(text(), 'Principal Investigator/Researcher')]").find_element(:xpath, "../td[not(@class)]").text).to eq "Dit Test"
    @driver.find_element(:link, "University of Alberta Data Management Questions").click
    answer_status = @driver.find_element(:xpath, "//abbr[@class='timeago']").find_element(:xpath, "..")
    expect(answer_status.attribute("innerHTML")).to include @properties['dmp_user']['name']
    progress_status = "1/" + tinymce_frame.size.to_s
    expect(@driver.find_element(:id, "questions-progress-title").text).to include progress_status

end

def delete_plan

    expect(element_present?(:link, "My plans")).to be true 
    @driver.find_element(:link, "My plans").click
    expect(@driver.find_element(:link, @properties['dmp_plan']['name']).text).to eq @properties['dmp_plan']['name'] 
    expect(element_present?(:link, "Delete")).to be true 
    @driver.find_element(:link, "Delete").click
    expect(close_alert_and_get_its_text()).to eq "Are you sure you wish to delete this plan? If the plan is being shared with other users, by deleting it from your list, the plan will be deleted from their plan list as well"
    expect { (@driver.find_element(:link, @properties['dmp_plan']['name'])).to raise_error (Selenium::WebDriver::Error::NoSuchElementError) }
end

end
