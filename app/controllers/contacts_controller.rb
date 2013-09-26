class ContactsController < ContactUs::ContactsController	
	def create
		@contact = ContactUs::Contact.new(params[:contact_us_contact])
		if @contact.save
			flash[:notice] = t('contact_us.notices.success')
			if user_signed_in? then
		  		redirect_to :controller => 'projects', :action => 'index'
		  	else
		  		redirect_to(root_path)
		  	end
		else
		  	flash[:error] = t('contact_us.notices.error')
		  	render_new_page
		end
	end
end