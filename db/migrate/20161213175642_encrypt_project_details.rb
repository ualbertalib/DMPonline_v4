class EncryptProjectDetails < ActiveRecord::Migration
  def up
    rename_column :projects, :grant_number, :old_grant_number
    add_column :projects, :encrypted_grant_number, :string
    add_column :projects, :encrypted_grant_number_iv, :string
    rename_column :projects, :principal_investigator, :old_principal_investigator
    add_column :projects, :encrypted_principal_investigator, :string
    add_column :projects, :encrypted_principal_investigator_iv, :string
    rename_column :projects, :principal_investigator_identifier, :old_principal_investigator_identifier
    add_column :projects, :encrypted_principal_investigator_identifier, :string
    add_column :projects, :encrypted_principal_investigator_identifier_iv, :string
    rename_column :projects, :data_contact, :old_data_contact
    add_column :projects, :encrypted_data_contact, :string
    add_column :projects, :encrypted_data_contact_iv, :string
    rename_column :projects, :description, :old_description
    add_column :projects, :encrypted_description, :string
    add_column :projects, :encrypted_description_iv, :string
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

  def down
  end

end
