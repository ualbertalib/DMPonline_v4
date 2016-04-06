class Stylesheet < ActiveRecord::Base
  validates_presence_of :file
  #associations between tables
  belongs_to :organisation
  attr_accessible :file, :organisation_id
  dragonfly_accessor :file
  validates_property :ext, of: :file, as: 'css'
  validates_property :mime_type, of: :file, as: 'text/css'
end
