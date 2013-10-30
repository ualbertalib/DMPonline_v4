ActiveAdmin.register Section do

	index do   # :organisation_id, :description, :number, :title, :version_id
  	column :title , :sortable => :title do |section|
        link_to section.title, [:admin, section]
    end
    column I18n.t('admin.template_title'), :sortable => :section_id do |dmptemplate|
        link_to dmptemplate.version.phase.dmptemplate.title, [:admin, dmptemplate.version.phase.dmptemplate]
    end
    column I18n.t('admin.org_title'), :sortable => :organisation_id do |org_title|
        link_to org_title.organisation.name, [:admin, org_title.organisation]
    end
  	
  	default_actions
  end
end
