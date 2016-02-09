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
  exists = OrganisationType.find_by_name(details[:name])  
  if !exists
    organisation_type = OrganisationType.new
    organisation_type.name = details[:name]
    organisation_type.save!
  end
end


 organisations = {
   'Portage' => {
      name: "Portage",
      abbreviation: "Portage",
      sort_name: "Portage",
      domain: "carl-abrc.ca",
      organisation_type: "Organization"
    },
 }

organisations.each do |org, details|
   exists = Organisation.find_by_name(details[:name])
   if !exists
     organisation = Organisation.new
     organisation.name = details[:name]
     organisation.abbreviation = details[:abbreviation]
     organisation.domain = details[:domain]
     organisation.sort_name = details[:sort_name]
     organisation.organisation_type = OrganisationType.find_by_name(details[:organisation_type])
     organisation.save!
   end
end

# uses encrypted password.  See passwrod safe!
exists = User.find_by_email('dittest@ualberta.ca')
if !exists
 
  admin = User.new(
    {firstname: "DMP", surname: "Administrator", email: "dittest@ualberta.ca",
     password: "password", password_confirmation: "password"})
  admin.encrypted_password = "$2a$10$q7XUQxvbFb1QcYhrngqcd..sM8.DsviZUxUBwDpC7ZmuohHrkOeZm"
  admin.add_role(:admin)
  admin.organisation_id = Organisation.find_by_name('Portage').id
  admin.skip_confirmation!
  admin.save!
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
   exists = QuestionFormat.find_by_title(details[:title])
   if !exists
     question_format = QuestionFormat.new
     question_format.title = details[:title]
     question_format.save!
   end
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
  exists = UserStatus.find_by_name(details[:name])
  if !exists
    user_status = UserStatus.new
    user_status.name = details[:name]
    user_status.save!
  end
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
   exists = Theme.find_by_title(details[:title])
   if !exists
     theme = Theme.new
     theme.title = details[:title]
     theme.locale = details[:locale]
     theme.description = details[:description]
     theme.save!
  end
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
  "Portage" => {
    title: "Portage Template",
    description: "This is the generic DMP template for Portage.",
    published: true,
    organisation: "Portage",
    locale: "en",
    is_default: true
  },

}

 templates.each do |t, details|
   exists = Dmptemplate.find_by_title(details[:title])
   if !exists
     template = Dmptemplate.new
     template.title = details[:title]
     template.description = details[:description]
     template.published = details[:published]
     template.locale = details[:locale]
     template.is_default = details[:is_default]
     template.organisation = Organisation.find_by_name(details[:organisation])
     template.save!
   end
 end

phases = {
  "Portage" => {
    title: "Portage Data Management Questions",
    number: 1,
    template: "Portage Template"
   }
}

 phases.each do |p, details|
  exists = Phase.find_by_title(details[:title])
  if !exists
    phase = Phase.new
    phase.title = details[:title]
    phase.number = details[:number]
    phase.dmptemplate = Dmptemplate.find_by_title(details[:template])
    phase.save!
  end
 end

versions = {
  "Portage" => {
    title: "Portage Version 1", 
    published: true,
    number: 1,
    phase: "Portage Data Management Questions"
  }
}

 versions.each do |v, details|
  exists = Version.find_by_title(details[:title])
  if !exists
    version = Version.new
    version.title = details[:title]
    version.number = details[:number]
    version.published = details[:published]
    version.phase = Phase.find_by_title(details[:phase])
    version.save!
  end
 end

sections = {
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
    description: "Most Canadian research funding agencies now have policies requiring research data to be shared upon publication of the research results or within a reasonable period of time. While data sharing contributes to the visibility and impact of research, it has to be balanced with the legitimate desire of researchers to maximise their research outputs before releasing their data. Equally important is the need to protect the privacy of respondents and to properly handle sensitive data."
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
   qs = Section.where(title: details[:title])
   exists = false
   if qs.count >= 1
     qs.each do |s|
       exists = true if s.organisation == details[:organisation]
     end
   end
   if !exists
     section = Section.new
     section.title = details[:title]
     section.number = details[:number]
     section.description = details[:description]
     section.version = Version.find_by_title(details[:version])
     section.organisation = Organisation.find_by_name(details[:organisation])
     section.save!
   end
 end
 
 

questions = {

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
  qs = Question.where(text: details[:text])
  exists = false
  if qs.count >= 1
    qs.each do |s|
      exists = true if s.section.to_s == details[:section] && s.section.organisation == details[:organisation]
    end
  end
      
  if !exists
    question = Question.new
    question.text = details[:text]
    question.number = details[:number]
    question.guidance = details[:guidance]
    question.section_id = (Section.find_by_sql "Select id from sections where title = '#{details[:section]}' and organisation_id = #{Organisation.find_by_name(details[:organisation]).id}").first.id
    question.question_format_id = QuestionFormat.find_by_title(details[:question_format]).id
    question.save!
  end
 end
 
questions_locales = {

  "Portage1-1" => {
    text: "Quels types de données allez-vous recueillir, créer, lier, acquérir ou enregistrer?", 
    section: "Data Collection",
    organisation: "Portage", 
    number: 1, 
    locale: "fr", 
    guidance: "<p>Exemples : données numériques, images, audio, vidéo, texte, données tabulaires, données de modélisation, données spatiales, données d'instrumentation</p>"
  }, 
  "Portage1-2" => {
    text: "Dans quels formats de fichier vos données seront-elles recueillies? Ces formats permettront-ils la réutilisation des données, le partage et l'accès à long terme aux données?",
    section: "Data Collection", 
    organisation: "Portage",
    number: 2, 
    locale: "fr",
    guidance: "<p>Les formats propriétaires nécessitant l'utilisation de logiciels ou de matériels spécialisés ne sont pas recommandés, mais peuvent être nécessaires pour certaines méthodes d'analyse ou de collecte des données. L'utilisation de formats de fichier ouverts ou de formats conformes aux normes de l'industrie (p. ex. les formats largement utilisés par une communauté donnée) est préférable dans la mesure du possible. </p>Pour en savoir plus sur les formats de fichier, consultez les sites suivants : <a href=\"http://researchdata.library.ubc.ca/plan/format-your-data/\" target=\"_blank\">UBC Library</a> ou <a href=\"http://data-archive.ac.uk/create-manage/format/formats\" target=\"_blank\">UK Data Archive</a>.</p>"
  }, 
  "Portage1-3" => {
    text: "Quelles conventions et procédures utiliserez-vous pour structurer et nommer vos fichiers et en contrôler les versions afin de vous aider, ainsi que les utilisateurs potentiels, à mieux comprendre la façon dont vos données sont organisées?", 
    organisation: "Portage", 
    section: "Data Collection", 
    number: 3,
    locale: "fr", 
    guidance: "<p>Il est important de garder la trace des multiples copies ou versions des fichiers, des différents fichiers conservés dans plus d'un format ou à divers emplacements et des renseignements qui font l'objet de renvois croisés entre les fichiers. Ce processus s'appelle « contrôle de versions ».  </p>Des structures de fichier logiques, des conventions d'appellation informatives et des indications claires des versions de fichier aident à mieux utiliser vos données pendant et après votre projet de recherche. Ces pratiques permettront à votre équipe de recherche et vous de vous assurer que vous utilisez toujours la version appropriée de vos données et de réduire la confusion concernant les copies enregistrées sur différents ordinateurs  ou médias. </p>Pour en savoir plus sur l'appellation des fichiers et le contrôle des versions, consultez les sites suivants : <a href=\"http://researchdata.library.ubc.ca/plan/organize-your-data/\" target=\"_blank\">UBC Library</a> ou <a href=\"http://data-archive.ac.uk/create-manage/format/versions\" target=\"_blank\">UK Data Archive</a>.</p>",
  },
  "Portage2-1" => {
    text: "Quels documents seront nécessaires pour que les données soient lues et interprétées correctement dans le futur?", 
    section: "Documentation and Metadata", 
    organisation: "Portage",
    number: 1,
    locale: "fr", 
    guidance: "<p>Normalement, une bonne documentation comprend des renseignements sur l'étude, des descriptions des éléments tels que les variables et d'autres renseignements contextuels requis pour que d'autres chercheurs puissent utiliser les données. Parmi les autres éléments à documenter, le cas échéant, mentionnons la méthodologie de recherche utilisée, les définitions des variables, les vocabulaires, les systèmes de classification, les unités de mesure, les hypothèses formulées, le type de format et de fichier des données, une description des données recueillies et des méthodes de collecte, l'explication de l'analyse et de la codification des données réalisées (y compris les fichiers de syntaxe) et les renseignements sur les personnes ayant travaillé au projet et réalisé chacune des tâches, etc. </p>"
  }, 
  "Portage2-2" => {
    text: "Comment vous assurerez-vous de documenter le projet de façon systématique tout au long du processus?",
    section: "Documentation and Metadata",
    organisation: "Portage",
    number: 2,
    locale: "fr",
    guidance: "<p>Examinez la façon dont vous saisirez ces renseignements et l'emplacement où ils seront enregistrés, idéalement avant de procéder à l'analyse et à la collecte de données, afin d'assurer l'exactitude, l'uniformité et l'exhaustivité des documents. Souvent, les ressources que vous avez déjà créées peuvent contribuer à cela (p. ex. publications, sites Web, rapports d'étape, etc.). Il est utile de consulter régulièrement les membres de l'équipe de recherche afin de connaître les changements possibles dans la collecte ou le traitement des données qui doivent être pris en considération dans les documents. La collecte des renseignements sur les données doit être une partie intégrante des responsabilités des membres de l'équipe et des opérations.</p>",
  },
  "Portage2-3" => {
    text: "Si vous utilisez une norme de métadonnées ou des outils pour documenter et décrire vos données, veuillez les indiquer ici.",
    section: "Documentation and Metadata",
    organisation: "Portage",
    number: 3,
    locale: "fr",
    guidance: "<p>Il existe plusieurs normes de métadonnées générales et propres à un domaine. Les informations sur l'ensemble de données doivent être fournies dans un de ces formats standards, ouverts et lisibles par machine afin de permettre l'échange efficace d'information entre les utilisateurs et les systèmes. Ces normes s'appuient souvent sur des formats de données comme XML, RDF et JSON qui ne sont pas liés à un langage de programmation. Il y a plusieurs normes de métadonnées fondées sur ces formats, y compris des normes propres à une discipline.</p> Pour en savoir plus sur les normes de métadonnées, consultez le site suivant :  <a href=\"http://dcc.ac.uk/resources/metadata-standards\" target=\"_blank\">UK Digital Curation Centre's Disciplinary Metadata</a>. </p>"
  },
  "Portage3-1" => {
    text: "Quelles sont les besoins de stockage anticipés pour votre projet en matière d'espace (en mégaoctets, gigaoctets, téraoctets, etc.) et de durée de stockage?",
    section: "Storage and Backup",
    organisation: "Portage",
    number: 1,
    locale: "fr",
    guidance: "<p>Les estimations concernant l'espace de stockage doivent prendre en considération les exigences pour le versionnage de fichiers, les sauvegardes et la croissance du nombre de fichiers au fil du temps. </p> Si vous recueillez des données sur une longue période (p. ex. plusieurs mois ou années), votre stratégie en matière de sauvegarde et de stockage des données doit tenir compte de la croissance des données. De même, un plan de stockage à long terme est nécessaire si vous avez l'intention de conserver vos données après le projet de recherche. </p>"
  },
  "Portage3-2" => {
    text: "Comment vos données seront-elles stockées et sauvegardées pendant votre projet de recherche et à quel endroit le seront-elles?",
    section: "Storage and Backup",
    organisation: "Portage",
    number: 2,
    locale: "fr",
    guidance: "<p>Le risque de perdre des données en raison d'une erreur humaine, de catastrophes naturelles ou d'autres mésaventures peut être atténué en respectant les <a href=\"http://dataabinitio.com/?p=501\" target=\"_blank\">3-2-1 règles de sauvegarde</a>:<br><ul><li>Posséder au moins trois copies de vos données.</li><li>Stocker les copies sur deux types de médias différents.</li><li>Conserver une copie de sauvegarde hors site</li></ul></p>Les données peuvent être stockées au moyen d'un média optique ou magnétique qui peut être amovible (p. ex. DVD et clés USB), fixe (p. ex. lecteurs de disque dur d'ordinateur de bureau ou d'ordinateur portatif) ou en réseau (p. ex. lecteurs en réseau ou serveurs basés sur l'infonuagique). Chaque méthode de stockage comporte des avantages et des inconvénients qui doivent être pris en considération au moment de déterminer la solution la plus appropriée. </p>De plus amples renseignements sur les pratiques de stockage et de sauvegarde sont disponibles sur les sites suivants : <a href=\"https://www.sheffield.ac.uk/library/rdm/storage\" target=\"_blank\">University of Sheffield Library</a> and the <a href=\"http://www.data-archive.ac.uk/create-manage/storage/back-up\" target=\"_blank\">UK Data Archive</a>.</p>",
  },
  "Portage3-3" => {
    text: "Comment l'équipe de recherche et d'autres collaborateurs pourront-ils accéder aux données, modifier celles-ci ou en contribuer de nouvelles tout au long du projet?",
    section: "Storage and Backup",
    organisation: "Portage", 
    number: 3,
    locale: "fr",
    guidance: "<p>Une solution idéale est une solution qui facilite la collaboration, assure la sécurité des données et qui peut être adoptée par les utilisateurs en suivant une formation minimale. La transmission de données entre les différents espaces de travail ou au sein d'équipes de recherche n'est pas toujours simple selon l'infrastructure de gestion des données. Se fier au courrier électronique pour le transfert de données n'est pas une solution robuste ou sécuritaire. Les services de partage de fichiers commerciaux de tiers (comme Google Drive et Dropbox) facilitent l'échange de fichiers, mais ne sont pas nécessairement permanents ou sécuritaires et sont souvent situés à l'extérieur du Canada. Communiquez avec votre bibliothèque pour mettre au point la meilleure solution pour votre projet de recherche.</p>"
  },
  "Portage4-1" => {
    text: "Où déposerez-vous vos données en vue de l'accès et de la préservation à long terme à la fin de votre projet de recherche?",
    section: "Preservation",
    organisation: "Portage",
    number: 1,
    locale: "fr",
    guidance: "<p>La question de la rétention des données doit être examinée tôt dans le cycle de vie de la recherche. Les décisions relatives à la rétention des données peuvent être dictées par des politiques externes (p. ex. organismes de financement, éditeurs de revues) ou par une compréhension de la valeur durable d'un ensemble de données déterminé. La nécessité de préserver les données à court terme (c.-à-d. à des fins de vérification par des pairs) ou à long terme (pour les données de valeur durable) influencera le choix de l'archive ou du dépôt de données. Une analogie utile consiste à penser à créer un « testament de vie » pour les données, c'est-à-dire un plan qui décrit la façon dont les futurs chercheurs continueront d'avoir accès aux données.</p>Si vous avez besoin d'aide pour trouver une archive ou un dépôt de données approprié, communiquez avec votre bibliothèque.</p> <a href=\"http://www.re3data.org/\" target=\"_blank\">re3data.org</a> est un répertoire de dépôts de données ouvertes. Vérifiez si le dépôt de données pourra vous fournir une confirmation que les termes du dépôt énoncés dans votre plan de gestion des données seront respectés.</p>"
  },
  "Portage4-2" => {
    text: "Indiquez comment vous vous assurerez que vos données sont prêtes pour la conservation. À prendre en considération: formats de fichier appropriés pour la conservation mais qui préservent l'intégrité des données;  anonymisation et dépersonnalisation des fichiers, y compris les fichiers de documentation. ",
    section: "Preservation",
    organisation: "Portage",
    number: 2,
    locale: "fr",
    guidance: "<p>Certains formats de données sont idéals pour la conservation à long terme des données. Par exemple, les formats de fichier non-propriétaires, comme le format texte (.txt) et les valeurs séparées par des virgules (.csv), sont considérés comme des formats conçus pour la conservation. Le UK Data Archive (dépôt de données du Royaume-Uni) fournit un tableau utile des formats de fichier pour divers types de données. Il faut se rappeler que les fichiers qui sont convertis d'un format à l'autre peuvent perdre des renseignements (p. ex. en convertissant un fichier TIFF non compressé à un fichier JPG compressé). Ainsi, les modifications apportées aux formats de fichier doivent être documentées. </p>Déterminez les étapes à suivre à la fin d'un projet pour s'assurer que les données que vous choisissez de préserver ou de partager sont anonymes, exemptes d'erreur et converties dans les formats recommandés en assurant un risque minimal de perte de données. </p> Pour en savoir plus sur l'anonymisation, consultez les sites suivants :<a href=\"http://researchdata.library.ubc.ca/plan/format-your-data/\" target=\"_blank\">UBC Library</a> ou <a href=\"http://data-archive.ac.uk/create-manage/consent-ethics/anonymisation\" target=\"_blank\">UK Data Archive</a>.</p>"
  },
  "Portage5-1" => {
    text: "Quelles données partagerez-vous et sous quelle forme? (p. ex. données brutes, traitées, analysées, définitives)",
    section: "Sharing and Reuse",
    organisation: "Portage",
    number: 1,
    locale: "fr",
    question_format: "Text area",
    guidance: "<p><b>Les données brutes</b> sont des données obtenues directement de l'instrument, de la simulation ou de l'enquête.</p><b>Les données traitées</b> découlent d'une certaine manipulation des données brutes afin d'éliminer les erreurs ou les valeurs aberrantes, de préparer les données en vue de l'analyse, d'obtenir de nouvelles variables ou d'anonymiser les participants humains. </p><b>Les données analysées</b> sont les résultats d'une analyse qualitative, statistique ou mathématique des données traitées.  Elles peuvent être présentées sous forme de graphiques, de diagrammes ou de tableaux statistiques.</p><b>Les données définitives</b> sont des données traitées qui ont été converties, au besoin, dans un format pouvant être préservé.</p>Examinez les données qui peuvent devoir être partagées afin de respecter les exigences institutionnelles ou de financement et les données qui peuvent faire l'objet de restrictions en raison de préoccupations relatives à la confidentialité, au respect de la vie privée et à la propriété intellectuelle.</p>",
  },
   "Portage5-2" => {
    text: "Avez-vous examiné quel type de licence d'utilisation inclure avec vos données?",
    section: "Sharing and Reuse",
    organisation: "Portage",
    number: 2,
    locale: "fr",
    guidance: "<p>Les licences déterminent les utilisations permises de vos données. Les organismes de financement et les dépôts de données peuvent avoir des exigences relatives à la licence d'utilisation. Si ce n'est pas le cas, ils peuvent vous guider dans l'établissement d'une licence. Une fois la licence créée, veuillez envisager d'inclure une copie de votre licence d'utilisation avec votre plan de gestion des données. Il convient de noter que seuls les titulaires des droits de propriété intellectuelle peuvent émettre une licence, il est dont essentiel de préciser à qui appartient ces droits.</p> Il existe plusieurs types de licences standards mises à la disposition des chercheurs comme  les <a href=\"http://creativecommons.org/choose/\" target=\"_blank\">licences Creative Commons</a> et les <a href=\"http://opendatacommons.org/licenses/\" target=\"_blank\">licences Open Data Commons</a>. En fait, pour la plupart des ensembles de données, il est plus facile d'utiliser une licence standard plutôt que de concevoir une licence personnalisée. Veuillez noter que même si vous choisissez de rendre vos données publiques, il est préférable de l'indiquer de manière explicite en utilisant une licence comme celle CC0 de Creative Commons. </p> Pour en savoir plus sur les licences d'exploitation des données, consultez le site suivant : <a href=\"http://www.dcc.ac.uk/resources/how-guides/license-research-data\" target=\"_blank\">UK Digital Curation Centre</a>. </p>"
  },
  "Portage5-3" => {
    text: "Quelles mesures seront prises pour faire connaître l'existence de vos données au milieu de la recherche?",
    section: "Sharing and Reuse",
    organisation: "Portage",
    number: 3,
    locale: "fr",
    guidance: "<p>Les possibilités comprennent : registres de données, dépôts, index, bouche-à-oreille, publications.</p><p>Comment pourra-t-on accéder aux données (service Web, ftp, etc.)? &nbsp;Dans la mesure du possible, choisissez un dépôt qui attribuera un identifiant constant (comme un DOI) à votre ensemble de données. Cela permettra ainsi d'assurer un accès stable à l'ensemble de données et il pourra être accessible grâce à divers outils de recherche.</p><p>Une des meilleures façons d'orienter d'autres chercheurs vers vos ensembles de données déposés consiste à les citer de la même façon que d'autres types de publications (articles, livres, procédures). Le Digital Curation Centre fournit un <a href=\"http://www.dcc.ac.uk/resources/how-guides/cite-datasets\" target=\"_blank\">guide</a> détaillé sur la citation des données. Veuillez noter que certains dépôts de données établissent également des liens entre les ensembles de données et les articles connexes, ce qui accroît ainsi la visibilité des publications.<p>Communiquez avec votre bibliothèque pour obtenir de l'aide pour donner de la visibilité à votre ensemble de données et le rendre facilement accessible.&nbsp;</p><p>Réutilisé des NIH. (2009). <a href=\"https://grants.nih.gov/grants/sharing_key_elements_data_sharing_plan.pdf\" target=\"_blank\">Key Elements to Consider in Preparing a Data Sharing Plan Under NIH Extramural Support (Principaux éléments à prendre en considération dans l'établissement d'un plan de partage des données en vertu du soutien extra-muros des NIH)</a>. National Institutes of Health.</p>"
  },
  "Portage6-1" => {
    text: "Identifiez qui sera responsable de la gestion des données de ce projet pendant et après le projet ainsi que les principales tâches associées à ces responsabilités.",
    section: "Responsibilities and Resources",
    organisation: "Portage",
    number: 1,
    locale: "fr",
    guidance: "<p>Votre plan de gestion des données a identifié les activités importantes relatives à la gestion des données dans le cadre de votre projet. Indiquez les responsables  -- des personnes ou des organisations -- de l'exécution de ces parties de votre plan de gestion des données. Cela pourrait également comprendre le calendrier associé à ces responsabilités et toute formation nécessaire afin de préparer le personnel à assumer ces fonctions. </p>"
  },
  "Portage6-2" => {
    text: "De quelle façon les responsabilités relatives à la gestion des données seront-elles gérées si des changements importants surviennent au sein du personnel qui supervise les données du projet, y compris un changement de chercheur principal?",
    section: "Responsibilities and Resources",
    organisation: "Portage",
    number: 2,
    locale: "fr",
    guidance: "<p>Indiquez une stratégie de planification de la relève pour ces données dans l'éventualité où une ou plusieurs personnes responsables des données quittent le projet (p. ex. un étudiant aux cycles supérieurs qui quitte après l'obtention de son diplôme). Décrivez le processus à suivre dans l'éventualité où le chercheur principal quitte le projet. Dans certains cas, un cochercheur, le département ou la division qui supervise cette recherche en assumera la responsabilité. </p>"
  },
  "Portage6-3" => {
    text: "De quelles ressources aurez-vous besoin pour mettre en œuvre votre plan de gestion des données? À combien évaluez-vous le coût total de la gestion des données?",
    section: "Responsibilities and Resources",
    organisation: "Portage",
    number: 3,
    locale: "fr",
    guidance: "<p>Cette évaluation doit comprendre les coûts de gestion des données encourus au cours du projet ainsi que les coûts requis pour le soutien à plus long terme des données après la fin du projet. Les points à considérer dans la dernière catégorie de dépenses comprennent les coûts d'entretien  et de prestation d'un accès à long terme aux données. Certains organismes de financement indiquent de façon explicite le soutien qu'ils fourniront afin de respecter les coûts relatifs à la préparation des données à déposer. Cela peut comprendre les aspects techniques de la gestion de données, les exigences en matière de formation, le stockage et la sauvegarde des fichiers et le travail du personnel ne faisant pas partie du projet.</p>"
  },
  "Portage7-1" => {
    text: "Si votre projet comprend des données sensibles, comment vous assurerez-vous qu'il est géré de manière sécuritaire et que les données sont accessibles uniquement aux membres approuvés du projet?",
    section: "Ethics and Legal Compliance",
    organisation: "Portage",
    number: 1,
    locale: "fr",
    guidance: "<p>Examinez où et comment les données sensibles ayant une valeur à long terme reconnue doivent être rendues disponibles et à qui, de même que pendant combien de temps elles doivent  être archivées. Ces décisions doivent respecter les exigences du comité d'éthique de la recherche. Les méthodes utilisées pour partager les données dépendront d'un certain nombre de facteurs comme le type, la taille, la complexité et le degré de sensibilité des données. Décrivez les problèmes prévus dans le partage des données, ainsi que les causes et les mesures possibles pour les atténuer. Les problèmes peuvent comprendre, entre autres, la confidentialité, l'absence de consentement ou les préoccupations au sujet des droits de propriété intellectuelle. Dans certains cas, une période d'embargo peut être justifiée; ces cas peuvent être définis dans la politique sur les données de recherche d'un organisme de financement.</p><p>Réutilisé de : DCC. (2013). <a href=\"http://www.dcc.ac.uk/resources/data-management-plans\" target=\"_blank\">Checklist for a Data Management Plan (Liste de vérification pour un plan de gestion des données)</a>. v.4.0. Edinburgh: Digital Curation Centre</p><p>Des restrictions peuvent être imposées en limitant l'accès physique aux dispositifs de stockage, en enregistrant les données sur des ordinateurs qui ne possèdent pas d'accès au réseau externe (c.-à-d. accès à Internet), grâce à une protection par mot de passe, et en codant les fichiers. Les données sensibles ne doivent jamais être partagées par courriel ou au moyen de services de stockage en nuage comme Dropbox.</p>"
  },
  "Portage7-2" => {
    text: "Le cas échéant, quelles stratégies adopterez-vous pour traiter les utilisations secondaires des données sensibles?",
    section: "Ethics and Legal Compliance",
    organisation: "Portage",
    number: 2,
    locale: "fr",
    guidance: "<p>L'obtention du consentement approprié des participants de recherche constitue une étape importante pour assurer au comité d'éthique de la recherche que les données de recherche peuvent être partagées avec des chercheurs ne faisant pas partie de votre projet. La déclaration de consentement peut indiquer certaines conditions précisant l'utilisation des données par d'autres chercheurs. Par exemple, elle peut stipuler que les données seront uniquement partagées à des fins de recherche sans but lucratif ou que les données ne seront pas croisées avec des données personnelles provenant d'autres sources. </p><p>Pour en savoir plus sur la sécurité des données, consultez le site suivant : <a href=\"http://data-archive.ac.uk/create-manage/storage/security\" target=\"_blank\">UK Data Archive</a></p>.</p>"
  },
  "Portage7-3" => {
    text: "Comment traiterez-vous les questions d'ordre juridique, éthique et de propriété intellectuelle?",
    section: "Ethics and Legal Compliance",
    organisation: "Portage",
    number: 3,
    locale: "fr",
    guidance: "<p>Le respect des règlements et des lois sur la protection de la vie privée qui peuvent imposer des restrictions de contenu dans les données devrait être discuté avec le bureau de la recherche ou le responsable de la protection de la vie privée de votre établissement. Le comité d'éthique de la recherche est aussi essentiel dans ce processus.</p><p>Décrivez ici ce qui en est de la propriété des données, de l'octroi de licences et de la propriété intellectuelle. Les conditions énoncées pour la réutilisation des données doivent être clairement mentionnés et respecter les exigences juridiques et éthiques pertinentes, le cas échéant (p. ex. consentement du sujet, permissions, restrictions, etc.).</p>"
  }
}

 questions_locales.each do |q, details|

  qs = Question::Translation.where(text: details[:text])
  exists = false
  if qs.count >= 1
    qs.each do |s|
      exists = true if Question.find(s.question_id).section == details[:section] && Question.find(s.question_id).section.organisation == details[:organisation]
    end
  end
   if !exists
     question = Question::Translation.new
     question.locale = details[:locale]
     question.question_id = Question.find_by_sql( "Select id from questions where section_id = #{(Section.find_by_sql "Select id from sections where title = '#{details[:section]}' and organisation_id = #{Organisation.find_by_name(details[:organisation]).id}").first.id} and number = #{details[:number]}").first.attributes['id']
     question.text = details[:text]
     question.guidance = details[:guidance]
     question.save!
   end
 end
 
 templates_locales = {
  "Portage" => {
    title: "Modèle Portage", 
    description: "Generic Portage Template in French",
    template_en: "Portage Template", 
    locale: "fr"
  }
}

 templates_locales.each do |t, details|
   exists = Dmptemplate::Translation.find_by_title(details[:title])
   if !exists
     template = Dmptemplate::Translation.new
     template.title = details[:title]
     template.description = details[:description]
     template.locale = details[:locale]
     template.dmptemplate_id = Dmptemplate.find_by_title(details[:template_en]).id
     template.save!
   end
 end

phases_locales = {
  "Portage" => {
    title: "Questions du modèle Portage",
    locale: "fr",
    number: 1,
    template: "Portage Template"
  }
}

phases_locales.each do |p, details|
   exists = Phase::Translation.find_by_title(details[:title])
   if !exists
     phase = Phase::Translation.new
     phase.title = details[:title]
     phase.phase_id = (Phase.find_by_sql "Select id from phases where dmptemplate_id = #{Dmptemplate.find_by_title(details[:template]).id} and number = #{details[:number]}").first.attributes["id"]
     phase.locale = details[:locale]
     phase.save!
   end
 end

versions_locales = {
  "Portage" => {
    title: "Portage, version 1",
    number: 1,
    phase: "Portage Data Management Questions",
    locale: "fr",
  }
}

 versions_locales.each do |v, details|
   exists = Version::Translation.find_by_title(details[:title])
   if !exists
     version = Version::Translation.new
     version.title = details[:title]
     version.version_id = (Version.find_by_sql "Select id from versions where phase_id = #{Phase.find_by_title(details[:phase]).id} and number = #{details[:number]}").first.attributes["id"]
     version.locale = details[:locale]
     version.save!
   end
 end

sections_locales = {
  "Data Collection" => {
    title: "Collecte de données", 
    number: 1,
    description: "Cette section traite des questions relatives à la collecte de données comme les types de données, les formats de fichier, les conventions d'appellation et l'organisation des données – des facteurs qui amélioreront la facilité d'utilisation de vos données et contribueront au succès de votre projet.", 
    version: "Portage Version 1", 
    locale: "fr",
  },
  "Documentation and Metadata" => {
    title: "Documentation et métadonnées",
    number: 2,
    description: "Les données sont rarement explicites, c'est pourquoi toutes les données de recherche doivent être accompagnées de métadonnées (des renseignements qui décrivent les données selon les meilleures pratiques de la communauté). Les normes de métadonnées varient d'une discipline à l'autre, mais elles indiquent généralement la personne qui a créé les données, quand et comment elles ont été créées, leur qualité, exactitude et précision ainsi que d'autres caractéristiques nécessaires pour faciliter la découverte, la compréhension et la réutilisation des données. </br>Toute restriction concernant l'utilisation des données doit être expliquée dans les métadonnées et, dans la mesure du possible, des renseignements doivent être fournis sur la façon d'obtenir un accès approuvé aux données.",
    version: "Portage Version 1", 
    locale: "fr",
  }, 
  "Storage and Backup" => {
    title: "Stockage et sauvegarde", 
    number: 3, 
    version: "Portage Version 1", 
    description: "Il est essentiel de planifier la façon dont les données de recherche seront stockées et sauvegardées tout au long d'un projet de recherche et au-delà afin d'assurer la sécurité et l'intégrité des données. Le stockage et la sauvegarde appropriés aident non seulement à protéger les données de recherche contre des pertes catastrophiques (en raison de défaillances du logiciel et du matériel, de virus, de pirates informatiques, de catastrophes naturelles, d'erreurs humaines, etc.), mais y facilitent également l'accès approprié par les chercheurs actuels et futurs.",
    locale: "fr",
  }, 
  "Preservation" => {
    title: "Conservation", 
    number: 4, 
    description: "La conservation des données dépendra de la valeur de réutilisation potentielle, s'il faut conserver ou détruire les données, et des ressources requises pour organiser de façon appropriée les données et s'assurer qu'elles demeurent utilisables dans le futur. Dans certains cas, il peut être souhaitable de conserver toutes les versions des données (p. ex. les données brutes, traitées, analysées, définitives), mais dans d'autres cas, il peut être préférable de conserver uniquement les données sélectionnées ou définitives (p. ex. transcriptions au lieu d'entrevues sonores).",
    version: "Portage Version 1", 
    locale: "fr",
  }, 
  "Sharing and Reuse" => {
    title: "Partage et réutilisation", 
    number: 5,
    description: "Plusieurs organismes subventionnaires canadiens ont maintenant des politiques exigeant que les données de recherche soient rendues accessibles au moment de la publication des résultats de la recherche ou à l'intérieur d'un délai raisonnable. Si le partage des données contribue à la visibilité et à l'impact de la recherche, il faut aussi tenir compte du souhait des chercheurs de publier un maximum de publications avant de diffuser les données. Également d'importance est le besoin de protéger la vie privée des répondants et de traiter de façon appropriée les données sensibles. ",
    version: "Portage Version 1", 
    locale: "fr",
  }, 
  "Responsibilities and Resources" => {
    title: "Responsabilités et ressources", 
    number: 6,
    description: "La notion de gestion des données fait référence au « quoi » et au « comment » des opérations de gestion liées aux données tout au long du cycle de vie du projet. La notion de gérance des données met de son côté l'accent sur « qui » est responsable de s'assurer que cette gestion des données est faite. Un gros projet de recherche aura par exemple plusieurs personnes responsables.  Le chercheur principal doit déterminer au début du projet quelles personnes dans l'équipe auront des responsabilités en matière de gestion des données pendant et après le projet.", 
    version: "Portage Version 1", 
    locale: "fr",
  }, 
  "Ethics and Legal Compliance" => {
    title: "Conformité aux lois et à l'éthique",
    description: "Les chercheurs et leurs équipes doivent connaître les politiques et les processus, éthiques et juridiques, auxquels leur gestion des données de recherche doit se conformer. La protection de la vie privée du répondant revêt une importance capitale et façonne plusieurs pratiques en matière de gestion des données. Dans leur plan de gestion des données, les chercheurs doivent indiquer la façon dont ils prépareront, stockeront, partageront et archiveront les données de façon à s'assurer que les renseignements sur les participants sont protégés tout au long du cycle de vie de la recherche contre la divulgation, l'utilisation préjudiciable ou les liens inappropriés avec d'autres données personnelles.</br>On reconnait qu'il peut y avoir des cas où certaines données et métadonnées ne peuvent pas être rendues publiques en raison de politiques ou de considérations légales. Toutefois, la position par défaut doit être que toutes les données et métadonnées de recherche sont publiques.", 
    number: 7, 
    version: "Portage Version 1", 
    locale: "fr",
  } 
}

 sections_locales.each do |s, details|
   s = Section::Translation.find_by_title(details[:title])
   exists = s && Section.find(s.section_id).organisation.name == details[:organisation]
   if !exists
     section = Section::Translation.new
     section.title = details[:title]
     section.section_id = (Section.find_by_sql "Select id from sections where version_id = #{Version.find_by_title(details[:version]).id} and number = #{details[:number]}").first.attributes["id"]
     section.locale = details[:locale]
     section.description = details[:description]
     section.save!
   end
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
   exists = QuestionFormat::Translation.find_by_title(details[:title])
   if !exists
     question_format = QuestionFormat::Translation.new
     question_format.title = details[:title]
     question_format.question_format_id = QuestionFormat.find_by_title(details[:title_en]).id
     question_format.locale = details[:locale]
     question_format.save!
   end
 end
