class FileType < ActiveRecord::Base
  attr_accessible :file_type_name, :icon_location, :icon_name, :icon_size
end
