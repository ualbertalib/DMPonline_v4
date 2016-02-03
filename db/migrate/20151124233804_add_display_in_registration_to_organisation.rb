class AddDisplayInRegistrationToOrganisation < ActiveRecord::Migration
  def change
    add_column :organisations, :display_in_registration, :boolean
  end
end
