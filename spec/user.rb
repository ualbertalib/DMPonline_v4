require 'nokogiri'

module User

  def login_as_admin  
    login_as_user(@properties['admin_user']['name'], @properties['admin_user']['password'])    
  end
  
def create_a_new_user

    @driver.get(@base_url + "/")
    expect(@driver.title).to eq "DMP Builder - University of Alberta Libraries"
    @driver.find_element(:link, "Sign up").click
    @driver.find_element(:xpath, "(//input[@id='user_email'])[2]").clear
    @driver.find_element(:xpath, "(//input[@id='user_email'])[2]").send_keys @properties['dmp_user']['name'] 
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "user_organisation_id")).select_by(:text, "University of Alberta")
    @driver.find_element(:xpath, "(//input[@id='user_password'])[2]").clear
    @driver.find_element(:xpath, "(//input[@id='user_password'])[2]").send_keys @properties['dmp_user']['password'] 
    @driver.find_element(:id, "user_password_confirmation").clear
    @driver.find_element(:id, "user_password_confirmation").send_keys @properties['dmp_user']['password'] 
    @driver.find_element(:id, "user_accept_terms").click
    expect(element_present?(:xpath, "(//input[@name='commit'])[2]")).to be true
    @driver.find_element(:xpath, "(//input[@name='commit'])[2]").click
    !60.times{ break if (element_present?(:css, "p.alert.alert-notice") || element_present?(:css, "p.alert.alert-error") rescue false); sleep 1 }
    expect(@driver.find_element(:css, "p.alert.alert-notice").text).to eq "A message with a confirmation link has been sent to your email address. Please open the link to activate your account. If you do not receive the confirmation email, please check your spam filter." 

end

def get_invitation_url_from_email(date)
    link = get_url_from_email(date,'Invitation instructions')
    if link.include? 'http://dmpdev.library.ualberta.ca'
      link.gsub! 'http://dmpdev.library.ualberta.ca', 'https://dmp-server.local'
    end
    return link
end 

def get_confirmation_url_from_email(date)
    link = get_url_from_email(date,'Confirm your DMP Builder account')
    if link.include? 'http://dmpdev.library.ualberta.ca' 
      link.gsub! 'http://dmpdev.library.ualberta.ca', 'https://dmp-server.local'
    end
    return link
end

def get_url_from_email(date, subject)
    email =  @properties["email_user"]["name"]
    password =  @properties["email_user"]["password"]
    
    Mail.defaults do
      retriever_method :imap, :address => "imap.gmail.com",
                              :port    => 993,
                              :user_name => email,
                              :password => password,
                              :enable_ssl => true
    end
    mail = Mail.find(:what => :last, :delete_after_find => true, :count => 1, :keys => ['SUBJECT', subject,'SINCE', date.strftime("%d-%b-%Y")])
    expect(mail).not_to be_nil
    link = ''
    Nokogiri::HTML(mail.body.decoded).xpath('//a[@href]').each do |l|
      link = l["href"] if l["href"].include? 'token'
    end
    return link
end

def create_and_verify_user
    date = Time.now
    create_a_new_user
    sleep 15
    confirmation_url = get_confirmation_url_from_email(date)
    @driver.get(confirmation_url)
    login_as_user(@properties['dmp_user']['name'], @properties['dmp_user']['password']) 
    expect(@driver.find_element(:css, "a.dropdown-toggle").text).to eq "Signed in as " + @properties['dmp_user']['name'] 
end

def verify_invited_user(date)
    sleep 15
    invitation_url = get_invitation_url_from_email(date)
    @driver.get(invitation_url)
    @driver.find_element(:id, "user_password").clear
    @driver.find_element(:id, "user_password").send_keys "password"
    @driver.find_element(:id, "user_password_confirmation").clear
    @driver.find_element(:id, "user_password_confirmation").send_keys "password"
    @driver.find_element(:name, "commit").click
    expect(@driver.find_element(:css, "a.dropdown-toggle").text).to eq "Signed in as "+@properties['dmp_share_user']['name'] 
    @driver.find_element(:name, "commit").click
    expect(@driver.find_element(:css, "p.alert.alert-notice").text).to eq "Details successfully updated." 

end

def sign_out_user
    @driver.get(@base_url + "/")
    @driver.find_element(:css, "b.caret").click
    @driver.find_element(:link, "Sign out").click
end

def remove_previously_added_user(user)
    login_as_admin
    @driver.get(@base_url + "/admin/users")
    expect(element_present?(:link, @properties[user]['name'])).to be true 
    user = @driver.find_element(:link, @properties[user]['name']).find_element(:xpath, '../..')
    user.find_element(:link, "Delete").click
    expect(close_alert_and_get_its_text()).to start_with "Are you sure you want to delete this?"
    expect(@driver.find_element(:css, "div.flash.flash_notice").text).to eq "User was successfully destroyed." 
    sign_out_user
end



def login_as_user(name, password)
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Sign in").click
    @driver.find_element(:id, "user_email").clear
    @driver.find_element(:id, "user_email").send_keys name
    @driver.find_element(:id, "user_password").clear
    @driver.find_element(:id, "user_password").send_keys password
    @driver.find_element(:name, "commit").click


end
def verify_as_user(user)

    @driver.get(@base_url + "users/edit")
    expect(@driver.find_element(:css, "a.dropdown-toggle").text).to eq "Signed in as " + @properties[user]['name'] 

end

end
