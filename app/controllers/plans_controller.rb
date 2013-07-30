class PlansController < ApplicationController
  #Uncomment the line below in order to add authentication to this page - users without permission will not be able to add new plans
  #load_and_authorize_resource

  # GET /plans
  # GET /plans.json
  def index
    @plans = Plan.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plans }
    end
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    @plan = Plan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plan }
    end
  end

  # GET /plans/new
  # GET /plans/new.json
  def new
    @plan = Plan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plan }
    end
  end

  # GET /plans/1/edit
  def edit
    @plan = Plan.find(params[:id])
    @plan.lock_all_sections(current_user)
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(params[:plan])

    respond_to do |format|
      if @plan.save
        format.html { render action: "edit" }
        format.json { render json: @plan, status: :created, location: @plan }
      else
        format.html { render action: "new" }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /plans/1
  # PUT /plans/1.json
  def update
    @plan = Plan.find(params[:id])

    respond_to do |format|
      if @plan.update_attributes(params[:plan])
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy

    respond_to do |format|
      format.html { redirect_to plans_url }
      format.json { head :no_content }
    end
  end
  
  	# GET /status/1.json
	def status
  		@plan = Plan.find(params[:id])
		respond_to do |format|
			format.json { render json: @plan.status }
		end
	end
	
	def locked
  		@plan = Plan.find(params[:id])
		respond_to do |format|
			format.json { render json: @plan.locked(params[:section_id]) }
		end
	end
	
	def delete_recent_locks
		@plan = Plan.find(params[:id])
				user_id = nil
		if current_user.nil?
			user_id = nil
		else
			user_id = current_user.id
		end
		respond_to do |format|
			if @plan.delete_recent_locks(user_id)
				format.html { render action: "edit" }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @plan.errors, status: :unprocessable_entity }
			end
		end
	end
	
	def unlock_all_sections
		@plan = Plan.find(params[:id])
				user_id = nil
		if current_user.nil?
			user_id = nil
		else
			user_id = current_user.id
		end
		respond_to do |format|
			if @plan.unlock_all_sections(user_id)
				format.html { render action: "edit" }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @plan.errors, status: :unprocessable_entity }
			end
		end
	end
	
	def lock_section
		@plan = Plan.find(params[:id])
		user_id = nil
		if current_user.nil?
			user_id = nil
		else
			user_id = current_user.id
		end
		respond_to do |format|
			if @plan.lock_section(params[:section_id], user_id)
				format.html { render action: "edit" }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @plan.errors, status: :unprocessable_entity }
			end
		end
	end
	
	def unlock_section
		@plan = Plan.find(params[:id])
		user_id = nil
		if current_user.nil?
			user_id = nil
		else
			user_id = current_user.id
		end
		respond_to do |format|
			if @plan.unlock_section(params[:section_id], user_id)
				format.html { render action: "edit" }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @plan.errors, status: :unprocessable_entity }
			end
		end
	end
end
