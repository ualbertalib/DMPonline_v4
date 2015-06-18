Role.create!([
  {name: "admin"},
  {name: "user"},
  {name: "org_admin"}
])
organisation_types = {
 'Organization' => {
     name: "Organization"
   },
   'Funder' => {
     name: "Funder"
   },
   'Project' => {
     name: "Project"
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
   'University of Alberta' => {
     name: "University of Alberta",
     abbreviation: "UAlberta",
     sort_name: "University of Alberta",
     domain: "ualberta.ca",
     organisation_type: "Institution"
   },
   'University of British Columbia'=> {
     name: "University of British Columbia",
     abbreviation: "UBC",
     domain: "ubc.ca",
     sort_name: "University of British Columbia",
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

# uses encrypted password.  See passwrod safe!
admin = User.new(
  {firstname: "DMP", surname: "Administrator", email: "dittest@ualberta.ca",
   password: "password", password_confirmation: "password"}
)
admin.encrypted_password = "$2a$10$q7XUQxvbFb1QcYhrngqcd..sM8.DsviZUxUBwDpC7ZmuohHrkOeZm"
admin.add_role(:admin)
admin.organisation_id = Organisation.find_by_name('University of Alberta').id
admin.skip_confirmation!
admin.save!

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


user_statuses = {
  "Active" => {
    name: "Active"
  }, 
  "Archived" => {
    name: "Archived"
  }
}

user_statuses.each do |us, details|
  user_status = UserStatus.new
  user_status.name = details[:name]
  user_status.save!
end
    
themes = {
  "Related Policies" => {
    title: "Related Policies", 
    locale: "en"
  }, 
  "Licensing of Existing Data" => {
    title: "Licensing of Existing Data", 
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
  "Resourcing: Hardware and Software" => {
    title: "Resourcing: Hardware and Software",
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
  "Active Data Storage" => {
    title: "Active Data Storage", 
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
  "Description of Data Content" => {
    title: "Description of Data Content", 
    locale: "en"
  },
  "Resourcing: Preservation and Data Sharing" => {
    title: "Resourcing: Preservation and Data Sharing", 
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
  "Metadata Capture" => {
    title: "Metadata Capture", 
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
  "Embargo Period" => {
    title: "Embargo Period", 
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
  "Data Organization" => {
    title: "Data Organization", 
    locale: "en"
  },
  "Metadata Standards" => {
    title: "Metadata Standards", 
    locale: "en"
  },
  "Documentation" => {
    title: "Documentation", 
    locale: "en"
  },
  "Backup Procedures" => {
    title: "Backup Procedures", 
    locale: "en"
  },
  "Resourcing: Skills and Training" => {
    title: "Resourcing: Skills and Training", 
    locale: "en"
  },
  "Data Type" => {
    title: "Data Type", 
    locale: "en"
  },
  "Audience" => {
    title: "Audience", 
     locale: "en"
  },
  "Data Format" => {
    title: "Data Format", 
    locale: "en"
  }
}

 themes.each do |t, details|
   theme = Theme.new
   theme.title = details[:title]
   theme.locale = details[:locale]
   theme.description = details[:description]
   theme.save!
 end

user_org_roles = {
  "dittest" => {
    user: "dittest@ualberta.ca",
    organisation: "University of Alberta"
  }
}

user_org_roles.each do |r, details|
   user_org_role = UserOrgRole.new
   user_org_role.user_id = User.find_by_email(details[:user]).id
   user_org_role.organisation_id = Organisation.find_by_name(details[:organisation]).id
   user_org_role.save!
end 

templates = {
  "University of Alberta" => {
    title: "University of Alberta Data Management Questions", 
    description: "This is the generic DMP template for University of Alberta.",
    published: true, 
    organisation: "University of Alberta",
    locale: "en", 
    is_default: true
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

phases = {
  "University of Alberta" => {
    title: "University of Alberta Data Management Questions", 
    number: 1, 
    template: "University of Alberta Data Management Questions"
   }
}

 phases.each do |p, details|
   phase = Phase.new
   phase.title = details[:title]
   phase.number = details[:number]
   phase.dmptemplate = Dmptemplate.find_by_title(details[:template])
   phase.save!
 end

versions = {
  "University of Alberta" => {
    title: "University of Alberta Version 1", 
    published: true, 
    number: 1, 
    phase: "University of Alberta Data Management Questions"
  }
}

 versions.each do |v, details|
   version = Version.new
   version.title = details[:title]
   version.number = details[:number]
   version.published = details[:published]
   version.phase = Phase.find_by_title(details[:phase])
   version.save!
 end

sections = {
  "Data Collection" => {
    title: "Data Collection", 
    number: 1, 
    version: "University of Alberta Version 1",
    organisation: "University of Alberta"
  },
  "Documentation and Metadata" => {
    title: "Documentation and Metadata", 
    number: 2, 
    version: "University of Alberta Version 1", 
    organisation: "University of Alberta"
  },
  "Storage and Backup" => {
    title: "Storage and Backup", 
    number: 3, 
    version: "University of Alberta Version 1", 
    organisation: "University of Alberta"
  },
  "Preservation" => {
    title: "Preservation", 
    number: 4, 
    version: "University of Alberta Version 1", 
    organisation: "University of Alberta"
  }, 
  "Data Sharing and Reuse" => {
    title: "Data Sharing and Reuse", 
    number: 5, 
    version: "University of Alberta Version 1", 
    organisation: "University of Alberta"
  }, 
  "Responsibilites and Resources" => {
    title: "Responsibilities and Resources", 
    number: 6, 
    version: "University of Alberta Version 1", 
    organisation: "University of Alberta"
  } 
}

 sections.each do |s, details|
   section = Section.new
   section.title = details[:title]
   section.number = details[:number]
   section.description = details[:description]
   section.version = Version.find_by_title(details[:version])
   section.organisation = Organisation.find_by_name(details[:organisation])
   section.save!
 end

questions = {

  "Question1-1" => {
    text: "What types of data will you collect, create, acquire and/or record?", 
    section: "Data Collection", 
    number: 1, 
    question_format: "Text area",
    guidance: "Examples: Images, audio, video, text, tabular data, modeling data, spatial data, instrumentation data"
  },
   
  "Question1-5" => {
    text: "Are there are any existing data that you can re-use?  If so, please explain how you will obtain that data and integrate it into your research project.",
    section: "Data Collection", 
    number: 5,
    question_format: "Text area",
    guidance: "<p>There may be existing data that you can license or purchase for re-use.  <a href=\"http://databib.org/\" target=\"_blank\">Databib</a> and <a href=\"http://www.re3data.org/\" target=\"_blank\">re3data</a> are directories of disciplinary data repositories you can check for data.   You can also contact the <a href=\"http://www.library.ualberta.ca/aboutus/hss/data/\" target=\"_blank\">U of A Data Library</a> for help with finding and re-using existing data</p>" 
  }, 
  
  "Question1-2" => {
    text: "What file formats will your data be collected in?  Will these formats allow for data re-use, sharing and long-term access to the data?", 
    section: "Data Collection", 
    number: 2, 
    question_format: "Text area",
    guidance: "<p>Proprietary file formats which require specialized software or hardware to use are not recommended, but may be necessary for certain data collection or analysis methods.  Using open file formats or industry-standard formats (e.g. those which are widely used by a given community) is preferred whenever possible.  </p><p>Read more about file formats on the <a href=\"http://data-archive.ac.uk/create-manage/format/formats\" target=\"_blank\">UK Data Archive website</a>.</p>"
  },
  
  "Question2-1" => {
    text: "What documentation will be needed for the data to be read and interpreted correctly in the future?  This includes study-level documentation, data-level description, and any other contextual information required to make the data usable by other researchers.", 
    section: "Documentation and Metadata", 
    number: 1, 
    question_format: "Text area",
    guidance: "<p>Your documentation may include study-level information about:</p>\r\n<ul>\r\n<li>who created/collected the data</li>\r\n<li>when it was created</li>\r\n<li>any relevant study documents</li>\r\n<li>conditions of use</li>\r\n<li>contextual details about data collection methods and procedural documentation about how data files are stored, structured, and modified.  </li>\r\n</ul>\r\n<p>A complete description of the data files may include:</p>\r\n<ul>\r\n<li>naming and labelling conventions</li>\r\n<li>explanations of codes and variables</li>\r\n<li>any information or files require to reproduce derived data.  </li>\r\n</ul>\r\n<p>More information about data documentation is available at the <a href=\"http://www.data-archive.ac.uk/create-manage/document\" target=\"_blank\">UK Data Archive</a></p>"
  }, 
  
  "Question2-2" => {
    text: "Please list the metadata standard and tools you will use to document and describe your data.  If there is not an appropriate standard, please explain how you will ensure consistency in your documentation.", 
    section: "Documentation and Metadata", 
    number: 2,
    question_format: "Text area", 
    guidance: "<p>Metadata is a description of the contents and context of data files. Using a metadata standard (a set of required fields to fill out) helps ensure that your documentation is consistent, structured, and machine-readable, which is essential for depositing data in repositories and making it easily discoverable by search engines.</p>\r\n<p>There are general and discipline-specific <a href=\"http://www.dcc.ac.uk/resources/metadata-standards\" target=\"_blank\">metadata standards and tools</a> for research data.  For assistance with choosing a metadata standard, please contact <a href=\"mailto:data@ualberta.ca\">data@ualberta.ca</a>.</p>"
  },    
  
  "Question2-3" => {
    text: "How will you make sure that documentation is created or captured consistently throughout your project?", 
    section: "Documentation and Metadata", 
    number: 3,
    question_format: "Text area", 
    guidance: "It is best to begin the documentation process at the start of a research project.  Details or procedures may be forgotten if documentation is created at the end of a project."
  }, 
   
  "Question3-1" => {
    text:  "How will your data be stored and backed up during your research project?", 
    section: "Storage and Backup", 
    number: 1,
    question_format: "Text area", 
    guidance: "<p>Storing data on flash drives, laptops, computers, or external hard drives without a regular backup procedure is not recommended, because they are subject to hardware failure, viruses, file corruption, theft, loss, and human error. Likewise, multiple copies of data stored in the same physical location does little to mitigate risk. </p>\r\n<p>Using software which automatically backs up your data and keeps it synchronized with a master copy is recommended. Copies of data should ideally be stored in separate physical locations to mitigate physical risks, e.g. fire.  More about data storage from <a href=\"http://data-archive.ac.uk/create-manage/storage.aspx\" target=\"_blank\">UK Data Archive</a>.</p>\r\n<p>Many universities offer networked file storage which is automatically backed up. University of Alberta researchers have access to networked storage and to commercial cloud storage (Google Drive) through <a href=\"http://ist.ualberta.ca/ts\" target=\"_blank\">Information Services and Technology</a>.\r\nUniversity of Alberta Libraries also offers <a href=\"https://dataverse.library.ualberta.ca/dvn/\" target=\"_blank\">Dataverse</a> for storing and sharing small datasets. For assistance with Dataverse, contact <a href=\"mailto:data@ualberta.ca\">data@ualberta.ca</a>. </p>"
  },  
  
  "Question3-2" => {
    text: "How will you ensure that sensitive data is stored securely and only accessible to the research team during the research project?", 
    section: "Storage and Backup", 
    number: 2,
    question_format: "Text area", 
    guidance: "<p>The security measures you choose to implement will depend on the sensitivity of the data being stored.  Data can be protected by limiting physical access to hard drives and file servers on which it is stored, by storing data on computers that do not have external network access (i.e. access to the Internet), through password protection, and by encrypting data files.</p>\r\n<p>Sharing sensitive data via email and cloud storage services such as Dropbox is not recommended, since the security of these services cannot be trusted.  More about security from the <a href=\"http://data-archive.ac.uk/create-manage/storage/security\" target=\"_blank\">UK Data Archive</a>.</p>"
  },
 
  "Question4-1" => {
    text: "Which data are selected for preservation and access will depend on potential reuse value, whether there are obligations to either retain or destroy data, and the resources required to properly curate the data and ensure that it remains usable in the future.  In some circumstances, it may be feasible to preserve all versions of the data (e.g. raw, processed, analyzed, final), but in others, it may be preferable to only keep only selected data (e.g. transcripts instead of audio interviews).", 
    section: "Preservation", 
    number: 1,
    question_format: "Text area", 
    guidance: "Which data are selected for preservation and access will depend on potential reuse value, whether there are obligations to either retain or destroy data, and the resources required to properly curate the data and ensure that it remains usable in the future.  In some circumstances, it may be feasible to preserve all versions of the data (e.g. raw, processed, analyzed, final), but in others, it may be preferable to only keep only selected data (e.g. transcripts instead of audio interviews)."
  }, 
  
  "Question4-2" => {
    text: "At the end of your research project, where will you deposit your data for long-term preservation and access? ", 
    section: "Preservation", 
    number: 2,
    question_format: "Text area", 
    guidance: "<p>Please describe how you will identify a data repository or data center for your data.  <a href=\"http://databib.org/\" target=\"_blank\">Databib</a>  and <a href=\"http://www.re3data.org/\" target=\"_blank\">re3data.org</a> are directories of potential data repositories.  Note any details about the curation of the data and what aspects of the curation are your responsibility versus what the repository assumes. See if the data repository will provide a statement agreeing to these terms of deposit that can be included with your data management plan. </p>\r\n<p>Researchers at the University of Alberta can deposit smaller datasets (less than 500MB) in <a href=\"https://dataverse.library.ualberta.ca/dvn/\" target=\"_blank\">Dataverse</a> for complex data formats such as those produced by SPSS or SAS, or <a href=\"https://era.library.ualberta.ca/public/home\" target=\"_blank\">ERA</a> for basic data formats such as Excel.  For larger datasets, please contact <a href=\"mailto:data@ualberta.ca\">data@ualberta.ca</a>.  </p>"
  },
 
  "Question4-3" => {
    text: "Please describe how you will prepare the data for preservation and access, including any necessary procedures for data cleaning, normalization or de-identification.  Explain how you will prevent data from being lost while processing and converting files. ", 
    section: "Preservation", 
    number: 3,
    question_format: "Text area", 
    guidance: "<p>It is likely that you will have multiple versions of your data (raw, processed, analyzed, final), and your data may be stored in different file formats depending on how they were collected and analyzed.</p>\r\n<p>Digital information may be lost while converting files from one format to another (e.g. converting an image from a non-compressed ‘lossless’ TIFF file to a compressed ‘lossy’ JPG file), so changes to file formats should be clearly documented.</p>\r\n<p>Identify what steps are needed after your project is completed in order to ensure the data you are choosing to preserve or share is anonymous, error-free, and converted to recommended formats with a minimal risk of data loss.</p>\r\n<p>Read more about <a href=\"http://data-archive.ac.uk/create-manage/format/formats\" target=\"_blank\">file formats</a> and <a href=\"http://data-archive.ac.uk/create-manage/consent-ethics/anonymisation\" target=\"_blank\">anonymization</a> on the UK Data Archive Website.</p>"
  }, 
  
  "Question5-1" => {
    text: "What data will you be sharing and in what form? (e.g. raw, processed, analyzed, final). Consider which data may need to be shared in order to meet institutional or funding requirements, and which data may be restricted because of confidentiality/privacy issues.", 
    section: "Data Sharing and Reuse", 
    number: 1,
    question_format: "Text area"
  },
 
  "Question5-2" => {
    text: "How will you be sharing your data? (e.g. institutional repository, a specialized data archive, project website, informal/on-request sharing).  Include a brief description of any resources needed to share your data (equipment, systems, expertise, etc.).", 
    section: "Data Sharing and Reuse", 
    number: 2,
    question_format: "Text area", 
    guidance: "<p>Where you share your data depends on the complexity and size of your data.  Smaller, low-risk datasets can be shared via institutional or disciplinary repositories and project websites. Larger datasets or datasets with more stringent security requirements cannot be easily transferred over the Internet.  Read more about sharing data at the <a href=\"http://www.data-archive.ac.uk/create-manage/planning-for-sharing/how-to-share-data\" target=\"_blank\">UK Data Archive</a>.</p>\r\n<p>Researchers at the University of Alberta can deposit smaller datasets (less than 500MB) in <a href=\"https://dataverse.library.ualberta.ca/dvn/\" target=\"_blank\">Dataverse</a> (for complex data formats such as that produced by SPSS or SAS) or <a href=\"https://era.library.ualberta.ca/public/home\" target=\"_blank\">ERA</a> (for basic data formats such as Excel).  For larger datasets, please contact <a href=\"mailto:data@ualberta.ca\">data@ualberta.ca</a>. </p>"
  }, 
  
  "Question5-3" => {
    text: "Please describe whether there will be any restrictions placed on your data when they are made available and who may access them.  If data are not openly available, describe the process for gaining access.", 
    section: "Data Sharing and Reuse", 
    number: 3,
    question_format: "Text area", 
    guidance: "<p>It may be necessary or desirable to restrict access to your data for a limited time or to a limited number of people, for:</p>\r\n<ul>\r\n<li>ethical reasons (privacy and confidentiality) </li>\r\n<li>economic reasons (patents and commercialization)</li>\r\n<li>intellectual property reasons (e.g. ownership of the original dataset on which yours is based) </li>\r\n<li>or to comply with a journal publishing policy.  </li>\r\n</ul>\r\n<p>Strategies to mitigate these issues may include: </p>\r\n<ul>\r\n<li>anonymising or aggregating data</li>\r\n<li>gaining participant consent for data sharing</li>\r\n<li>gaining permissions to share adapted or modified data</li>\r\n<li>and agreeing to a limited embargo period.</li>\r\n</ul>"
  }, 
  
  "Question6-1" => {
    text: "Who will be responsible for data management during the project? (i.e. during collection, processing, analysis, documentation).  Identify staff and organizational roles and their responsibilities for carrying out the data management plan (DMP), including time allocations and training requirements.", 
    section: "Responsibilities and Resources", 
    number: 1,
    question_format: "Text area"
  }, 
   
  "Question6-2" => {
    text:  "What will happen when personnel changes occur or if the principal investigator leaves the institution before the project has concluded?", 
    section: "Responsibilities and Resources", 
    number: 2,
    question_format: "Text area"
  }, 
  
  "Question6-3" => {
    text: "Who will be responsible for data sharing and preservation after the project has concluded? Indicate the party who will have primary responsibility for how the data will persist over time when the original personnel have moved on. ", 
    section: "Responsibilities and Resources", 
    number: 3, 
    question_format: "Text area"
  }, 
  
  "Question1-3" => {
    text: "If data are collected using laptops or mobile devices, please explain how will you will securely store and transfer the data.",
    section: "Data Collection",
    number: 3, 
    question_format: "Text area",
    guidance: "<p>The University of Alberta’s Encryption Procedure requires that sensitive information stored on mobile computing devices be encrypted.  <a href=\"http://www.vpit.ualberta.ca/encryption/\" target=\"_blank\">Read more about encryption</a></p>"
  }, 
  
  "Question1-4" => {
    text: "How much data do you anticipate collecting?  Include an estimate of how much storage space you will require (in megabytes, gigabytes, terabytes).  This estimate should also take into account storage space required for file versioning, backups, and the growth rate over time. ", 
    section: "Data Collection", 
    number: 4, 
    question_format: "Text area",
    guidance: "<p>The type of data you collect will impact your storage requirements.  Textual and tabular data files are usually very small (a few megabytes) unless you have a lot of data.  Video files are usually very large (hundreds of megabytes up to several gigabytes).  If you have a large amount of data (gigabytes or terabytes), it will be more challenging to share and transfer it.  You may need to consider networked storage options or more sophisticated backup methods.</p>\r\n<p>If your data will be changing frequently, please estimate how much extra storage will be required to store multiple versions.  If you are collecting data over a long period of time (e.g. several months or years), please describe your plan for adding additional storage to accommodate the growth of your data.</p>"
  }, 
  
  "Question1-6" => {
    text: "What conventions and procedures will you use to structure, name and version control your files to ensure that your data is well-organized?", 
    section: "Data Collection",
    question_format: "Text area", 
    number: 6,
    guidance: "<p>Ensuring that you and your research team are using the ‘master’ version of your data is extremely important.  Establishing conventions for naming and versioning your files is essential, especially when data may be available in different file formats or stored on different computers.</p>\r\n<p>More information on file naming and version control is available from <a href=\"http://libraries.mit.edu/guides/subjects/data-management/organizing.html\" target=\"_blank\">MIT</a> and the <a href=\"http://www.data-archive.ac.uk/create-manage/format/versions\" target=\"_blank\">UK Data Archive</a>.</p>\r\n<p>University of Alberta Libraries’ <a href=\"https://dataverse.library.ualberta.ca/dvn/\" target=\"_blank\">Dataverse</a> can help with version control of your files.</p>"
  }, 
  
  "Question5-4" => {
    text: "What type of end-user license will you include with your data? Please include a copy of this license with your Data Management Plan. ", 
    section: "Data Sharing and Reuse", 
    number: 4,
    question_format: "Text area", 
    guidance: "<p>Assigning an end-user license allows you to define the terms of use for your data.  We recommend a <a href=\"http://creativecommons.org/choose/\" target=\"_blank\">Creative Commons license</a>.</p>"
  }, 
  
  "Question6-4" => {
    text: "What resources will you require to implement your plan? Will extra people, time or hardware, storage be required? How much will this cost (estimation)?", 
    section: "Responsibilities and Resources", 
    number: 4,
    question_format: "Text area", 
    guidance: "<p>More information about estimating cost for data management is available through the <a href=\"http://data-archive.ac.uk/create-manage/planning-for-sharing/costing\" target=\"_blank\">UK Data Archive</a>. This information should be incorporated into any grant applications for your project.</p>"
  } 
}

 questions.each do |q, details|
   question = Question.new
   question.text = details[:text]
   question.number = details[:number]
   question.guidance = details[:guidance]
   question.section = Section.find_by_title(details[:section])
   question.question_format_id = QuestionFormat.find_by_title(details[:question_format]).id
   question.save!
 end

