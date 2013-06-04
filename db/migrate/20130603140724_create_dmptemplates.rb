class CreateDmptemplates < ActiveRecord::Migration
  def change
    create_table :dmptemplates do |t|
      t.string :title
      t.text :description
      t.boolean :published

      t.timestamps
    end
  end
end
