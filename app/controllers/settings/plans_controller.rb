module Settings
  class PlansController < SettingsController

    before_filter :get_settings

    def show
      respond_to do |format|
        format.html
        format.json { render json: settings_json }
      end
    end

    def update
      settings = plan.super_settings(:export).tap do |s|
        s.formatting = if params[:commit] != 'Reset'
          params[:export].try(:deep_symbolize_keys)
        else
          nil
        end
      end

      if settings.save
        respond_to do |format|
          format.html { redirect_to(export_project_path(plan.project)) }
          format.json { render json: settings_json }
        end
      else
        settings.formatting = nil
        @export_settings = settings
        render(action: :show)
      end
    end

  private

    def get_settings
      @export_settings = plan.settings(:export)
    end

    def settings_json
      @settings_json ||= { export: @export_settings }.to_json
    end

    def plan
      @plan ||= Plan.find(params[:id])
    end

  end
end
