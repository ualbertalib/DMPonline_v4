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
   'Portage' => {
      name: "Portage",
      abbreviation: "Portage",
      sort_name: "Portage",
      domain: "carl-abrc.ca",
      organisation_type: "Organization"
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
admin.organisation_id = Organisation.find_by_name('Portage').id
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
    organisation: "Portage"
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
    title: "University of Alberta Template", 
    description: "This is the generic DMP template for University of Alberta.",
    published: true, 
    organisation: "University of Alberta",
    locale: "en", 
    is_default: true
  },
  "Portage" => {
    title: "Portage Template",
    description: "This is the generic DMP template for Portage.",
    published: true,
    organisation: "Portage",
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
   template.organisation = Organisation.find_by_name(details[:organisation])
   template.save!
 end

phases = {
  "University of Alberta" => {
    title: "University of Alberta Data Management Questions", 
    number: 1, 
    template: "University of Alberta Template"
   },
  "Portage" => {
    title: "Portage Data Management Questions",
    number: 1,
    template: "Portage Template"
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
  },
  "Portage" => {
    title: "Portage Version 1", 
    published: true,
    number: 1,
    phase: "Portage Data Management Questions"
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
  "UA - Data Collection" => {
    title: "Data Collection", 
    number: 1, 
    version: "University of Alberta Version 1",
    organisation: "University of Alberta"
  },
  "UA - Documentation and Metadata" => {
    title: "Documentation and Metadata", 
    number: 2, 
    version: "University of Alberta Version 1", 
    organisation: "University of Alberta"
  },
  "UA - Storage and Backup" => {
    title: "Storage and Backup", 
    number: 3, 
    version: "University of Alberta Version 1", 
    organisation: "University of Alberta"
  },
  "UA - Preservation" => {
    title: "Preservation", 
    number: 4, 
    version: "University of Alberta Version 1", 
    organisation: "University of Alberta"
  }, 
  "UA - Data Sharing and Reuse" => {
    title: "Data Sharing and Reuse", 
    number: 5, 
    version: "University of Alberta Version 1", 
    organisation: "University of Alberta"
  }, 
  "UA - Responsibilites and Resources" => {
    title: "Responsibilities and Resources", 
    number: 6, 
    version: "University of Alberta Version 1", 
    organisation: "University of Alberta"
  },
  "Portage - Data Collection" => {
    title: "Data Collection", 
    number: 1, 
    version: "Portage Version 1", 
    organisation: "Portage",
    description: "This section addresses data collection issues such as data types, file formats, naming conventions, and data organisation – factors that will improve the usability of your data and contribute to the success of your project."
  },
  "Portage - Documentation and Metadata" => {
    title: "Documentation and Metadata",
    number: 2,
    version: "Portage Version 1", 
    organisation: "Portage", 
    description: "Because data are rarely self-explanatory, all research data should be accompanied by metadata (information that describes the data according to community best practices).  Metadata standards vary across disciplines, but generally state who created the data and when, how the data were created, their quality, accuracy, and precision, as well as other features necessary to facilitate data discovery, understanding and reuse. </br>Any restrictions on use of the data must be explained in the metadata, along with information on how to obtain approved access to the data, where possible."
  }, 
  "Portage - Storage and Backup" => {
    title: "Storage and Backup", 
    number: 3, 
    version: "Portage Version 1", 
    organisation: "Portage", 
    description: "Planning how research data will be stored and backed up throughout and beyond a research project is critical in ensuring data security and integrity. Appropriate storage and backup not only helps protect research data from catastrophic losses (due to hardware and software failures, viruses, hackers, natural disasters, human error, etc.), but also facilitates appropriate access by current and future researchers."
  }, 
  "Portage - Preservation" => {
    title: "Preservation", 
    number: 4, 
    version: "Portage Version 1", 
    organisation: "Portage", 
    description: "Data preservation will depend on potential reuse value, whether there are obligations to either retain or destroy data, and the resources required to properly curate the data and ensure that it remains usable in the future. In some circumstances, it may be desirable to preserve all versions of the data (e.g. raw, processed, analyzed, final), but in others, it may be preferable to keep only selected or final data (e.g. transcripts instead of audio interviews)."
  }, 
  "Portage - Sharing and Reuse" => {
    title: "Sharing and Reuse", 
    number: 5, 
    version: "Portage Version 1", 
    organisation: "Portage", 
    description: "Data are rarely self-explanatory, so all research data should be accompanied by metadata (information describing the data according to community best practices).  Metadata standards are diverse and vary across disciplines, but metadata generally state who created the data and when, how the data were created, their quality, accuracy, and precision, as well as other features necessary to facilitate data discovery, understanding and reuse.</br>Any restrictions on use of the data must be explained in the metadata, along with information on how to obtain approved access to the data, where possible."
  }, 
  "Portage - Responsibilities and Resources" => {
    title: "Responsibilities and Resources", 
    number: 6, 
    version: "Portage Version 1", 
    organisation: "Portage", 
    description: "Data management focuses on the 'what' and 'how' of operationally supporting data across the research lifecycle.  Data stewardship focuses on 'who' is responsible for ensuring that data management happens. A large project, for example, will involve multiple data stewards. The Principal Investigator should identify at the beginning of a project all of the people who will have responsibilities for data management tasks during and after the project."
  }, 
  "Portage - Ethics and Legal Compliance" => {
    title: "Ethics and Legal Compliance", 
    number: 7, 
    version: "Portage Version 1", 
    organisation: "Portage", 
    description: "Researchers and their teams need to be aware of the policies and processes, both ethical and legal, to which their research data management must comply. Protection of respondent privacy is of paramount importance and informs many data management practices.  In their data management plan, researchers must state how they will prepare, store, share, and archive the data in a way that ensures participant information is protected, throughout the research lifecycle, from disclosure, harmful use, or inappropriate linkages with other personal data.</br>It's recognized that there may be cases where certain data and metadata cannot be made public for various policy or legal reasons, however, the default position should be that all research data and metadata are public."
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
    organisation: "University of Alberta",
    number: 1, 
    question_format: "Text area",
    guidance: "Examples: Images, audio, video, text, tabular data, modeling data, spatial data, instrumentation data"
  },
   
  "Question1-5" => {
    text: "Are there are any existing data that you can re-use?  If so, please explain how you will obtain that data and integrate it into your research project.",
    section: "Data Collection", 
    number: 5,
    organisation: "University of Alberta",
    question_format: "Text area",
    guidance: "<p>There may be existing data that you can license or purchase for re-use.  <a href=\"http://databib.org/\" target=\"_blank\">Databib</a> and <a href=\"http://www.re3data.org/\" target=\"_blank\">re3data</a> are directories of disciplinary data repositories you can check for data.   You can also contact the <a href=\"http://www.library.ualberta.ca/aboutus/hss/data/\" target=\"_blank\">U of A Data Library</a> for help with finding and re-using existing data</p>" 
  }, 
  
  "Question1-2" => {
    text: "What file formats will your data be collected in?  Will these formats allow for data re-use, sharing and long-term access to the data?", 
    section: "Data Collection", 
    number: 2, 
    organisation: "University of Alberta",
    question_format: "Text area",
    guidance: "<p>Proprietary file formats which require specialized software or hardware to use are not recommended, but may be necessary for certain data collection or analysis methods.  Using open file formats or industry-standard formats (e.g. those which are widely used by a given community) is preferred whenever possible.  </p><p>Read more about file formats on the <a href=\"http://data-archive.ac.uk/create-manage/format/formats\" target=\"_blank\">UK Data Archive website</a>.</p>"
  },
  
  "Question2-1" => {
    text: "What documentation will be needed for the data to be read and interpreted correctly in the future?  This includes study-level documentation, data-level description, and any other contextual information required to make the data usable by other researchers.", 
    section: "Documentation and Metadata", 
    number: 1, 
    organisation: "University of Alberta",
    question_format: "Text area",
    guidance: "<p>Your documentation may include study-level information about:</p>\r\n<ul>\r\n<li>who created/collected the data</li>\r\n<li>when it was created</li>\r\n<li>any relevant study documents</li>\r\n<li>conditions of use</li>\r\n<li>contextual details about data collection methods and procedural documentation about how data files are stored, structured, and modified.  </li>\r\n</ul>\r\n<p>A complete description of the data files may include:</p>\r\n<ul>\r\n<li>naming and labelling conventions</li>\r\n<li>explanations of codes and variables</li>\r\n<li>any information or files require to reproduce derived data.  </li>\r\n</ul>\r\n<p>More information about data documentation is available at the <a href=\"http://www.data-archive.ac.uk/create-manage/document\" target=\"_blank\">UK Data Archive</a></p>"
  }, 
  
  "Question2-2" => {
    text: "Please list the metadata standard and tools you will use to document and describe your data.  If there is not an appropriate standard, please explain how you will ensure consistency in your documentation.", 
    section: "Documentation and Metadata", 
    number: 2,
    organisation: "University of Alberta",
    question_format: "Text area", 
    guidance: "<p>Metadata is a description of the contents and context of data files. Using a metadata standard (a set of required fields to fill out) helps ensure that your documentation is consistent, structured, and machine-readable, which is essential for depositing data in repositories and making it easily discoverable by search engines.</p>\r\n<p>There are general and discipline-specific <a href=\"http://www.dcc.ac.uk/resources/metadata-standards\" target=\"_blank\">metadata standards and tools</a> for research data.  For assistance with choosing a metadata standard, please contact <a href=\"mailto:data@ualberta.ca\">data@ualberta.ca</a>.</p>"
  },    
  
  "Question2-3" => {
    text: "How will you make sure that documentation is created or captured consistently throughout your project?", 
    section: "Documentation and Metadata", 
    number: 3,
    organisation: "University of Alberta",
    question_format: "Text area", 
    guidance: "It is best to begin the documentation process at the start of a research project.  Details or procedures may be forgotten if documentation is created at the end of a project."
  }, 
   
  "Question3-1" => {
    text:  "How will your data be stored and backed up during your research project?", 
    section: "Storage and Backup", 
    number: 1,
    organisation: "University of Alberta",
    question_format: "Text area", 
    guidance: "<p>Storing data on flash drives, laptops, computers, or external hard drives without a regular backup procedure is not recommended, because they are subject to hardware failure, viruses, file corruption, theft, loss, and human error. Likewise, multiple copies of data stored in the same physical location does little to mitigate risk. </p>\r\n<p>Using software which automatically backs up your data and keeps it synchronized with a master copy is recommended. Copies of data should ideally be stored in separate physical locations to mitigate physical risks, e.g. fire.  More about data storage from <a href=\"http://data-archive.ac.uk/create-manage/storage.aspx\" target=\"_blank\">UK Data Archive</a>.</p>\r\n<p>Many universities offer networked file storage which is automatically backed up. University of Alberta researchers have access to networked storage and to commercial cloud storage (Google Drive) through <a href=\"http://ist.ualberta.ca/ts\" target=\"_blank\">Information Services and Technology</a>.\r\nUniversity of Alberta Libraries also offers <a href=\"https://dataverse.library.ualberta.ca/dvn/\" target=\"_blank\">Dataverse</a> for storing and sharing small datasets. For assistance with Dataverse, contact <a href=\"mailto:data@ualberta.ca\">data@ualberta.ca</a>. </p>"
  },  
  
  "Question3-2" => {
    text: "How will you ensure that sensitive data is stored securely and only accessible to the research team during the research project?", 
    section: "Storage and Backup", 
    number: 2,
    organisation: "University of Alberta",
    question_format: "Text area", 
    guidance: "<p>The security measures you choose to implement will depend on the sensitivity of the data being stored.  Data can be protected by limiting physical access to hard drives and file servers on which it is stored, by storing data on computers that do not have external network access (i.e. access to the Internet), through password protection, and by encrypting data files.</p>\r\n<p>Sharing sensitive data via email and cloud storage services such as Dropbox is not recommended, since the security of these services cannot be trusted.  More about security from the <a href=\"http://data-archive.ac.uk/create-manage/storage/security\" target=\"_blank\">UK Data Archive</a>.</p>"
  },
 
  "Question4-1" => {
    text: "Which data are selected for preservation and access will depend on potential reuse value, whether there are obligations to either retain or destroy data, and the resources required to properly curate the data and ensure that it remains usable in the future.  In some circumstances, it may be feasible to preserve all versions of the data (e.g. raw, processed, analyzed, final), but in others, it may be preferable to only keep only selected data (e.g. transcripts instead of audio interviews).", 
    section: "Preservation", 
    number: 1,
    organisation: "University of Alberta",
    question_format: "Text area", 
    guidance: "Which data are selected for preservation and access will depend on potential reuse value, whether there are obligations to either retain or destroy data, and the resources required to properly curate the data and ensure that it remains usable in the future.  In some circumstances, it may be feasible to preserve all versions of the data (e.g. raw, processed, analyzed, final), but in others, it may be preferable to only keep only selected data (e.g. transcripts instead of audio interviews)."
  }, 
  
  "Question4-2" => {
    text: "At the end of your research project, where will you deposit your data for long-term preservation and access? ", 
    section: "Preservation", 
    organisation: "University of Alberta",
    number: 2,
    question_format: "Text area", 
    guidance: "<p>Please describe how you will identify a data repository or data center for your data.  <a href=\"http://databib.org/\" target=\"_blank\">Databib</a>  and <a href=\"http://www.re3data.org/\" target=\"_blank\">re3data.org</a> are directories of potential data repositories.  Note any details about the curation of the data and what aspects of the curation are your responsibility versus what the repository assumes. See if the data repository will provide a statement agreeing to these terms of deposit that can be included with your data management plan. </p>\r\n<p>Researchers at the University of Alberta can deposit smaller datasets (less than 500MB) in <a href=\"https://dataverse.library.ualberta.ca/dvn/\" target=\"_blank\">Dataverse</a> for complex data formats such as those produced by SPSS or SAS, or <a href=\"https://era.library.ualberta.ca/public/home\" target=\"_blank\">ERA</a> for basic data formats such as Excel.  For larger datasets, please contact <a href=\"mailto:data@ualberta.ca\">data@ualberta.ca</a>.  </p>"
  },
 
  "Question4-3" => {
    text: "Please describe how you will prepare the data for preservation and access, including any necessary procedures for data cleaning, normalization or de-identification.  Explain how you will prevent data from being lost while processing and converting files. ", 
    section: "Preservation", 
    organisation: "University of Alberta",
    number: 3,
    question_format: "Text area", 
    guidance: "<p>It is likely that you will have multiple versions of your data (raw, processed, analyzed, final), and your data may be stored in different file formats depending on how they were collected and analyzed.</p>\r\n<p>Digital information may be lost while converting files from one format to another (e.g. converting an image from a non-compressed 'lossless' TIFF file to a compressed 'lossy' JPG file), so changes to file formats should be clearly documented.</p>\r\n<p>Identify what steps are needed after your project is completed in order to ensure the data you are choosing to preserve or share is anonymous, error-free, and converted to recommended formats with a minimal risk of data loss.</p>\r\n<p>Read more about <a href=\"http://data-archive.ac.uk/create-manage/format/formats\" target=\"_blank\">file formats</a> and <a href=\"http://data-archive.ac.uk/create-manage/consent-ethics/anonymisation\" target=\"_blank\">anonymization</a> on the UK Data Archive Website.</p>"
  }, 
  
  "Question5-1" => {
    text: "What data will you be sharing and in what form? (e.g. raw, processed, analyzed, final). Consider which data may need to be shared in order to meet institutional or funding requirements, and which data may be restricted because of confidentiality/privacy issues.", 
    section: "Data Sharing and Reuse", 
    organisation: "University of Alberta",
    number: 1,
    question_format: "Text area"
  },
 
  "Question5-2" => {
    text: "How will you be sharing your data? (e.g. institutional repository, a specialized data archive, project website, informal/on-request sharing).  Include a brief description of any resources needed to share your data (equipment, systems, expertise, etc.).", 
    section: "Data Sharing and Reuse", 
    organisation: "University of Alberta",
    number: 2,
    question_format: "Text area", 
    guidance: "<p>Where you share your data depends on the complexity and size of your data.  Smaller, low-risk datasets can be shared via institutional or disciplinary repositories and project websites. Larger datasets or datasets with more stringent security requirements cannot be easily transferred over the Internet.  Read more about sharing data at the <a href=\"http://www.data-archive.ac.uk/create-manage/planning-for-sharing/how-to-share-data\" target=\"_blank\">UK Data Archive</a>.</p>\r\n<p>Researchers at the University of Alberta can deposit smaller datasets (less than 500MB) in <a href=\"https://dataverse.library.ualberta.ca/dvn/\" target=\"_blank\">Dataverse</a> (for complex data formats such as that produced by SPSS or SAS) or <a href=\"https://era.library.ualberta.ca/public/home\" target=\"_blank\">ERA</a> (for basic data formats such as Excel).  For larger datasets, please contact <a href=\"mailto:data@ualberta.ca\">data@ualberta.ca</a>. </p>"
  }, 
  
  "Question5-3" => {
    text: "Please describe whether there will be any restrictions placed on your data when they are made available and who may access them.  If data are not openly available, describe the process for gaining access.", 
    section: "Data Sharing and Reuse", 
    organisation: "University of Alberta",
    number: 3,
    question_format: "Text area", 
    guidance: "<p>It may be necessary or desirable to restrict access to your data for a limited time or to a limited number of people, for:</p>\r\n<ul>\r\n<li>ethical reasons (privacy and confidentiality) </li>\r\n<li>economic reasons (patents and commercialization)</li>\r\n<li>intellectual property reasons (e.g. ownership of the original dataset on which yours is based) </li>\r\n<li>or to comply with a journal publishing policy.  </li>\r\n</ul>\r\n<p>Strategies to mitigate these issues may include: </p>\r\n<ul>\r\n<li>anonymising or aggregating data</li>\r\n<li>gaining participant consent for data sharing</li>\r\n<li>gaining permissions to share adapted or modified data</li>\r\n<li>and agreeing to a limited embargo period.</li>\r\n</ul>"
  }, 
  
  "Question6-1" => {
    text: "Who will be responsible for data management during the project? (i.e. during collection, processing, analysis, documentation).  Identify staff and organizational roles and their responsibilities for carrying out the data management plan (DMP), including time allocations and training requirements.", 
    section: "Responsibilities and Resources",
    organisation: "University of Alberta", 
    number: 1,
    question_format: "Text area"
  }, 
   
  "Question6-2" => {
    text:  "What will happen when personnel changes occur or if the principal investigator leaves the institution before the project has concluded?", 
    section: "Responsibilities and Resources", 
    organisation: "University of Alberta",
    number: 2,
    question_format: "Text area"
  }, 
  
  "Question6-3" => {
    text: "Who will be responsible for data sharing and preservation after the project has concluded? Indicate the party who will have primary responsibility for how the data will persist over time when the original personnel have moved on. ", 
    section: "Responsibilities and Resources", 
    organisation: "University of Alberta",
    number: 3, 
    question_format: "Text area"
  }, 
  
  "Question1-3" => {
    text: "If data are collected using laptops or mobile devices, please explain how will you will securely store and transfer the data.",
    section: "Data Collection",
    organisation: "University of Alberta",
    number: 3, 
    question_format: "Text area",
    guidance: "<p>The University of Alberta's Encryption Procedure requires that sensitive information stored on mobile computing devices be encrypted.  <a href=\"http://www.vpit.ualberta.ca/encryption/\" target=\"_blank\">Read more about encryption</a></p>"
  }, 
  
  "Question1-4" => {
    text: "How much data do you anticipate collecting?  Include an estimate of how much storage space you will require (in megabytes, gigabytes, terabytes).  This estimate should also take into account storage space required for file versioning, backups, and the growth rate over time. ", 
    section: "Data Collection", 
    organisation: "University of Alberta",
    number: 4, 
    question_format: "Text area",
    guidance: "<p>The type of data you collect will impact your storage requirements.  Textual and tabular data files are usually very small (a few megabytes) unless you have a lot of data.  Video files are usually very large (hundreds of megabytes up to several gigabytes).  If you have a large amount of data (gigabytes or terabytes), it will be more challenging to share and transfer it.  You may need to consider networked storage options or more sophisticated backup methods.</p>\r\n<p>If your data will be changing frequently, please estimate how much extra storage will be required to store multiple versions.  If you are collecting data over a long period of time (e.g. several months or years), please describe your plan for adding additional storage to accommodate the growth of your data.</p>"
  }, 
  
  "Question1-6" => {
    text: "What conventions and procedures will you use to structure, name and version control your files to ensure that your data is well-organized?", 
    section: "Data Collection",
    organisation: "University of Alberta",
    question_format: "Text area", 
    number: 6,
    guidance: "<p>Ensuring that you and your research team are using the 'master' version of your data is extremely important.  Establishing conventions for naming and versioning your files is essential, especially when data may be available in different file formats or stored on different computers.</p>\r\n<p>More information on file naming and version control is available from <a href=\"http://libraries.mit.edu/guides/subjects/data-management/organizing.html\" target=\"_blank\">MIT</a> and the <a href=\"http://www.data-archive.ac.uk/create-manage/format/versions\" target=\"_blank\">UK Data Archive</a>.</p>\r\n<p>University of Alberta Libraries' <a href=\"https://dataverse.library.ualberta.ca/dvn/\" target=\"_blank\">Dataverse</a> can help with version control of your files.</p>"
  }, 
  
  "Question5-4" => {
    text: "What type of end-user license will you include with your data? Please include a copy of this license with your Data Management Plan. ", 
    section: "Data Sharing and Reuse",
    organisation: "University of Alberta", 
    number: 4,
    question_format: "Text area", 
    guidance: "<p>Assigning an end-user license allows you to define the terms of use for your data.  We recommend a <a href=\"http://creativecommons.org/choose/\" target=\"_blank\">Creative Commons license</a>.</p>"
  }, 
  
  "Question6-4" => {
    text: "What resources will you require to implement your plan? Will extra people, time or hardware, storage be required? How much will this cost (estimation)?", 
    section: "Responsibilities and Resources", 
    organisation: "University of Alberta",
    number: 4,
    question_format: "Text area", 
    guidance: "<p>More information about estimating cost for data management is available through the <a href=\"http://data-archive.ac.uk/create-manage/planning-for-sharing/costing\" target=\"_blank\">UK Data Archive</a>. This information should be incorporated into any grant applications for your project.</p>"
  }, 
  "Portage1-1" => {
    text: "What types of data will you collect, create, link to, acquire and/or record?", 
    section: "Data Collection",
    organisation: "Portage", 
    number: 1, 
    question_format: "Text area", 
    guidance: "<p>Examples: numeric, images, audio, video, text, tabular data, modeling data, spatial data, instrumentation data.</p>"
  }, 
  "Portage1-2" => {
    text: "What file formats will your data be collected in? Will these formats allow for data re-use, sharing and long-term access to the data?",
    section: "Data Collection", 
    organisation: "Portage",
    number: 2, 
    question_format: "Text area", 
    guidance: "<p>Proprietary file formats requiring specialized software or hardware to use are not recommended, but may be necessary for certain data collection or analysis methods. Using open file formats or industry-standard formats (e.g. those widely used by a given community) is preferred whenever possible. </p><p>Read more about file formats: <a href=\"http://researchdata.library.ubc.ca/plan/format-your-data/\" target=\"_blank\">UBC Library</a> or <a href=\"http://data-archive.ac.uk/create-manage/format/formats\" target=\"_blank\">UK Data Archive</a>.</p>"
  }, 
  "Portage1-3" => {
    text: "What conventions and procedures will you use to structure, name and version-control your files to help you and others better understand how your data are organized?", 
    section: "Data Collection", 
    organisation: "Portage",
    number: 3, 
    question_format: "Text area", 
    guidance: "<p>It is important to keep track of different copies or versions of files, files held in different formats or locations, and information cross-referenced between files. This process is called 'version control'. </p><p>Logical file structures, informative naming conventions, and clear indications of file versions, all contribute to better use of your data during and after your research project.  These practices will help ensure that you and your research team are using the appropriate version of your data, and minimize confusion regarding copies on different computers and/or on different media. </p><p>Read more about file naming and version control: <a href=\"http://researchdata.library.ubc.ca/plan/organize-your-data/\" target=\"_blank\">UBC Library</a> or <a href=\"http://data-archive.ac.uk/create-manage/format/versions\" target=\"_blank\">UK Data Archive</a>.</p>"
  },
  "Portage2-1" => {
    text: "What documentation will be needed for the data to be read and interpreted correctly in the future?", 
    section: "Documentation and Metadata", 
    organisation: "Portage",
    number: 1, 
    question_format: "Text area", 
    guidance: "<p>Typically, good documentation includes information about the study, data-level descriptions, and any other contextual information required to make the data usable by other researchers.  Other elements you should document, as applicable, include: research methodology used, variable definitions, vocabularies, classification systems, units of measurement, assumptions made, format and file type of the data, a description of the data capture and collection methods, explanation of data coding and analysis performed (including syntax files), and details of who has worked on the project and performed each task, etc.</p>"
  }, 
  "Portage2-2" => {
    text: "How will you make sure that documentation is created or captured consistently throughout your project?",
    section: "Documentation and Metadata",
    organisation: "Portage",
    number: 2,
    question_format: "Text area",
    guidance: "<p>Consider how you will capture this information and where it will be recorded, ideally in advance of data collection and analysis, to ensure accuracy, consistency, and completeness of the documentation.  Often, resources you've already created can contribute to this (e.g. publications, websites, progress reports, etc.).  It is useful to consult regularly with members of the research team to capture potential changes in data collection/processing that need to be reflected in the documentation.  Individual roles and workflows should include gathering data documentation as a key element.</p>"
  },
  "Portage2-3" => {
    text: "If you are using a metadata standard and/or tools to document and describe your data, please list here.",
    section: "Documentation and Metadata",
    organisation: "Portage",
    number: 3,
    question_format: "Text area",
    guidance: "<p>There are many general and domain-specific metadata standards.  Dataset documentation should be provided in one of these standard, machine readable, openly-accessible formats to enable the effective exchange of information between users and systems.  These standards are often based on language-independent data formats such as XML, RDF, and JSON. There are many metadata standards based on these formats, including discipline-specific standards.</p> <p>Read more about metadata standards:  <a href=\"http://dcc.ac.uk/resources/metadata-standards\" target=\"_blank\">UK Digital Curation Centre's Disciplinary Metadata</a>. </p>"
  },
  "Portage3-1" => {
    text: "What are the anticipated storage requirements for your project, in terms of storage space (in megabytes, gigabytes, terabytes, etc.) and the length of time you will be storing it?",
    section: "Storage and Backup",
    organisation: "Portage",
    number: 1,
    question_format: "Text area",
    guidance: "<p>Storage-space estimates should take into account requirements for file versioning, backups, and growth over time.  </p> <p>If you are collecting data over a long period (e.g. several months or years), your data storage and backup strategy should accommodate data growth. Similarly, a long-term storage plan is necessary if you intend to retain your data after the research project.</p>"
  },
  "Portage3-2" => {
    text: "How and where will your data be stored and backed up during your research project?",
    section: "Storage and Backup",
    organisation: "Portage",
    number: 2,
    question_format: "Text area",
    guidance: "<p>The risk of losing data due to human error, natural disasters, or other mishaps can be mitigated by following the <a href=\"http://dataabinitio.com/?p=501\" target=\"_blank\">3-2-1 backup rule</a>:<br><ul><li>Have at least three copies of your data.</li><li>Store the copies on two different media.</li><li>Keep one backup copy offsite</li></ul></p><p>Data may be stored using optical or magnetic media, which can be removable (e.g. DVD and USB drives), fixed (e.g. desktop or laptop hard drives), or networked (e.g. networked drives or cloud-based servers). Each storage method has benefits and drawbacks that should be considered when determining the most appropriate solution. </p><p>Further information on storage and backup practices is available from the <a href=\"https://www.sheffield.ac.uk/library/rdm/storage\" target=\"_blank\">University of Sheffield Library</a> and the <a href=\"http://www.data-archive.ac.uk/create-manage/storage/back-up\" target=\"_blank\">UK Data Archive</a>.</p>"
  },
  "Portage3-3" => {
    text: "How will the research team and other collaborators access, modify, and contribute data throughout the project?",
    section: "Storage and Backup",
    organisation: "Portage",
    number: 3,
    question_format: "Text area",
    guidance: "<p>An ideal solution is one that facilitates co-operation and ensures data security, yet is able to be adopted by users with minimal training. Transmitting data between locations or within research teams can be challenging for data management infrastructure. Relying on email for data transfer is not a robust or secure solution. Third-party commercial file sharing services (such as Google Drive and Dropbox) facilitate file exchange, but they are not necessarily permanent or secure, and are often located outside Canada. Please contact your Library to develop the best solution for your research project.</p>"
  },
  "Portage4-1" => {
    text: "Where will you deposit your data for long-term preservation and access at the end of your research project?",
    section: "Preservation",
    organisation: "Portage",
    number: 1,
    question_format: "Text area",
    guidance: "<p>The issue of data retention should be considered early in the research lifecycle.  Data-retention decisions can be driven by external policies (e.g. funding agencies, journal publishers), or by an understanding of the enduring value of a given set of data.  The need to preserve data in the short-term (i.e. for peer-verification purposes) or long-term (for data of lasting value), will influence the choice of data repository or archive.  A helpful analogy is to think of creating a 'living will' for the data, that is, a plan describing how future researchers will have continued access to the data.</p><p>If you need assistance locating a suitable data repository or archive, please contact your Library.</p><p><a href=\"http://www.re3data.org/\" target=\"_blank\">re3data.org</a> is a directory of potential open data repositories. Verify whether or not the data repository will provide a statement agreeing to the terms of deposit outlined in your Data Management Plan.</p>"
  },
  "Portage4-2" => {
    text: "Indicate how you will ensure your data is preservation ready. Consider preservation-friendly file formats, ensuring file integrity, anonymization and de-identification, inclusion of supporting documentation.",
    section: "Preservation",
    organisation: "Portage",
    number: 2,
    question_format: "Text area",
    guidance: "<p>Some data formats are optimal for long-term preservation of data. For example, non-proprietary file formats, such as text ('.txt') and comma-separated ('.csv'), are considered preservation-friendly.  The UK Data Archive provides a useful table of file formats for various types of data.  Keep in mind that preservation-friendly files converted from one format to another may lose information (e.g. converting from an uncompressed TIFF file to a compressed JPG file), so changes to file formats should be documented.  </p> <p>Identify steps required following project completion in order to ensure the data you are choosing to preserve or share is anonymous, error-free, and converted to recommended formats with a minimal risk of data loss. </p> <p>Read more about anonymization: <a href=\"http://researchdata.library.ubc.ca/plan/format-your-data/\" target=\"_blank\">UBC Library</a> or <a href=\"http://data-archive.ac.uk/create-manage/consent-ethics/anonymisation\" target=\"_blank\">UK Data Archive</a>.</p>"
  },
  "Portage5-1" => {
    text: "What data will you be sharing and in what form? (e.g. raw, processed, analyzed, final).",
    section: "Sharing and Reuse",
    organisation: "Portage",
    number: 1,
    question_format: "Text area",
    guidance: "<p><b>Raw data</b> are the data directly obtained from the instrument, simulation or survey.</p><p><b>Processed data</b> result from some manipulation of the raw data in order to eliminate errors or outliers, to prepare the data for analysis, to derive new variables, or to de-identify the human participants. </p><p><b>Analyzed data</b> are the the results of qualitative, statistical, or mathematical analysis of the processed data. They can be presented as graphs, charts or statistical tables.</p><p><b>Final data</b> are processed data that have, if needed, been converted into a preservation-friendly format.</p><p>Consider which data may need to be shared in order to meet institutional or funding requirements, and which data may be restricted because of confidentiality/privacy/intellectual property considerations.</p>"
  },
   "Portage5-2" => {
    text: "Have you considered what type of end-user license to include with your data?",
    section: "Sharing and Reuse",
    organisation: "Portage",
    number: 2,
    question_format: "Text area",
    guidance: "<p>Licenses determine what uses can be made of your data. Funding agencies and/or data repositories may have end-user license requirements in place; if not, they may still be able to guide you in the development of a license. Once created, please consider including a copy of your end-user license with your Data Management Plan.  Note that only the intellectual property rights holder(s) can issue a license, so it is crucial to clarify who owns those rights. </p><p>There are several types of standard licenses available to researchers, such as the <a href=\"http://creativecommons.org/choose/\" target=\"_blank\">Creative Commons licenses</a> and the <a href=\"http://opendatacommons.org/licenses/\" target=\"_blank\">Open Data Commons licenses</a>. In fact, for most datasets it is easier to use a standard license rather than to devise a custom-made one. Note that even if you choose to make your data part of the public domain, it is preferable to make this explicit by using a license such as Creative Commons'  CC0. </p> <p>Read more about data licensing: <a href=\"http://www.dcc.ac.uk/resources/how-guides/license-research-data\" target=\"_blank\">UK Digital Curation Centre</a>. </p>"
  },
  "Portage5-3" => {
    text: "What steps will be taken to help the research community know that your data exists?",
    section: "Sharing and Reuse",
    organisation: "Portage",
    number: 3,
    question_format: "Text area",
    guidance: "<p>Possibilities include: data registries, repositories, indexes, word-of-mouth, publications.</p><p>How will the data be accessed (Web service, ftp, etc.)? If possible, choose a repository that will assign a persistent identifier (such as a DOI) to your dataset. This will ensure a stable access to the dataset and make it retrievable by various discovery tools.</p><p>One of the best ways to refer other researchers to your deposited datasets is to cite them the same way you cite other types of publications (articles, books, proceedings). The Digital Curation Centre provides a detailed <a href=\"http://www.dcc.ac.uk/resources/how-guides/cite-datasets\" target=\"_blank\">guide</a> on data citation.Note that some data repositories also create links from datasets to their associated papers, thus increasing the visibility of the publications.</p><p>Contact your Library for assistance in making your dataset visible and easily accessible. </p><p>Reused from NIH. (2009). <a href=\"https://grants.nih.gov/grants/sharing_key_elements_data_sharing_plan.pdf\" target=\"_blank\">Key Elements to Consider in Preparing a Data Sharing Plan Under NIH Extramural Support</a>. National Institutes of Health.</p>"
  },
  "Portage6-1" => {
    text: "Identify who will be responsible for managing this project's data during and after the project and the major data management tasks for which they will be responsible.",
    section: "Responsibilities and Resources",
    organisation: "Portage",
    number: 1,
    question_format: "Text area",
    guidance: "<p>Your data management plan has identified important data activities in your project. Identify who will be responsible -- individuals or organizations -- for carrying out these parts of your data management plan. This could also include the timeframe associated with these staff responsibilities and any training needed to prepare staff for these duties.</p>"
  },
  "Portage6-2" => {
    text: "How will responsibilities for managing data activities be handled if substantive changes happen in the personnel overseeing the project's data, including a change of Principal Investigator?",
    section: "Responsibilities and Resources",
    organisation: "Portage",
    number: 2,
    question_format: "Text area",
    guidance: "<p>Indicate a succession strategy for these data in the event that one or more people responsible for the data leaves (e.g. a graduate student leaving after graduation). Describe the process to be followed in the event that the Principal Investigator leaves the project. In some instances, a co-investigator or the department or division overseeing this research will assume responsibility.</p>"
  },
  "Portage6-3" => {
    text: "What resources will you require to implement your data management plan? What do you estimate the overall cost for data management to be?",   
    section: "Responsibilities and Resources",
    organisation: "Portage",
    number: 3,
    question_format: "Text area",
    guidance: "<p>This estimate should incorporate data management costs incurred during the project as well as those required for the longer-term support for the data after the project is finished. Items to consider in the latter category of expenses include the costs of curating and providing long-term access to the data. Some funding agencies state explicitly the support that they will provide to meet the cost of preparing data for deposit. This might include technical aspects of data management, training requirements, file storage & backup, and contributions of non-project staff.</p>"
  },
  "Portage7-1" => {
    text: "If your research project includes sensitive data, how will you ensure that it is securely managed and accessible only to approved members of the project?",
    section: "Ethics and Legal Compliance",
    organisation: "Portage",
    number: 1,
    question_format: "Text area",
    guidance: "<p>Consider where, how, and to whom sensitive data with acknowledged long-term value should be made available, and how long it should be archived. These decisions should align with Research Ethics Board requirements. The methods used to share data will be dependent on a number of factors such as the type, size, complexity and degree of sensitivity of data. Outline problems anticipated in sharing data, along with causes and possible measures to mitigate these. Problems may include confidentiality, lack of consent agreements, or concerns about Intellectual Property Rights, among others. In some instances, an embargo period may be justified; these may be defined by a funding agency's policy on research data. </p><p>Reused from: DCC. (2013). <a href=\"http://www.dcc.ac.uk/resources/data-management-plans\" target=\"_blank\">Checklist for a Data Management Plan</a>. v.4.0. Edinburgh: Digital Curation Centre</p><p>Restrictions can be imposed by limiting physical access to storage devices, by placing data on computers that do not have external network access (i.e. access to the Internet), through password protection, and by encrypting files.  Sensitive data should never be shared via email or cloud storage services such as Dropbox.</p>"
  },
  "Portage7-2" => {
    text: "If applicable, what strategies will you undertake to address secondary uses of sensitive data?",
    section: "Ethics and Legal Compliance",
    organisation: "Portage",
    number: 2,
    question_format: "Text area",
    guidance: "<p>Obtaining the appropriate consent from research participants is an important step in assuring Research Ethics Boards that the data may be shared with researchers outside your project. The consent statement may identify certain conditions clarifying the uses of the data by other researchers. For example, it may stipulate that the data will only be shared for non-profit research purposes or that the data will not be linked with personally identified data from other sources. </p><p>Read more about data security: <a href=\"http://data-archive.ac.uk/create-manage/storage/security\" target=\"_blank\">UK Data Archive</a></p>"
  },
  "Portage7-3" => {
    text: "How will you manage legal, ethical, and intellectual property issues?",
    section: "Ethics and Legal Compliance",
    organisation: "Portage",    
    number: 3,
    question_format: "Text area",
    guidance: "<p>Compliance with privacy legislation and laws that may impose content restrictions in the data should be discussed with your institution's privacy officer or research services office. Research Ethics Boards are central to the research process.</p><p>Include here a description concerning ownership, licensing, and intellectual property rights of the data. Terms of reuse must be clearly stated, in line with the relevant legal and ethical requirements where applicable (e.g., subject consent, permissions, restrictions, etc.).</p>"
  }
}

 questions.each do |q, details|
   question = Question.new
   question.text = details[:text]
   question.number = details[:number]
   question.guidance = details[:guidance]
   question.section_id = (Section.find_by_sql "Select id from sections where title = '#{details[:section]}' and organisation_id = #{Organisation.find_by_name(details[:organisation]).id}").first.id
   question.question_format_id = QuestionFormat.find_by_title(details[:question_format]).id
   question.save!
 end

 
questions_locales = {

  "Question1-1" => {
    text: "French - What types of data will you collect, create, acquire and/or record?", 
    section: "Data Collection", 
    organisation: "University of Alberta",
    number: 1, 
    locale: "fr",
    guidance: "Examples: Images, audio, video, text, tabular data, modeling data, spatial data, instrumentation data"
  },
   
  "Question1-5" => {
    text: "French - Are there are any existing data that you can re-use?  If so, please explain how you will obtain that data and integrate it into your research project.",
    section: "Data Collection", 
    organisation: "University of Alberta",
    number: 5,
	locale: "fr",
    guidance: "<p>There may be existing data that you can license or purchase for re-use.  <a href=\"http://databib.org/\" target=\"_blank\">Databib</a> and <a href=\"http://www.re3data.org/\" target=\"_blank\">re3data</a> are directories of disciplinary data repositories you can check for data.   You can also contact the <a href=\"http://www.library.ualberta.ca/aboutus/hss/data/\" target=\"_blank\">U of A Data Library</a> for help with finding and re-using existing data</p>" 
  }, 
  
  "Question1-2" => {
    text: "French - What file formats will your data be collected in?  Will these formats allow for data re-use, sharing and long-term access to the data?", 
    section: "Data Collection", 
    organisation: "University of Alberta",
    number: 2, 
	locale: "fr",
    guidance: "<p>Proprietary file formats which require specialized software or hardware to use are not recommended, but may be necessary for certain data collection or analysis methods.  Using open file formats or industry-standard formats (e.g. those which are widely used by a given community) is preferred whenever possible.  </p><p>Read more about file formats on the <a href=\"http://data-archive.ac.uk/create-manage/format/formats\" target=\"_blank\">UK Data Archive website</a>.</p>"
  },
  
  "Question2-1" => {
    text: "French - What documentation will be needed for the data to be read and interpreted correctly in the future?  This includes study-level documentation, data-level description, and any other contextual information required to make the data usable by other researchers.", 
    section: "Documentation and Metadata", 
    organisation: "University of Alberta",
    number: 1, 
	locale: "fr",
    guidance: "<p>Your documentation may include study-level information about:</p>\r\n<ul>\r\n<li>who created/collected the data</li>\r\n<li>when it was created</li>\r\n<li>any relevant study documents</li>\r\n<li>conditions of use</li>\r\n<li>contextual details about data collection methods and procedural documentation about how data files are stored, structured, and modified.  </li>\r\n</ul>\r\n<p>A complete description of the data files may include:</p>\r\n<ul>\r\n<li>naming and labelling conventions</li>\r\n<li>explanations of codes and variables</li>\r\n<li>any information or files require to reproduce derived data.  </li>\r\n</ul>\r\n<p>More information about data documentation is available at the <a href=\"http://www.data-archive.ac.uk/create-manage/document\" target=\"_blank\">UK Data Archive</a></p>"
  }, 
  
  "Question2-2" => {
    text: "French - Please list the metadata standard and tools you will use to document and describe your data.  If there is not an appropriate standard, please explain how you will ensure consistency in your documentation.", 
    section: "Documentation and Metadata", 
    organisation: "University of Alberta",
    number: 2,
	locale: "fr",
    guidance: "<p>Metadata is a description of the contents and context of data files. Using a metadata standard (a set of required fields to fill out) helps ensure that your documentation is consistent, structured, and machine-readable, which is essential for depositing data in repositories and making it easily discoverable by search engines.</p>\r\n<p>There are general and discipline-specific <a href=\"http://www.dcc.ac.uk/resources/metadata-standards\" target=\"_blank\">metadata standards and tools</a> for research data.  For assistance with choosing a metadata standard, please contact <a href=\"mailto:data@ualberta.ca\">data@ualberta.ca</a>.</p>"
  },    
  
  "Question2-3" => {
    text: "French - How will you make sure that documentation is created or captured consistently throughout your project?", 
    section: "Documentation and Metadata", 
    organisation: "University of Alberta",
    number: 3,
	locale: "fr",
    guidance: "It is best to begin the documentation process at the start of a research project.  Details or procedures may be forgotten if documentation is created at the end of a project."
  }, 
   
  "Question3-1" => {
    text:  "How will your data be stored and backed up during your research project?", 
    section: "Storage and Backup", 
    organisation: "University of Alberta",
    number: 1,
	locale: "fr",
    guidance: "<p>Storing data on flash drives, laptops, computers, or external hard drives without a regular backup procedure is not recommended, because they are subject to hardware failure, viruses, file corruption, theft, loss, and human error. Likewise, multiple copies of data stored in the same physical location does little to mitigate risk. </p>\r\n<p>Using software which automatically backs up your data and keeps it synchronized with a master copy is recommended. Copies of data should ideally be stored in separate physical locations to mitigate physical risks, e.g. fire.  More about data storage from <a href=\"http://data-archive.ac.uk/create-manage/storage.aspx\" target=\"_blank\">UK Data Archive</a>.</p>\r\n<p>Many universities offer networked file storage which is automatically backed up. University of Alberta researchers have access to networked storage and to commercial cloud storage (Google Drive) through <a href=\"http://ist.ualberta.ca/ts\" target=\"_blank\">Information Services and Technology</a>.\r\nUniversity of Alberta Libraries also offers <a href=\"https://dataverse.library.ualberta.ca/dvn/\" target=\"_blank\">Dataverse</a> for storing and sharing small datasets. For assistance with Dataverse, contact <a href=\"mailto:data@ualberta.ca\">data@ualberta.ca</a>. </p>"
  },  
  
  "Question3-2" => {
    text: "French - How will you ensure that sensitive data is stored securely and only accessible to the research team during the research project?", 
    section: "Storage and Backup", 
    organisation: "University of Alberta",
    number: 2,
	locale: "fr",
    guidance: "<p>The security measures you choose to implement will depend on the sensitivity of the data being stored.  Data can be protected by limiting physical access to hard drives and file servers on which it is stored, by storing data on computers that do not have external network access (i.e. access to the Internet), through password protection, and by encrypting data files.</p>\r\n<p>Sharing sensitive data via email and cloud storage services such as Dropbox is not recommended, since the security of these services cannot be trusted.  More about security from the <a href=\"http://data-archive.ac.uk/create-manage/storage/security\" target=\"_blank\">UK Data Archive</a>.</p>"
  },
 
  "Question4-1" => {
    text: "French - Which data are selected for preservation and access will depend on potential reuse value, whether there are obligations to either retain or destroy data, and the resources required to properly curate the data and ensure that it remains usable in the future.  In some circumstances, it may be feasible to preserve all versions of the data (e.g. raw, processed, analyzed, final), but in others, it may be preferable to only keep only selected data (e.g. transcripts instead of audio interviews).", 
    section: "Preservation", 
    organisation: "University of Alberta",
    number: 1,
	locale: "fr",
    guidance: "Which data are selected for preservation and access will depend on potential reuse value, whether there are obligations to either retain or destroy data, and the resources required to properly curate the data and ensure that it remains usable in the future.  In some circumstances, it may be feasible to preserve all versions of the data (e.g. raw, processed, analyzed, final), but in others, it may be preferable to only keep only selected data (e.g. transcripts instead of audio interviews)."
  }, 
  
  "Question4-2" => {
    text: "French - At the end of your research project, where will you deposit your data for long-term preservation and access? ", 
    section: "Preservation", 
    organisation: "University of Alberta",
    number: 2,
	locale: "fr",
    guidance: "<p>Please describe how you will identify a data repository or data center for your data.  <a href=\"http://databib.org/\" target=\"_blank\">Databib</a>  and <a href=\"http://www.re3data.org/\" target=\"_blank\">re3data.org</a> are directories of potential data repositories.  Note any details about the curation of the data and what aspects of the curation are your responsibility versus what the repository assumes. See if the data repository will provide a statement agreeing to these terms of deposit that can be included with your data management plan. </p>\r\n<p>Researchers at the University of Alberta can deposit smaller datasets (less than 500MB) in <a href=\"https://dataverse.library.ualberta.ca/dvn/\" target=\"_blank\">Dataverse</a> for complex data formats such as those produced by SPSS or SAS, or <a href=\"https://era.library.ualberta.ca/public/home\" target=\"_blank\">ERA</a> for basic data formats such as Excel.  For larger datasets, please contact <a href=\"mailto:data@ualberta.ca\">data@ualberta.ca</a>.  </p>"
  },
 
  "Question4-3" => {
    text: "French - Please describe how you will prepare the data for preservation and access, including any necessary procedures for data cleaning, normalization or de-identification.  Explain how you will prevent data from being lost while processing and converting files. ", 
    organisation: "University of Alberta",
    section: "Preservation", 
    number: 3,
	locale: "fr",
    guidance: "<p>It is likely that you will have multiple versions of your data (raw, processed, analyzed, final), and your data may be stored in different file formats depending on how they were collected and analyzed.</p>\r\n<p>Digital information may be lost while converting files from one format to another (e.g. converting an image from a non-compressed 'lossless' TIFF file to a compressed 'lossy' JPG file), so changes to file formats should be clearly documented.</p>\r\n<p>Identify what steps are needed after your project is completed in order to ensure the data you are choosing to preserve or share is anonymous, error-free, and converted to recommended formats with a minimal risk of data loss.</p>\r\n<p>Read more about <a href=\"http://data-archive.ac.uk/create-manage/format/formats\" target=\"_blank\">file formats</a> and <a href=\"http://data-archive.ac.uk/create-manage/consent-ethics/anonymisation\" target=\"_blank\">anonymization</a> on the UK Data Archive Website.</p>"
  }, 
  
  "Question5-1" => {
    text: "French - What data will you be sharing and in what form? (e.g. raw, processed, analyzed, final). Consider which data may need to be shared in order to meet institutional or funding requirements, and which data may be restricted because of confidentiality/privacy issues.", 
    section: "Data Sharing and Reuse", 
    organisation: "University of Alberta",
    number: 1,
	locale: "fr",
  },
 
  "Question5-2" => {
    text: "French - How will you be sharing your data? (e.g. institutional repository, a specialized data archive, project website, informal/on-request sharing).  Include a brief description of any resources needed to share your data (equipment, systems, expertise, etc.).", 
    section: "Data Sharing and Reuse", 
    organisation: "University of Alberta",
    number: 2,
	locale: "fr",
    guidance: "<p>Where you share your data depends on the complexity and size of your data.  Smaller, low-risk datasets can be shared via institutional or disciplinary repositories and project websites. Larger datasets or datasets with more stringent security requirements cannot be easily transferred over the Internet.  Read more about sharing data at the <a href=\"http://www.data-archive.ac.uk/create-manage/planning-for-sharing/how-to-share-data\" target=\"_blank\">UK Data Archive</a>.</p>\r\n<p>Researchers at the University of Alberta can deposit smaller datasets (less than 500MB) in <a href=\"https://dataverse.library.ualberta.ca/dvn/\" target=\"_blank\">Dataverse</a> (for complex data formats such as that produced by SPSS or SAS) or <a href=\"https://era.library.ualberta.ca/public/home\" target=\"_blank\">ERA</a> (for basic data formats such as Excel).  For larger datasets, please contact <a href=\"mailto:data@ualberta.ca\">data@ualberta.ca</a>. </p>"
  }, 
  
  "Question5-3" => {
    text: "French - Please describe whether there will be any restrictions placed on your data when they are made available and who may access them.  If data are not openly available, describe the process for gaining access.", 
    section: "Data Sharing and Reuse", 
    organisation: "University of Alberta",
    number: 3,
	locale: "fr",
    guidance: "<p>It may be necessary or desirable to restrict access to your data for a limited time or to a limited number of people, for:</p>\r\n<ul>\r\n<li>ethical reasons (privacy and confidentiality) </li>\r\n<li>economic reasons (patents and commercialization)</li>\r\n<li>intellectual property reasons (e.g. ownership of the original dataset on which yours is based) </li>\r\n<li>or to comply with a journal publishing policy.  </li>\r\n</ul>\r\n<p>Strategies to mitigate these issues may include: </p>\r\n<ul>\r\n<li>anonymising or aggregating data</li>\r\n<li>gaining participant consent for data sharing</li>\r\n<li>gaining permissions to share adapted or modified data</li>\r\n<li>and agreeing to a limited embargo period.</li>\r\n</ul>"
  }, 
  
  "Question6-1" => {
    text: "French - Who will be responsible for data management during the project? (i.e. during collection, processing, analysis, documentation).  Identify staff and organizational roles and their responsibilities for carrying out the data management plan (DMP), including time allocations and training requirements.", 
    section: "Responsibilities and Resources", 
    organisation: "University of Alberta",
    number: 1,
	locale: "fr",
  }, 
   
  "Question6-2" => {
    text:  "What will happen when personnel changes occur or if the principal investigator leaves the institution before the project has concluded?", 
    section: "Responsibilities and Resources", 
    organisation: "University of Alberta",
    number: 2,
	locale: "fr",
  }, 
  
  "Question6-3" => {
    text: "French - Who will be responsible for data sharing and preservation after the project has concluded? Indicate the party who will have primary responsibility for how the data will persist over time when the original personnel have moved on. ", 
    section: "Responsibilities and Resources", 
    organisation: "University of Alberta",
    number: 3, 
	locale: "fr",
  }, 
  
  "Question1-3" => {
    text: "French - If data are collected using laptops or mobile devices, please explain how will you will securely store and transfer the data.",
    section: "Data Collection",
    organisation: "University of Alberta",
    number: 3, 
	locale: "fr",
    guidance: "<p>The University of Alberta's Encryption Procedure requires that sensitive information stored on mobile computing devices be encrypted.  <a href=\"http://www.vpit.ualberta.ca/encryption/\" target=\"_blank\">Read more about encryption</a></p>"
  }, 
  
  "Question1-4" => {
    text: "French - How much data do you anticipate collecting?  Include an estimate of how much storage space you will require (in megabytes, gigabytes, terabytes).  This estimate should also take into account storage space required for file versioning, backups, and the growth rate over time. ", 
    section: "Data Collection", 
    organisation: "University of Alberta",
    number: 4, 
	locale: "fr",
    guidance: "<p>The type of data you collect will impact your storage requirements.  Textual and tabular data files are usually very small (a few megabytes) unless you have a lot of data.  Video files are usually very large (hundreds of megabytes up to several gigabytes).  If you have a large amount of data (gigabytes or terabytes), it will be more challenging to share and transfer it.  You may need to consider networked storage options or more sophisticated backup methods.</p>\r\n<p>If your data will be changing frequently, please estimate how much extra storage will be required to store multiple versions.  If you are collecting data over a long period of time (e.g. several months or years), please describe your plan for adding additional storage to accommodate the growth of your data.</p>"
  }, 
  
  "Question1-6" => {
    text: "French - What conventions and procedures will you use to structure, name and version control your files to ensure that your data is well-organized?", 
    section: "Data Collection",
    organisation: "University of Alberta",
    number: 6,
	locale: "fr",
    guidance: "<p>Ensuring that you and your research team are using the 'master' version of your data is extremely important.  Establishing conventions for naming and versioning your files is essential, especially when data may be available in different file formats or stored on different computers.</p>\r\n<p>More information on file naming and version control is available from <a href=\"http://libraries.mit.edu/guides/subjects/data-management/organizing.html\" target=\"_blank\">MIT</a> and the <a href=\"http://www.data-archive.ac.uk/create-manage/format/versions\" target=\"_blank\">UK Data Archive</a>.</p>\r\n<p>University of Alberta Libraries' <a href=\"https://dataverse.library.ualberta.ca/dvn/\" target=\"_blank\">Dataverse</a> can help with version control of your files.</p>"
  }, 
  
  "Question5-4" => {
    text: "French - What type of end-user license will you include with your data? Please include a copy of this license with your Data Management Plan. ", 
    section: "Data Sharing and Reuse", 
    organisation: "University of Alberta",
    number: 4,
	locale: "fr",
    guidance: "<p>Assigning an end-user license allows you to define the terms of use for your data.  We recommend a <a href=\"http://creativecommons.org/choose/\" target=\"_blank\">Creative Commons license</a>.</p>"
  }, 
  
  "Question6-4" => {
    text: "French - What resources will you require to implement your plan? Will extra people, time or hardware, storage be required? How much will this cost (estimation)?", 
    section: "Responsibilities and Resources", 
    organisation: "University of Alberta",
    number: 4,
	locale: "fr",
    guidance: "<p>More information about estimating cost for data management is available through the <a href=\"http://data-archive.ac.uk/create-manage/planning-for-sharing/costing\" target=\"_blank\">UK Data Archive</a>. This information should be incorporated into any grant applications for your project.</p>"
  },
  "Portage1-1" => {
    text: "French - What types of data will you collect, create, link to, acquire and/or record?", 
    section: "Data Collection",
    organisation: "Portage", 
    number: 1, 
    locale: "fr", 
    guidance: "<p>French - Examples: numeric, images, audio, video, text, tabular data, modeling data, spatial data, instrumentation data.</p>"
  }, 
  "Portage1-2" => {
    text: "French - What file formats will your data be collected in? Will these formats allow for data re-use, sharing and long-term access to the data?",
    section: "Data Collection", 
    organisation: "Portage",
    number: 2, 
    locale: "fr",
    guidance: "<p>French - Proprietary file formats requiring specialized software or hardware to use are not recommended, but may be necessary for certain data collection or analysis methods. Using open file formats or industry-standard formats (e.g. those widely used by a given community) is preferred whenever possible. </p><p>Read more about file formats: <a href=\"http://researchdata.library.ubc.ca/plan/format-your-data/\" target=\"_blank\">UBC Library</a> or <a href=\"http://data-archive.ac.uk/create-manage/format/formats\" target=\"_blank\">UK Data Archive</a>.</p>"
  }, 
  "Portage1-3" => {
    text: "French - What conventions and procedures will you use to structure, name and version-control your files to help you and others better understand how your data are organized?", 
    organisation: "Portage", 
    section: "Data Collection", 
    number: 3,
    locale: "fr", 
    guidance: "<p>French - It is important to keep track of different copies or versions of files, files held in different formats or locations, and information cross-referenced between files. This process is called 'version control'. </p><p>Logical file structures, informative naming conventions, and clear indications of file versions, all contribute to better use of your data during and after your research project.  These practices will help ensure that you and your research team are using the appropriate version of your data, and minimize confusion regarding copies on different computers and/or on different media. </p><p>Read more about file naming and version control: <a href=\"http://researchdata.library.ubc.ca/plan/organize-your-data/\" target=\"_blank\">UBC Library</a> or <a href=\"http://data-archive.ac.uk/create-manage/format/versions\" target=\"_blank\">UK Data Archive</a>.</p>"
  },
  "Portage2-1" => {
    text: "French - What documentation will be needed for the data to be read and interpreted correctly in the future?", 
    section: "Documentation and Metadata", 
    organisation: "Portage",
    number: 1,
    locale: "fr", 
    guidance: "<p>French - Typically, good documentation includes information about the study, data-level descriptions, and any other contextual information required to make the data usable by other researchers.  Other elements you should document, as applicable, include: research methodology used, variable definitions, vocabularies, classification systems, units of measurement, assumptions made, format and file type of the data, a description of the data capture and collection methods, explanation of data coding and analysis performed (including syntax files), and details of who has worked on the project and performed each task, etc.</p>"
  }, 
  "Portage2-2" => {
    text: "French - How will you make sure that documentation is created or captured consistently throughout your project?",
    section: "Documentation and Metadata",
    organisation: "Portage",
    number: 2,
    locale: "fr",
    guidance: "<p>French - Consider how you will capture this information and where it will be recorded, ideally in advance of data collection and analysis, to ensure accuracy, consistency, and completeness of the documentation.  Often, resources you've already created can contribute to this (e.g. publications, websites, progress reports, etc.).  It is useful to consult regularly with members of the research team to capture potential changes in data collection/processing that need to be reflected in the documentation.  Individual roles and workflows should include gathering data documentation as a key element.</p>"
  },
  "Portage2-3" => {
    text: "French - If you are using a metadata standard and/or tools to document and describe your data, please list here.",
    section: "Documentation and Metadata",
    organisation: "Portage",
    number: 3,
    locale: "fr",
    guidance: "<p>French - There are many general and domain-specific metadata standards.  Dataset documentation should be provided in one of these standard, machine readable, openly-accessible formats to enable the effective exchange of information between users and systems.  These standards are often based on language-independent data formats such as XML, RDF, and JSON. There are many metadata standards based on these formats, including discipline-specific standards.</p> <p>Read more about metadata standards:  <a href=\"http://dcc.ac.uk/resources/metadata-standards\" target=\"_blank\">UK Digital Curation Centre's Disciplinary Metadata</a>. </p>"
  },
  "Portage3-1" => {
    text: "French - What are the anticipated storage requirements for your project, in terms of storage space (in megabytes, gigabytes, terabytes, etc.) and the length of time you will be storing it?",
    section: "Storage and Backup",
    organisation: "Portage",
    number: 1,
    locale: "fr",
    guidance: "<p>French - Storage-space estimates should take into account requirements for file versioning, backups, and growth over time.  </p> <p>If you are collecting data over a long period (e.g. several months or years), your data storage and backup strategy should accommodate data growth. Similarly, a long-term storage plan is necessary if you intend to retain your data after the research project.</p>"
  },
  "Portage3-2" => {
    text: "French - How and where will your data be stored and backed up during your research project?",
    section: "Storage and Backup",
    organisation: "Portage",
    number: 2,
    locale: "fr",
    guidance: "<p>French - The risk of losing data due to human error, natural disasters, or other mishaps can be mitigated by following the <a href=\"http://dataabinitio.com/?p=501\" target=\"_blank\">3-2-1 backup rule</a>:<br><ul><li>Have at least three copies of your data.</li><li>Store the copies on two different media.</li><li>Keep one backup copy offsite</li></ul></p><p>Data may be stored using optical or magnetic media, which can be removable (e.g. DVD and USB drives), fixed (e.g. desktop or laptop hard drives), or networked (e.g. networked drives or cloud-based servers). Each storage method has benefits and drawbacks that should be considered when determining the most appropriate solution. </p><p>Further information on storage and backup practices is available from the <a href=\"https://www.sheffield.ac.uk/library/rdm/storage\" target=\"_blank\">University of Sheffield Library</a> and the <a href=\"http://www.data-archive.ac.uk/create-manage/storage/back-up\" target=\"_blank\">UK Data Archive</a>.</p>"
  },
  "Portage3-3" => {
    text: "French - How will the research team and other collaborators access, modify, and contribute data throughout the project?",
    section: "Storage and Backup",
    organisation: "Portage", 
    number: 3,
    locale: "fr",
    guidance: "<p>French - An ideal solution is one that facilitates co-operation and ensures data security, yet is able to be adopted by users with minimal training. Transmitting data between locations or within research teams can be challenging for data management infrastructure. Relying on email for data transfer is not a robust or secure solution. Third-party commercial file sharing services (such as Google Drive and Dropbox) facilitate file exchange, but they are not necessarily permanent or secure, and are often located outside Canada. Please contact your Library to develop the best solution for your research project.</p>"
  },
  "Portage4-1" => {
    text: "French - Where will you deposit your data for long-term preservation and access at the end of your research project?",
    section: "Preservation",
    organisation: "Portage",
    number: 1,
    locale: "fr",
    guidance: "<p>French - The issue of data retention should be considered early in the research lifecycle.  Data-retention decisions can be driven by external policies (e.g. funding agencies, journal publishers), or by an understanding of the enduring value of a given set of data.  The need to preserve data in the short-term (i.e. for peer-verification purposes) or long-term (for data of lasting value), will influence the choice of data repository or archive.  A helpful analogy is to think of creating a 'living will' for the data, that is, a plan describing how future researchers will have continued access to the data.</p><p>If you need assistance locating a suitable data repository or archive, please contact your Library.</p><p><a href=\"http://www.re3data.org/\" target=\"_blank\">re3data.org</a> is a directory of potential open data repositories. Verify whether or not the data repository will provide a statement agreeing to the terms of deposit outlined in your Data Management Plan.</p>"
  },
  "Portage4-2" => {
    text: "French - Indicate how you will ensure your data is preservation ready. Consider preservation-friendly file formats, ensuring file integrity, anonymization and de-identification, inclusion of supporting documentation.",
    section: "Preservation",
    organisation: "Portage",
    number: 2,
    locale: "fr",
    guidance: "<p>French - Some data formats are optimal for long-term preservation of data. For example, non-proprietary file formats, such as text ('.txt') and comma-separated ('.csv'), are considered preservation-friendly.  The UK Data Archive provides a useful table of file formats for various types of data.  Keep in mind that preservation-friendly files converted from one format to another may lose information (e.g. converting from an uncompressed TIFF file to a compressed JPG file), so changes to file formats should be documented.  </p> <p>Identify steps required following project completion in order to ensure the data you are choosing to preserve or share is anonymous, error-free, and converted to recommended formats with a minimal risk of data loss. </p> <p>Read more about anonymization: <a href=\"http://researchdata.library.ubc.ca/plan/format-your-data/\" target=\"_blank\">UBC Library</a> or <a href=\"http://data-archive.ac.uk/create-manage/consent-ethics/anonymisation\" target=\"_blank\">UK Data Archive</a>.</p>"
  },
  "Portage5-1" => {
    text: "French - What data will you be sharing and in what form? (e.g. raw, processed, analyzed, final).",
    section: "Sharing and Reuse",
    organisation: "Portage",
    number: 1,
    locale: "fr",
    question_format: "Text area",
    guidance: "<p>French-<b>Raw data</b> are the data directly obtained from the instrument, simulation or survey.</p><p><b>Processed data</b> result from some manipulation of the raw data in order to eliminate errors or outliers, to prepare the data for analysis, to derive new variables, or to de-identify the human participants. </p><p><b>Analyzed data</b> are the the results of qualitative, statistical, or mathematical analysis of the processed data. They can be presented as graphs, charts or statistical tables.</p><p><b>Final data</b> are processed data that have, if needed, been converted into a preservation-friendly format.</p><p>Consider which data may need to be shared in order to meet institutional or funding requirements, and which data may be restricted because of confidentiality/privacy/intellectual property considerations.</p>"
  },
   "Portage5-2" => {
    text: "French - Have you considered what type of end-user license to include with your data?",
    section: "Sharing and Reuse",
    organisation: "Portage",
    number: 2,
    locale: "fr",
    guidance: "<p>French - Licenses determine what uses can be made of your data. Funding agencies and/or data repositories may have end-user license requirements in place; if not, they may still be able to guide you in the development of a license. Once created, please consider including a copy of your end-user license with your Data Management Plan.  Note that only the intellectual property rights holder(s) can issue a license, so it is crucial to clarify who owns those rights. </p><p>There are several types of standard licenses available to researchers, such as the <a href=\"http://creativecommons.org/choose/\" target=\"_blank\">Creative Commons licenses</a> and the <a href=\"http://opendatacommons.org/licenses/\" target=\"_blank\">Open Data Commons licenses</a>. In fact, for most datasets it is easier to use a standard license rather than to devise a custom-made one. Note that even if you choose to make your data part of the public domain, it is preferable to make this explicit by using a license such as Creative Commons'  CC0. </p> <p>Read more about data licensing: <a href=\"http://www.dcc.ac.uk/resources/how-guides/license-research-data\" target=\"_blank\">UK Digital Curation Centre</a>. </p>"
  },
  "Portage5-3" => {
    text: "French - What steps will be taken to help the research community know that your data exists?",
    section: "Sharing and Reuse",
    organisation: "Portage",
    number: 3,
    locale: "fr",
    guidance: "<p>French - Possibilities include: data registries, repositories, indexes, word-of-mouth, publications.</p><p>How will the data be accessed (Web service, ftp, etc.)? If possible, choose a repository that will assign a persistent identifier (such as a DOI) to your dataset. This will ensure a stable access to the dataset and make it retrievable by various discovery tools.</p><p>One of the best ways to refer other researchers to your deposited datasets is to cite them the same way you cite other types of publications (articles, books, proceedings). The Digital Curation Centre provides a detailed <a href=\"http://www.dcc.ac.uk/resources/how-guides/cite-datasets\" target=\"_blank\">guide</a> on data citation.Note that some data repositories also create links from datasets to their associated papers, thus increasing the visibility of the publications.</p><p>Contact your Library for assistance in making your dataset visible and easily accessible. </p><p>Reused from NIH. (2009). <a href=\"https://grants.nih.gov/grants/sharing_key_elements_data_sharing_plan.pdf\" target=\"_blank\">Key Elements to Consider in Preparing a Data Sharing Plan Under NIH Extramural Support</a>. National Institutes of Health.</p>"
  },
  "Portage6-1" => {
    text: "French - Identify who will be responsible for managing this project's data during and after the project and the major data management tasks for which they will be responsible.",
    section: "Responsibilities and Resources",
    organisation: "Portage",
    number: 1,
    locale: "fr",
    guidance: "<p>French - Your data management plan has identified important data activities in your project. Identify who will be responsible -- individuals or organizations -- for carrying out these parts of your data management plan. This could also include the timeframe associated with these staff responsibilities and any training needed to prepare staff for these duties.</p>"
  },
  "Portage6-2" => {
    text: "French - How will responsibilities for managing data activities be handled if substantive changes happen in the personnel overseeing the project's data, including a change of Principal Investigator?",
    section: "Responsibilities and Resources",
    organisation: "Portage",
    number: 2,
    locale: "fr",
    guidance: "<p>French - Indicate a succession strategy for these data in the event that one or more people responsible for the data leaves (e.g. a graduate student leaving after graduation). Describe the process to be followed in the event that the Principal Investigator leaves the project. In some instances, a co-investigator or the department or division overseeing this research will assume responsibility.</p>"
  },
  "Portage6-3" => {
    text: "French - What resources will you require to implement your data management plan? What do you estimate the overall cost for data management to be?",   
    section: "Responsibilities and Resources",
    organisation: "Portage",
    number: 3,
    locale: "fr",
    guidance: "<p>French - This estimate should incorporate data management costs incurred during the project as well as those required for the longer-term support for the data after the project is finished. Items to consider in the latter category of expenses include the costs of curating and providing long-term access to the data. Some funding agencies state explicitly the support that they will provide to meet the cost of preparing data for deposit. This might include technical aspects of data management, training requirements, file storage & backup, and contributions of non-project staff.</p>"
  },
  "Portage7-1" => {
    text: "French - If your research project includes sensitive data, how will you ensure that it is securely managed and accessible only to approved members of the project?",
    section: "Ethics and Legal Compliance",
    organisation: "Portage",
    number: 1,
    locale: "fr",
    guidance: "<p>French - Consider where, how, and to whom sensitive data with acknowledged long-term value should be made available, and how long it should be archived. These decisions should align with Research Ethics Board requirements. The methods used to share data will be dependent on a number of factors such as the type, size, complexity and degree of sensitivity of data. Outline problems anticipated in sharing data, along with causes and possible measures to mitigate these. Problems may include confidentiality, lack of consent agreements, or concerns about Intellectual Property Rights, among others. In some instances, an embargo period may be justified; these may be defined by a funding agency's policy on research data. </p><p>Reused from: DCC. (2013). <a href=\"http://www.dcc.ac.uk/resources/data-management-plans\" target=\"_blank\">Checklist for a Data Management Plan</a>. v.4.0. Edinburgh: Digital Curation Centre</p><p>Restrictions can be imposed by limiting physical access to storage devices, by placing data on computers that do not have external network access (i.e. access to the Internet), through password protection, and by encrypting files.  Sensitive data should never be shared via email or cloud storage services such as Dropbox.</p>"
  },
  "Portage7-2" => {
    text: "French - If applicable, what strategies will you undertake to address secondary uses of sensitive data?",
    section: "Ethics and Legal Compliance",
    organisation: "Portage",
    number: 2,
    locale: "fr",
    guidance: "<p>French - Obtaining the appropriate consent from research participants is an important step in assuring Research Ethics Boards that the data may be shared with researchers outside your project. The consent statement may identify certain conditions clarifying the uses of the data by other researchers. For example, it may stipulate that the data will only be shared for non-profit research purposes or that the data will not be linked with personally identified data from other sources. </p><p>Read more about data security: <a href=\"http://data-archive.ac.uk/create-manage/storage/security\" target=\"_blank\">UK Data Archive</a></p>"
  },
  "Portage7-3" => {
    text: "French - How will you manage legal, ethical, and intellectual property issues?",
    section: "Ethics and Legal Compliance",
    organisation: "Portage",
    number: 3,
    locale: "fr",
    guidance: "<p>French - Compliance with privacy legislation and laws that may impose content restrictions in the data should be discussed with your institution's privacy officer or research services office. Research Ethics Boards are central to the research process.</p><p>Include here a description concerning ownership, licensing, and intellectual property rights of the data. Terms of reuse must be clearly stated, in line with the relevant legal and ethical requirements where applicable (e.g., subject consent, permissions, restrictions, etc.).</p>"
  }
}

 questions_locales.each do |q, details|
   question = Question::Translation.new
   question.locale = details[:locale]
   question.question_id = (Question.find_by_sql "Select id from questions where section_id = #{(Section.find_by_sql "Select id from sections where title = '#{details[:section]}' and organisation_id = #{Organisation.find_by_name(details[:organisation]).id}").first.id} and number = #{details[:number]}").first.attributes["id"]
   question.text = details[:text]
   question.guidance = details[:guidance]
   question.save!
 end
 
 templates_locales = {
  "University of Alberta" => {
    title: "French - University of Alberta Template", 
    description: "This is the generic DMP template for University of Alberta (Should be in French).",
    template_en: "University of Alberta Template",
    locale: "fr"
  },
  "Portage" => {
    title: "French - Portage Template", 
    description: "This is the generic DMP template for Portage (Should be in French). ",
    template_en: "Portage Template", 
    locale: "fr"
  }
}

 templates_locales.each do |t, details|
   template = Dmptemplate::Translation.new
   template.title = details[:title]
   template.description = details[:description]
   template.locale = details[:locale]
   template.dmptemplate_id = Dmptemplate.find_by_title(details[:template_en]).id
   template.save!
 end

phases_locales = {
  "University of Alberta" => {
    title: "French - University of Alberta Data Management Questions", 
	locale: "fr", 
    number: 1, 
    template: "University of Alberta Template"
   }, 
  "Portage" => {
    title: "French - Portage Data Management Questions",
    locale: "fr",
    number: 1,
    template: "Portage Template"
  }
}

phases_locales.each do |p, details|
   phase = Phase::Translation.new
   phase.title = details[:title]
   phase.phase_id = (Phase.find_by_sql "Select id from phases where dmptemplate_id = #{Dmptemplate.find_by_title(details[:template]).id} and number = #{details[:number]}").first.attributes["id"]
   phase.locale = details[:locale]
   phase.save!
 end

versions_locales = {
  "University of Alberta" => {
    title: "French - University of Alberta Version 1", 
    number: 1, 
    phase: "University of Alberta Data Management Questions",
    locale: "fr",
  }, 
  "Portage" => {
    title: "French - Portage Version 1",
    number: 1,
    phase: "Portage Data Management Questions",
    locale: "fr",
  }
}

 versions_locales.each do |v, details|
   version = Version::Translation.new
   version.title = details[:title]
   version.version_id = (Version.find_by_sql "Select id from versions where phase_id = #{Phase.find_by_title(details[:phase]).id} and number = #{details[:number]}").first.attributes["id"]
   version.locale = details[:locale]
   version.save!
 end

sections_locales = {
  "Data Collection" => {
    title: "French - Data Collection", 
    number: 1, 
    version: "University of Alberta Version 1",
    locale: "fr",
  },
  "Documentation and Metadata" => {
    title: "French - Documentation and Metadata", 
    number: 2, 
    version: "University of Alberta Version 1", 
    locale: "fr",
  },
  "Storage and Backup" => {
    title: "French - Storage and Backup", 
    number: 3, 
    version: "University of Alberta Version 1", 
    locale: "fr",
  },
  "Preservation" => {
    title: "French - Preservation", 
    number: 4, 
    version: "University of Alberta Version 1", 
    locale: "fr",
  }, 
  "Data Sharing and Reuse" => {
    title: "French - Data Sharing and Reuse", 
    number: 5, 
    version: "University of Alberta Version 1", 
    locale: "fr",
  }, 
  "Responsibilites and Resources" => {
    title: "French - Responsibilities and Resources", 
    number: 6,
    version: "University of Alberta Version 1",	
    locale: "fr",
  },
  "Data Collection" => {
    title: "French - Data Collection", 
    number: 1, 
    version: "Portage Version 1", 
    locale: "fr",
  },
  "Documentation and Metadata" => {
    title: "French - Documentation and Metadata",
    number: 2,
    version: "Portage Version 1", 
    locale: "fr",
  }, 
  "Storage and Backup" => {
    title: "French - Storage and Backup", 
    number: 3, 
    version: "Portage Version 1", 
    locale: "fr",
  }, 
  "Preservation" => {
    title: "French - Preservation", 
    number: 4, 
    version: "Portage Version 1", 
    locale: "fr",
  }, 
  "Sharing and Reuse" => {
    title: "French - Sharing and Reuse", 
    number: 5, 
    version: "Portage Version 1", 
    locale: "fr",
  }, 
  "Responsibilities and Resources" => {
    title: "French - Responsibilities and Resources", 
    number: 6, 
    version: "Portage Version 1", 
    locale: "fr",
  }, 
  "Ethics and Legal Compliance" => {
    title: "French - Ethics and Legal Compliance", 
    number: 7, 
    version: "Portage Version 1", 
    locale: "fr",
  } 
}

 sections_locales.each do |s, details|
   section = Section::Translation.new
   section.title = details[:title]
   section.section_id = (Section.find_by_sql "Select id from sections where version_id = #{Version.find_by_title(details[:version]).id} and number = #{details[:number]}").first.attributes["id"]
   section.locale = details[:locale]
   section.description = details[:description]
   section.save!
 end

  question_formats_locales = {
   "Text area" => {
     title: "Zone de texte",
     locale: "fr",
     title_en: "Text Area"
   },
   "Text field" => {
     title_en: "Text field",
     title: "Case de saisie simple",
     locale: "fr"
   },
   "Radio buttons" => {
     title_en: "Radio buttons",
     title: "Boutons d'option",
     locale: "fr"
   },
   "Check box" => {
     title_en: "Check box",
     title: "Case à cocher",
     locale: "fr"
   },
   "Dropdown" => {
     title_en: "Dropdown",
     title: "Liste déroulante", 
     locale: "fr"
   },
   "Multi select box" => {
     title_en: "Multi select box", 
     title: "Case à options multiples",
     locale: "fr"
   },
 }

 question_formats_locales.each do |qf, details|
   question_format = QuestionFormat::Translation.new
   question_format.title = details[:title]
   question_format.question_format_id = QuestionFormat.find_by_title(details[:title_en]).id
   question_format.locale = details[:locale]
   question_format.save!
 end

