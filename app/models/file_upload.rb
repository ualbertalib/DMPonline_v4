class FileUpload < ActiveRecord::Base

   #associations between tables
   has_one :file_type
   
  attr_accessible :file_type_id, :file_upload_desc, :file_upload_location, :file_upload_name, :file_upload_published, :file_upload_size, :file_upload_title
end
