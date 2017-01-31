class MigrateProjectData < ActiveRecord::Migration
  def change
    Project.find_each do |a|
      a.grant_number = a.old_grant_number
      a.principal_investigator = a.old_principal_investigator
      a.principal_investigator_identifier = a.old_principal_investigator_identifier
      a.data_contact = a.old_data_contact
      a.description = a.old_description
      a.save
    end
    remove_column :projects, :old_grant_number
    remove_column :projects, :old_principal_investigator_identifier
    remove_column :projects, :old_principal_investigator
    remove_column :projects, :old_data_contact
    remove_column :projects, :old_description

  end
end
