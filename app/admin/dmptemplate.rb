ActiveAdmin.register Dmptemplate do
	#scope :unreleased
  
  index do   
  	column :title do |dmptemp|
        link_to dmptemp.title, [:admin, dmptemp]
    end
  	column :description
  	column :published
  	column :is_default
  	
    default_actions
  end
 
end

#example on how to do it 

# column :name
    #column :category
    #column "Release Date", :released_at
    #column :price, :sortable => :price do |product|
    #  div :class => "price" do
     #   number_to_currency product.price
      #end
    #end
