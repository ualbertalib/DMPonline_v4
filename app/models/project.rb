class Project < ActiveRecord::Base
  extend FriendlyId

  attr_accessible :dmptemplate_id, :title, :organisation_id, :unit_id, :guidance_group_ids, :project_group_ids, :funder_id, :institution_id, :grant_number, :identifier, :description, :principal_investigator, :principal_investigator_identifier, :data_contact, :funder_name

  # associations between tables
  belongs_to :dmptemplate
  belongs_to :organisation
  has_many :plans
  has_many :project_groups, dependent: :destroy
  has_and_belongs_to_many :guidance_groups, join_table: 'project_guidance'

  friendly_id :title, use: :history

  after_create :create_plans

  def funder_id=(new_funder_id)
    if new_funder_id != ''
      new_funder = Organisation.find(new_funder_id)
      if new_funder.dmptemplates.count == 1
        dmptemplate = new_funder.dmptemplates.first
      end
    end
  end

  def funder_id
    return nil if dmptemplate.nil?

    template_org = dmptemplate.organisation
    if template_org.organisation_type.name == I18n.t('helpers.org_type.funder').downcase
      return template_org.id
    else
      return nil
    end
  end

  def funder
    return nil if dmptemplate.nil?

    template_org = dmptemplate.organisation
    if template_org.organisation_type.name == I18n.t('helpers.org_type.funder').downcase
      return template_org
    else
      return nil
    end
  end

  def funder_name
    if funder.nil?
      read_attribute(:funder_name)
    else
      funder.name
    end
  end

  def funder_name=(new_funder_name)
    write_attribute(:funder_name, new_funder_name)
    org_table = Organisation.arel_table
    existing_org = Organisation.where(org_table[:name].matches(new_funder_name))
    if existing_org.nil?
      existing_org = Organisation.where(org_table[:abbreviation].matches(new_funder_name))
    end
    self.funder_id = existing_org.id unless existing_org.empty?
  end

  def institution_id=(new_institution_id)
    self.organisation_id = new_institution_id if organisation.nil?
  end

  def institution_id
    if organisation.nil?
      nil
    else
      organisation.root.id
    end
  end

  def unit_id=(new_unit_id)
    unless new_unit_id.nil? || new_unit_id == ''
      self.organisation_id = new_unit_id
    end
  end

  def unit_id
    if organisation.nil? || organisation.parent_id.nil?
      nil
    else
      organisation_id
    end
  end

  def assign_creator(user_id)
    add_user(user_id, true, true, true)
  end

  def assign_editor(user_id)
    add_user(user_id, true)
  end

  def assign_reader(user_id)
    add_user(user_id)
  end

  def assign_administrator(user_id)
    add_user(user_id, true, true)
  end

  def administerable_by(user_id)
    user = project_groups.find_by_user_id(user_id)
    if !user.nil? && user.project_administrator
      return true
    else
      return false
    end
  end

  def editable_by(user_id)
    user = project_groups.find_by_user_id(user_id)
    if !user.nil? && user.project_editor
      return true
    else
      return false
    end
  end

  def readable_by(user_id)
    user = project_groups.find_by_user_id(user_id)
    if !user.nil?
      return true
    else
      return false
    end
  end

  def self.projects_for_user(user_id)
    projects = []
    groups = ProjectGroup.where('user_id = ?', user_id)
    unless groups.nil?
      groups.each do |group|
        projects << group.project unless group.project.nil?
      end
    end
    projects
  end

  def created_by(user_id)
    user = project_groups.find_by_user_id(user_id)
    if !user.nil? && user.project_creator
      return true
    else
      return false
    end
  end

  def latest_update
    latest_update = updated_at
    plans.each do |plan|
      latest_update = plan.latest_update if plan.latest_update > latest_update
    end
    latest_update
  end

  # Getters to match 'My plans' columns
  def name
    title
  end

  def owner
    project_groups.find_by_project_creator(true).try(:user)
  end

  def last_edited
    latest_update.to_date
  end

  def shared?
    project_groups.count > 1
  end

  alias shared shared?

  def template_owner
    dmptemplate.try(:organisation).try(:abbreviation)
  end

  private

  def add_user(user_id, is_editor = false, is_administrator = false, is_creator = false)
    group = ProjectGroup.new
    group.user_id = user_id
    group.project_creator = is_creator
    group.project_editor = is_editor
    group.project_administrator = is_administrator
    project_groups << group
  end

  def create_plans
    dmptemplate.phases.each do |phase|
      latest_published_version = phase.latest_published_version
      next if latest_published_version.nil?

      new_plan = Plan.new
      new_plan.version = latest_published_version
      plans << new_plan
    end
  end
end
