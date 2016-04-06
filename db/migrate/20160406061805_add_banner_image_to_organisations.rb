class AddBannerImageToOrganisations < ActiveRecord::Migration
  def change
    add_column :organisations, :banner_uid, :string
    add_column :organisations, :banner_name, :string
  end
end
