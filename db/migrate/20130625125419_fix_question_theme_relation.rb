class FixQuestionThemeRelation < ActiveRecord::Migration
  def self.up
  	drop_table :question_themes
    create_table :questions_themes, :id => false do |t|
	  t.references :question, :null => false
	  t.references :theme, :null => false
	end

    add_index :questions_themes, [:question_id, :theme_id]
  end

  def self.down
    drop_table :questions_themes
  end
end