ActiveAdmin.register Version do

	index do   # :description, :number, :published, :title, :phase_id
  	column I18n.t('admin.title'), :sortable => :title  do |version_used|
        link_to version_used.title, [:admin, version_used]
    end
    column I18n.t('admin.desc'),:description 
    column I18n.t('admin.version_numb'), :number
		column :published, :sortable => :published do |v_published|
			if (v_published.published == 1)
				'Yes'
			else
				'No'	
			end
		end
		column I18n.t('admin.phase_title'), :sortable => :phase_id do |version_phase|
        link_to version_phase.phase.title, version_phase.phase
    end
   
  	
  	default_actions
  end

end
