module Settings
  class ProjectsController < SettingsController
    before_filter :get_project_list_columns

    def show
    end

    def update
      @selected_columns = params[:projects]
      # TODO: don't simply store in session - persist instead.
      session[:project_list_columns] = @selected_columns.keys.map(&:intern)

      respond_to do |format|
        format.html { redirect_to(projects_path) }
        format.json { @selected_columns.to_json }
      end
    end

  end
end
