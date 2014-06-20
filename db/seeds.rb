# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Dmptemplate default formatting settings based on https://je-s.rcuk.ac.uk/Handbook/pages/GuidanceonCompletingaStandardG/CaseforSupportandAttachments/CaseforSupportandAttachments.htm

organisation_types = {
  'Organisation' => {
    name: "Organisation"
  },
  'Funder' => {
    name: "Funder"
  },
  'Project' => {
    name: "Project"
  },
  'School' => {
    name: "School"
  },
  'Institution' => {
    name: "Institution"
  },
  'Research Institute' => {
    name: "Research Institute"
  }
}

organisation_types.each do |org_type, details|
  organisation_type = OrganisationType.new
  organisation_type.name = details[:name]
  organisation_type.save!
end

organisations = {
  'DCC' => {
    name: "Digital Curation Centre",
    abbreviation: "DCC",
    sort_name: "Digital Curation Centre",
    organisation_type: "Organisation"
  },
  'AHRC' => {
    name: "Arts and Humanities Research Council",
    abbreviation: "AHRC",
    sort_name: "Arts Humanities Research Council",
    organisation_type: "Funder"
  },
  'Glasgow'=> {
    name: "University of Glasgow",
    abbreviation: "Glasgow",
    domain: "www.gla.ac.uk",
    sort_name: "Glasgow University",
    organisation_type: "Institution"
  }
}

organisations.each do |org, details|
  organisation = Organisation.new
  organisation.name = details[:name]
  organisation.abbreviation = details[:abbreviation]
  organisation.domain = details[:domain]
  organisation.sort_name = details[:sort_name]
  organisation.organisation_type = OrganisationType.find_by_name(details[:organisation_type])
  organisation.save!
end

themes = {
  "Related Policies" => {
    title: "Related Policies",
    locale: "en"
  },
  "Responsibilities" => {
    title: "Responsibilities",
    locale: "en"
  },
  "Discovery by Users" => {
    title: "Discovery by Users",
    locale: "en"
  },
  "Preservation Plan" => {
    title: "Preservation Plan",
    locale: "en"
  },
  "Period of Preservation" => {
    title: "Period of Preservation",
    locale: "en"
  },
  "Data Security" => {
    title: "Data Security",
    locale: "en"
  },
  "Method For Data Sharing" => {
    title: "Method For Data Sharing",
    locale: "en"
  },
  "Data Capture Methods" => {
    title: "Data Capture Methods",
    locale: "en"
  },
  "Existing Data" => {
    title: "Existing Data",
    locale: "en"
  },
  "Restrictions on Sharing" => {
    title: "Restrictions on Sharing",
    locale: "en"
  },
  "Data Repository" => {
    title: "Data Repository",
    locale: "en"
  },
  "Timeframe For Data Sharing" => {
    title: "Timeframe For Data Sharing",
    locale: "en"
  },
  "Expected Reuse" => {
    title: "Expected Reuse",
    locale: "en"
  },
  "Data Description" => {
    title: "Data Description",
    locale: "en"
  },
  "Resourcing" => {
    title: "Resourcing",
    locale: "en"
  },
  "Data Quality" => {
    title: "Data Quality",
    locale: "en"
  },
  "Data Selection" => {
    title: "Data Selection",
    locale: "en"
  },
  "Relationship to Existing Data" => {
    title: "Relationship to Existing Data",
    locale: "en"
  },
  "Data Volumes" => {
    title: "Data Volumes",
    locale: "en"
  },
  "IPR Ownership and Licencing" => {
    title: "IPR Ownership and Licencing",
    locale: "en"
  },
  "Managed Access Procedures" => {
    title: "Managed Access Procedures",
    locale: "en"
  },
  "Ethical Issues" => {
    title: "Ethical Issues",
    locale: "en"
  },
  "Metadata" => {
    title: "Metadata",
    locale: "en"
  },
  "Documentation" => {
    title: "Documentation",
    locale: "en"
  },
  "Storage and Backup" => {
    title: "Storage and Backup",
    locale: "en"
  },
  "Data Type" => {
    title: "Data Type",
    locale: "en"
  },
  "Data Format" => {
    title: "Data Format",
    locale: "en"
  },
  "ID" => {
    title: "ID",
    locale: "en",
    description: "An ID or reference number relevant to this DMP."
  },
  "Project Name" => {
    title: "Project Name",
    locale: "en",
    description: "The Project Name given here should be the same as on any other documentation, for example, grant applications, ethics approval forms, etc."
  },
  "Project Description" => {
    title: "Project Description",
    locale: "en",
    description: "A brief description of the project"
  },
  "PI / Researcher" => {
    title: "PI / Researcher",
    locale: "en",
    description: "The name of the PI or Researcher who is responsible for this research project"
  }
}

themes.each do |t, details|
  theme = Theme.new
  theme.title = details[:title]
  theme.locale = details[:locale]
  theme.description = details[:description]
  theme.save!
end

question_formats = {
  "Text area" => {
    title: "Text area"
  },
  "Text field" => {
    title: "Text field"
  },
  "Radio buttons" => {
    title: "Radio buttons"
  },
  "Check box" => {
    title: "Check box"
  },
  "Dropdown" => {
    title: "Dropdown"
  },
  "Multi select box" => {
    title: "Multi select box"
  },
}

question_formats.each do |qf, details|
  question_format = QuestionFormat.new
  question_format.title = details[:title]
  question_format.save!
end

#guidance_groups

#guidance

templates ={
  "DCC" => {
    title: "DCC Template",
    description: "The default DCC template",
    published: true,
    organisation: "DCC",
    locale: "en",
    is_default: true
  },
  "AHRC" => {
    title: "AHRC Template",
    description: "The AHRC template",
    published: true,
    organisation: "AHRC",
    locale: "en",
    is_default: false
  }
}

templates.each do |t, details|
  template = Dmptemplate.new
  template.title = details[:title]
  template.description = details[:description]
  template.published = details[:published]
  template.locale = details[:locale]
  template.is_default = details[:is_default]
  template.organisation = Organisation.find_by_abbreviation(details[:organisation])
  template.save!
end

#sections

#questions

#suggested_answers

formatting = {
  'AHRC' => {
    font_face: "Arial, Helvetica, Sans-Serif",
    font_size: 11,
    margin: { top: 20, bottom: 20, left: 20, right: 20 }
  },
  # 'BBSRC' => {
  #   font_face: "Arial, Helvetica, Sans-Serif",
  #   font_size: 11,
  #   margin: { top: 20, bottom: 20, left: 20, right: 20 }
  # },
  # 'CRUK' => {
  #   font_face: "Arial, Helvetica, Sans-Serif",
  #   font_size: 12,
  #   margin: { top: 20, bottom: 20, left: 20, right: 20 }
  # },
  # 'DMP' => {
  #   font_face: "Arial, Helvetica, Sans-Serif",
  #   font_size: 12,
  #   margin: { top: 20, bottom: 20, left: 20, right: 20 }
  # },
  # 'ESRC' => {
  #   font_face: "Arial, Helvetica, Sans-Serif",
  #   font_size: 11,
  #   margin: { top: 20, bottom: 20, left: 20, right: 20 }
  # },
  # 'MRC' => {
  #   font_face: "Arial, Helvetica, Sans-Serif",
  #   font_size: 11,
  #   margin: { top: 20, bottom: 20, left: 20, right: 20 }
  # },
  # 'NERC' => {
  #   font_face: "Arial, Helvetica, Sans-Serif",
  #   font_size: 11,
  #   margin: { top: 20, bottom: 20, left: 20, right: 20 }
  # },
  # 'STFC' => {
  #   font_face: "Arial, Helvetica, Sans-Serif",
  #   font_size: 11,
  #   margin: { top: 20, bottom: 20, left: 20, right: 20 }
  # },
  # 'Wellcome Trust' => {
  #   font_face: "Arial, Helvetica, Sans-Serif",
  #   font_size: 12,
  #   margin: { top: 20, bottom: 20, left: 20, right: 20 }
  # }
}

formatting.each do |org, settings|
  template = Dmptemplate.find_by_title("#{org} Template")
  template.settings(:export).formatting = settings
  template.save!
end
