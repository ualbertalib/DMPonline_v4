class EncryptProjectDetails < ActiveRecord::Migration
  def change
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
  end

end
