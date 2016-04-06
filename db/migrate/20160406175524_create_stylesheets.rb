class CreateStylesheets < ActiveRecord::Migration
  def up
    create_table :stylesheets do |t|
	t.string :file_uid
	t.string :file_name
	t.integer :organisation_id
  	t.timestamps
    end
  end

  def down
    drop_table :stylesheets
  end
end
