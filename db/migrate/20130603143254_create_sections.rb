class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :title
      t.text :description
      t.integer :published
      t.integer :order
      t.references :version

      t.timestamps
    end
    add_index :sections, :version_id
  end
end
