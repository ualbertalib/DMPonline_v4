class ProjectsController < ApplicationController
	before_filter :get_plan_list_columns, only: %i( index )

	# GET /projects
	# GET /projects.json
	def index
		if user_signed_in? then
			if (current_user.shibboleth_id.nil? || current_user.shibboleth_id.length == 0) && !cookies[:show_shib_link].nil? && cookies[:show_shib_link] == "show_shib_link" then
				flash.notice = "#{t('helpers.notices.link_account_question')} #{view_context.link_to t('helpers.shibboleth_to_link_question'), user_omniauth_shibboleth_path}".html_safe
			end

			@projects = current_user.projects.filter(params[:filter])
			@has_projects = current_user.projects.any? # unfiltered count

			respond_to do |format|
				format.html # index.html.erb
				format.json { render json: @projects }
			end
		else
			respond_to do |format|
				format.html { redirect_to edit_user_registration_path }
			end
		end
	end

	# GET /projects/1
	# GET /projects/1.json
	def show
		@project = Project.find(params[:id])
		@show_form = false
		if params[:show_form] == "yes" then
			@show_form = true
		end
		if user_signed_in? && @project.readable_by(current_user.id) then
			respond_to do |format|
				format.html # show.html.erb
				format.json { render json: @project }
			end
		elsif user_signed_in? then
			respond_to do |format|
				format.html { redirect_to projects_url, notice: t('helpers.notices.account_no_access') }
			end
		else
			respond_to do |format|
				format.html { redirect_to edit_user_registration_path }
			end
		end
	end

	# GET /projects/new
	# GET /projects/new.json
	def new
		if user_signed_in? then
			@project = Project.new
			@project.organisation = current_user.organisation
			@funders = orgs_of_type((I18n.t 'helpers.org_type.funder',:locale => :en), true)
			@institutions = orgs_of_type(I18n.t 'helpers.org_type.institution', :locale => :en) + orgs_of_type(I18n.t 'helpers.org_type.organisation', :locale => :en)
			respond_to do |format|
			  format.html # new.html.erb
			  format.json { render json: @project }
			end
		else
			respond_to do |format|
				format.html { redirect_to edit_user_registration_path }
			end
		end
	end

	# GET /projects/1/edit
     # Should this be removed?
	def edit
		@project = Project.find(params[:id])
		if !user_signed_in? then
               respond_to do |format|
				format.html { redirect_to edit_user_registration_path }
			end
		elsif !@project.editable_by(current_user.id) then
			respond_to do |format|
				format.html { redirect_to projects_url, notice: I18n.t('helpers.notices.account_no_access') }
			end
		end
	end

	def share
		@project = Project.find(params[:id])
		if !user_signed_in? then
               respond_to do |format|
				format.html { redirect_to edit_user_registration_path }
			end
		elsif !@project.editable_by(current_user.id) then
			respond_to do |format|
				format.html { redirect_to projects_url, notice: I18n.t('helpers.notices.account_no_access') }
			end
		end
	end

	def export
		@project = Project.find(params[:id])
		if !user_signed_in? then
               respond_to do |format|
				format.html { redirect_to edit_user_registration_path }
			end
		else 
			respond_to do |format|
				format.html { render action: "export" }
                
			end
		end
	end

	# POST /projects
	# POST /projects.json
	def create
    	if user_signed_in? then
			@project = Project.new(params[:project])
                        # modified by wshi Jun 17, 2015 to remove checking funders when we don't have any funder in the system yet 
			#if @project.dmptemplate.nil? && params[:project][:funder_id] != "" then # this shouldn't be necessary - see setter for funder_id in project.rb
			#	funder = Organisation.find(params[:project][:funder_id])
			#	if funder.dmptemplates.count == 1 then
			#		@project.dmptemplate = funder.published_templates.first
			#	end
			#elsif @project.dmptemplate.nil? || params[:default_tag] == 'true' then
                        if @project.dmptemplate.nil? || params[:default_tag] == 'true' then
				if @project.organisation.nil?  || params[:default_tag] == 'true'  || @project.organisation.published_templates.first.nil? then
					@project.dmptemplate = Dmptemplate.find_by_is_default(true)
				else
					@project.dmptemplate = @project.organisation.published_templates.first
				end
			end
			@project.principal_investigator = current_user.name(false)
			@project.title = I18n.t('helpers.project.my_project_name')+' ('+@project.dmptemplate.title+')'
			@project.assign_creator(current_user.id)
			respond_to do |format|
				if @project.save
					format.html { redirect_to({:action => "show", :id => @project.slug, :show_form => "yes"}, {:notice => I18n.t('helpers.project.success')}) }
					format.json { render json: @project, status: :created, location: @project }
				else
					format.html { render action: "new" }
					format.json { render json: @project.errors, status: :unprocessable_entity }
				end
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end

	# PUT /projects/1
	# PUT /projects/1.json
	def update
		@project = Project.find(params[:id])
		if user_signed_in? && @project.editable_by(current_user.id) then
			respond_to do |format|
				if @project.update_attributes(params[:project])
					format.html { redirect_to @project, notice: I18n.t('helpers.notices.project_updated') }
					format.json { head :no_content }
				else
					format.html { render action: "edit" }
					format.json { render json: @project.errors, status: :unprocessable_entity }
				end
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end

	# DELETE /projects/1
	# DELETE /projects/1.json
	def destroy
		@project = Project.find(params[:id])
		if user_signed_in? && @project.editable_by(current_user.id) then
			@project.destroy

			respond_to do |format|
				format.html { redirect_to projects_url }
				format.json { head :no_content }
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end

	# GET /projects/possible_templates.json
	def possible_templates
		if !params[:funder].nil? && params[:funder] != "" && params[:funder] != "undefined" then
			funder = Organisation.find(params[:funder])
		else
			funder = nil
		end
		if !params[:institution].nil? && params[:institution] != "" && params[:institution] != "undefined" then
			institution = Organisation.find(params[:institution])
		else
			institution = nil
		end
		templates = []
                #added priorities to the returned value so that the hash can be sorted accordingly
                priorities = { "funder" => 1, "default"=>2, "portage" => 3, "published" => 4, "parent" => 5, "children" => 6}
		unless funder.nil? then
			funder.published_templates.each do |t|
				templates.push({ :id => t.id, :title => t.title, :priority=> priorities['funder'] })
			end
		end
		if templates.count == 0 && !institution.nil? 
                  if institution.name == "Portage"
                    templates.push({ :id => t.id, :title => t.title, :priority=> priorities['portage'] })
                  else
			institution.published_templates.each do |t|
                                if t.is_default
 				  templates.push({ :id => t.id, :title => t.title, :priority=> priorities['default'] })
 				else
				  templates.push({ :id => t.id, :title => t.title, :priority=> priorities['funder'] })
				end
			end
                        if !institution.parent.nil?
                          institution.parent.published_templates.each do |t|
                                templates.push ({ :id => t.id, :title => t.title, :priority=> priorities['parent'] })
                          end
                        end

			institution.children.each do |o|
				o.published_templates.each do |t|
					templates.push ({ :id => t.id, :title => t.title, :priority=> priorities['children'] })
				end
			end
                  end
		end
                templates = templates.sort_by { |t| t[:priority] }
		respond_to do |format|
			format.json { render json: templates.to_json }
		end
	end

	def possible_guidance
		if !params[:template].nil? && params[:template] != "" && params[:template] != "undefined" then
			template = Dmptemplate.find(params[:template])
		else
			template = nil
		end
		if !params[:institution].nil? && params[:institution] != "" && params[:institution] != "undefined" then
			institution = Organisation.find(params[:institution])
		else
			institution = nil
		end
		#excluded_orgs = orgs_of_type(I18n.t 'helpers.org_type.funder', :locale => :en) 
		guidance_groups = {}
		#ggs = GuidanceGroup.guidance_groups_excluding(excluded_orgs) 
	  	#ggs = GuidanceGroup.find_by_organisation(institution.id) 
                institution.published_guidance_groups.each do |gg|
			guidance_groups[gg.id] = gg.name
		end
        
                #subset guidance that belong to the institution
		unless institution.nil? then
			optional_gg = GuidanceGroup.where("optional_subset =  ? && organisation_id = ?", true, institution.id)
			optional_gg.each do|optional|
				guidance_groups[optional.id] = optional.name
			end
		end
        
        #If template belongs to a funder and that funder has subset guidance display then.
        if !template.nil? && template.organisation.organisation_type.name == t('helpers.org_type.funder') then
            optional_gg = GuidanceGroup.where("optional_subset =  ? && organisation_id = ?", true, template.organisation_id)
			optional_gg.each do|optional|
				guidance_groups[optional.id] = optional.name
			end
        end
        
        
		respond_to do |format|
			format.json { render json: guidance_groups.to_json }
		end
	end
	
	private

	def orgs_of_type(org_type_name, published_templates = false)
		org_type = OrganisationType.find_by_name(org_type_name)
		all_such_orgs = org_type.organisations
		if published_templates then
			with_published = Array.new
			all_such_orgs.each do |o|
				if o.published_templates.count > 0 then
					with_published << o
				end
			end
			return with_published.sort_by {|o| [o.sort_name, o.name] }
		else
			return all_such_orgs.sort_by {|o| [o.sort_name, o.name] }
		end
	end
end
