class GuidancesController < ApplicationController
	
  # GET /guidances
  # GET /guidances.json
  def admin_index
    if user_signed_in? && current_user.is_org_admin? then
	    @guidances = Guidance.all
	    @guidance_groups = GuidanceGroup.where('organisation_id = ?', current_user.organisation_id )
	    
	
	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @guidances }
	    end
    else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end 
  end

  # GET /guidances/1
  # GET /guidances/1.json
  def admin_show
    if user_signed_in? && current_user.is_org_admin? then
	    @guidance = Guidance.find(params[:id])
	
	    respond_to do |format|
	      format.html # show.html.erb
	      format.json { render json: @guidance }
	    end
    else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end 
  end

  # GET /guidances/new
  # GET /guidances/new.json
  def admin_new
    if user_signed_in? && current_user.is_org_admin? then
	    @guidance = Guidance.new
	
	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @guidance }
	    end
    else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end 
  end

  # GET /guidances/1/edit
  def admin_edit
  	if user_signed_in? && current_user.is_org_admin? then
      @guidance = Guidance.find(params[:id])
    else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end 
  end

  # POST /guidances
  # POST /guidances.json
  def admin_create
    if user_signed_in? && current_user.is_org_admin? then
	    @guidance = Guidance.new(params[:guidance])
	
	    respond_to do |format|
	      if @guidance.save
	        format.html { redirect_to admin_show_guidance_path(@guidance), notice: I18n.t('org_admin.guidance.created_message') }
	        format.json { render json: @guidance, status: :created, location: @guidance }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @guidance.errors, status: :unprocessable_entity }
	      end
	    end
    else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end 
  end

  # PUT /guidances/1
  # PUT /guidances/1.json
  def admin_update
 		if user_signed_in? && current_user.is_org_admin? then
   		@guidance = Guidance.find(params[:id])

	    respond_to do |format|
	      if @guidance.update_attributes(params[:guidance])
	        format.html { redirect_to admin_show_guidance_path(params[:guidance]), notice: I18n.t('org_admin.guidance.updated_message') }
	        format.json { head :no_content }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @guidance.errors, status: :unprocessable_entity }
	      end
	    end
    else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end 
  end


  # DELETE /guidances/1
  # DELETE /guidances/1.json
  def admin_destroy
  	if user_signed_in? && current_user.is_org_admin? then
	   	@guidance = Guidance.find(params[:id])
	    @guidance.destroy
	
	    respond_to do |format|
	      format.html { redirect_to admin_index_guidance_path }
	      format.json { head :no_content }
	    end
	 	else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end 
	
	end
  
  
end