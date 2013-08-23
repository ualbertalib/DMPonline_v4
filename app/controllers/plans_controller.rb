class PlansController < ApplicationController
	#Uncomment the line below in order to add authentication to this page - users without permission will not be able to add new plans
	#load_and_authorize_resource

	# GET /plans/1/edit
	def edit
		@plan = Plan.find(params[:id])
		if (! current_user.nil?) && @plan.can_read(current_user.id) then
			@plan.lock_all_sections(current_user.id)
		else
    		render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
    	end
	end

	# PUT /plans/1
	# PUT /plans/1.json
	def update
		@plan = Plan.find(params[:id])
		if (! current_user.nil?) && @plan.can_edit(current_user.id) then
			respond_to do |format|
			if @plan.update_attributes(params[:plan])
				format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @plan.errors, status: :unprocessable_entity }
			end
		end
    	else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
    	end
  	end
  
  	# GET /status/1.json
	def status
  		@plan = Plan.find(params[:id])
  		if (! current_user.nil?) && @plan.can_read(current_user.id) then
			respond_to do |format|
				format.json { render json: @plan.status }
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end
	
	def locked
  		@plan = Plan.find(params[:id])
  		if (! current_user.nil?) && @plan.can_read(current_user.id) then
			respond_to do |format|
				format.json { render json: @plan.locked(params[:section_id],current_user.id) }
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end
	
	def delete_recent_locks
		@plan = Plan.find(params[:id])
		if (! current_user.nil?) && @plan.can_edit(current_user.id) then
			respond_to do |format|
				if @plan.delete_recent_locks(current_user.id)
					format.html { render action: "edit" }
					format.json { head :no_content }
				else
					format.html { render action: "edit" }
					format.json { render json: @plan.errors, status: :unprocessable_entity }
				end
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end
	
	def unlock_all_sections
		@plan = Plan.find(params[:id])
		if (! current_user.nil?) && @plan.can_edit(current_user.id) then
			respond_to do |format|
				if @plan.unlock_all_sections(current_user.id)
					format.html { render action: "edit" }
					format.json { head :no_content }
				else
					format.html { render action: "edit" }
					format.json { render json: @plan.errors, status: :unprocessable_entity }
				end
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end
	
	def lock_section
		@plan = Plan.find(params[:id])
		if (! current_user.nil?) && @plan.can_edit(current_user.id) then
			respond_to do |format|
				if @plan.lock_section(params[:section_id], current_user.id)
					format.html { render action: "edit" }
					format.json { head :no_content }
				else
					format.html { render action: "edit" }
					format.json { render json: @plan.errors, status: :unprocessable_entity }
				end
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end
	
	def unlock_section
		@plan = Plan.find(params[:id])
		if (! current_user.nil?) && @plan.can_edit(current_user.id) then
			respond_to do |format|
				if @plan.unlock_section(params[:section_id], current_user.id)
					format.html { render action: "edit" }
					format.json { head :no_content }
				else
					format.html { render action: "edit" }
					format.json { render json: @plan.errors, status: :unprocessable_entity }
				end
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end
	
	def answer
  		@plan = Plan.find(params[:id])
  		if (! current_user.nil?) && @plan.can_read(current_user.id) then
			respond_to do |format|
				format.json { render json: @plan.answer(params[:q_id], false).to_json(:include => :options) }
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end
	
	def export
		@plan = Plan.find(params[:id])
		if (! current_user.nil?) && @plan.can_read(current_user.id) then
			respond_to do |format|
			  format.html { render action: "export" }
			  format.xml { render action: "export" }
			  format.json { render json: @plan.details }
			  format.text { render action: "export" }
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end
end
