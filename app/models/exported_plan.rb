class ExportedPlan < ActiveRecord::Base
  attr_accessible :plan_id, :user_id, :format
  
  #associations between tables
  belongs_to :plan
  belongs_to :user

  validates :format, inclusion: { in: %i( html text xml json pdf ), message: '%{value} is not valid format' }

  # Store settings with the exported plan so it can be recreated later
  # if necessary (otherwise the settings associated with the plan at a
  # given time can be lost)
  has_settings :export, class_name: 'Settings::Dmptemplate' do |s|
    s.key :export, defaults: Settings::Dmptemplate::DEFAULT_SETTINGS
  end

  # Getters to match Settings::Dmptemplate::VALID_ADMIN_FIELDS
  def project_name
    self.plan.project.title
  end

  def project_identifier
    self.plan.project.identifier
  end

  def grant_title
    self.plan.project.grant_number
  end

  def principal_investigator
    self.plan.project.principal_investigator
  end

  def project_data_contact
    self.plan.project.data_contact
  end

  def project_description
    self.plan.project.description
  end

  def funder
    org = self.plan.project.dmptemplate.try(:organisation)
    org.name if org.present? && org.organisation_type.try(:name) == I18n.t('helpers.org_type.funder')
  end

  def institution
    plan.project.organisation.try(:name)
  end

end
