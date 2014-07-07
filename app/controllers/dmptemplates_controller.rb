class DmptemplatesController < ApplicationController
	
  # GET /dmptemplates
  # GET /dmptemplates.json
  def admin_index
    if user_signed_in? && current_user.is_org_admin? then
	    @dmptemplates_own = Dmptemplate.where("organisation_id = ?", current_user.organisation_id)
	    
	    new_org_obejcts = OrganisationType.find_by_name(I18n.t("helpers.org_type.funder")).organisations
	    org_templates = Array.new
   		new_org_obejcts.each do |neworg|
       	org_templates += neworg.dmptemplates
     end
     @dmptemplates = org_templates
    	
     respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @dmptemplates_own }
	    end
    else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end 
  end

  # GET /dmptemplates/1
  # GET /dmptemplates/1.json
  def admin_show
    if user_signed_in? && current_user.is_org_admin? then
	    @dmptemplate = Dmptemplate.find(params[:id])
	
	    respond_to do |format|
	      format.html # show.html.erb
	      format.json { render json: @dmptemplate }
	    end
    else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end 
  end

	#show a phase	
	def admin_showphase
		if user_signed_in? && current_user.is_org_admin? then
			@phase = Phase.find(params[:id])
		
		 	respond_to do |format|
	      format.html 
	    	format.json { render json: @phase }
	    end
    else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end 
	end
	
	
	#add a new phase to a template
	def admin_addphase
		if user_signed_in? && current_user.is_org_admin? then
			@phase = Phase.new
			
			respond_to do |format|
	      format.html 
	    	format.json { render json: @phase }
	    end
		end
	end
	
	
	#edit a phase of the template
	def  admin_editphase
		if user_signed_in? && current_user.is_org_admin? then
			@phase = Phase.find(params[:id])
			
			
						
			respond_to do |format|
				format.html
				format.json {render json: @phase}
			end
		end	
	end
	
	
	#update a phase of a template
	def admin_updatephase
		if user_signed_in? && current_user.is_org_admin? then
   		@phase = Phase.find(params[:id])
   			

	    respond_to do |format|
	      if @phase.update_attributes(params[:phase])
	        format.html { redirect_to admin_showphase_dmptemplate_path(params[:phase]), notice: I18n.t('org_admin.templates.updated_message') }
	        format.json { head :no_content }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @dmptemplate.errors, status: :unprocessable_entity }
	      end
	    end
		end
	end

  # GET /dmptemplates/new
  # GET /dmptemplates/new.json
  def admin_new
    if user_signed_in? && current_user.is_org_admin? then
	    @dmptemplate = Dmptemplate.new
	
	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @dmptemplate }
	    end
    else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end 
  end

  # GET /dmptemplates/1/edit
  def admin_edit
  	if user_signed_in? && current_user.is_org_admin? then
      @dmptemplate = Dmptemplate.find(params[:id])
    else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end 
  end

  # POST /dmptemplates
  # POST /dmptemplates.json
  def admin_create
    if user_signed_in? && current_user.is_org_admin? then
	    @dmptemplate = Dmptemplate.new(params[:dmptemplate])
	       	
	
	    respond_to do |format|
	      if @dmptemplate.save
	        format.html { redirect_to admin_show_dmptemplate_path(@dmptemplate), notice: I18n.t('org_admin.templates.created_message') }
	        format.json { render json: @dmptemplate, status: :created, location: @dmptemplate }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @dmptemplate.errors, status: :unprocessable_entity }
	      end
	    end
    else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end 
  end

  # PUT /dmptemplates/1
  # PUT /dmptemplates/1.json
  def admin_update
 		if user_signed_in? && current_user.is_org_admin? then
   		@dmptemplate = Dmptemplate.find(params[:id])
   			

	    respond_to do |format|
	      if @dmptemplate.update_attributes(params[:dmptemplate])
	        format.html { redirect_to admin_show_dmptemplate_path(params[:dmptemplate]), notice: I18n.t('org_admin.templates.updated_message') }
	        format.json { head :no_content }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @dmptemplate.errors, status: :unprocessable_entity }
	      end
	    end
    else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end 
  end


  # DELETE /dmptemplates/1
  # DELETE /dmptemplates/1.json
  def admin_destroy
  	if user_signed_in? && current_user.is_org_admin? then
	   	@dmptemplate = Dmptemplate.find(params[:id])
	    @dmptemplate.destroy
	
	    respond_to do |format|
	      format.html { redirect_to admin_index_dmptemplate_path }
	      format.json { head :no_content }
	    end
	 	else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end 
	
	end
	
  
  
end