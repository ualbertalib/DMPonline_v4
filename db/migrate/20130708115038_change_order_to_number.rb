class ChangeOrderToNumber < ActiveRecord::Migration
	def change
		change_table :questions do |t|
			t.rename :order, :number
		end
		change_table :sections do |t|
			t.rename :order, :number
		end
		change_table :versions do |t|
			t.rename :order, :number
		end
	end
end
