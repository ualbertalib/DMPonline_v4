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

guidance_groups = {
  "DCC Guidance" => {
    name: "DCC Guidance",
    organisation: "DCC",
    optional_subset: false
  }
}

guidance_groups.each do |gg, details|
  guidance_group = GuidanceGroup.new
  guidance_group.name = details[:name]
  guidance_group.organisation = Organisation.find_by_abbreviation(details[:organisation])
  guidance_group.optional_subset = details[:optional_subset]
  guidance_group.save!
end

guidances = {
  "DCC_1" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Are any restrictions on data sharing required? e.g. limits on who can use the data, when and for what purpose.</li> <li>What restrictions are needed and why?</li> <li>What action will you take to overcome or minimise restrictions?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Outline any expected difficulties in data sharing, along with causes and possible measures to overcome these. Restrictions to data sharing may be due to participant confidentiality, consent agreements or IPR. Strategies to limit restrictions may include: anonymising or aggregating data; gaining participant consent for data sharing; gaining copyright permissions; and agreeing a limited embargo period. </p>",
    guidance_group: "DCC Guidance",
    themes: ["Restrictions on Sharing"]
  },
  "DCC_2" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Are there any existing data or methods that you can reuse?</li><li>Do you need to pay to reuse existing data?</li><li>Are there any restrictions on the reuse of third-party data?</li><li>Can the data that you create - which may be derived from third-party data - be shared?</li> </ul> <p class='guidance_header'>Guidance: </p> <p>Check to see if there are any existing data that you can reuse, for examples by consulting relevant repositories. When creating new data sources, explain why existing data sources cannot be reused. If purchasing or reusing existing data sources, explain how issues such as copyright and IPR have been addressed. A list of repositories is provided by <a target='_blank' href='http://databib.org'>Databib</a> or <a target='_blank' href='http://www.re3data.org'>Re3data</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Existing Data"]
  },
  "DCC_3" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Are there any existing procedures that you will base your approach on?</li> <li>Does your department/group have data management guidelines?</li> <li>Does your institution have a data protection or security policy that you will follow?</li> <li>Does your institution have a Research Data Management (RDM) policy?</li> <li>Does your funder have a Research Data Management policy?</li> <li>Are there any formal standards that you will adopt?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>List any other relevant funder, institutional, departmental or group policies on data management, data sharing and data security. Some of the information you give in the remainder of the DMP will be determined by the content of other policies. If so, point/link to them here.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Related Policies"]
  },
  "DCC_4" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Do you have sufficient storage?</li> <li>Do you need to include costs for additional managed storage?</li> <li>Will the scale of the data pose challenges when sharing or transferring data between sites?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Consider the implications of data volumes in terms of storage, backup and access. Estimate the volume of data in MB/GB/TB and how this will grow to make sure any additional storage and technical support required can be provided.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Volumes"]
  },
  "DCC_5" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Have you gained consent for data preservation and sharing?</li> <li>How will sensitive data be handled to ensure it is stored and transferred securely?</li> <li>How will you protect the identity of participants? e.g. via anonymisation or using managed access procedures</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Investigators carrying out research involving human participants must ensure that consent is obtained to share data. Managing ethical concerns may include: anonymisation of data; referral to departmental or institutional ethics committees; and formal consent agreements. Ethical issues may affect how you store data, who can see/use it and how long it is kept. You should show that you&#8217;re aware of this and have planned accordingly.</p> <p>See UKDS guidance on <a target='_blank' href='http://ukdataservice.ac.uk/manage-data/legal-ethical/consent-data-sharing.aspx'>consent for data sharing</a></p>",
    guidance_group: "DCC Guidance",
    themes: ["Ethical Issues"]
  },
  "DCC_6" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>How long will the data be retained and preserved?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>This may depend on the type of data. Most research funders expect data to be retained for a minimum of 10 years from the end of the project. For data that by their nature cannot be re-measured, efforts should be made to retain them indefinitely.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Period of Preservation"]
  },
  "DCC_7" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>How will potential users find out about your data?</li> <li>Will you provide metadata online to aid discovery and reuse?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Indicate how potential new users can find out about your data and identify whether they could be suitable for their research purposes. For example, you may provide basic discovery metadata online (i.e. the title, author, subjects, keywords and publisher).</p>",
    guidance_group: "DCC Guidance",
    themes: ["Discovery by Users"]
  },
  "DCC_8" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>How will the data be created?</li> <li>What standards or methodologies will you use?</li><li>How will you structure and name your folders and files?</li><li>How will you ensure that different versions of a dataset are easily identifiable?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Outline how the data will be collected/generated and which community data standards (if any) will be used at this stage. Indicate how the data will be organised during the project, mentioning for example naming conventions, version control and folder structures. Consistent, well-ordered research data will be easier for the research team to find, understand and reuse.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Capture Methods"]
  },
  "DCC_9" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>How will you control data capture to ensure data quality?</li> <li>What quality assurance processes will you adopt?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Explain how the consistency and quality of data collection will be controlled and documented. This may include processes such as calibration, repeat samples or measurements, standardised data capture or recording, data entry validation, peer review of data or representation with controlled vocabularies.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Quality"]
  },
  "DCC_10" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>How will you make the data available to others?</li> <li>With whom will you share the data, and under what conditions?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Consider where, how, and to whom the data should be made available. Will you share data via a data repository, handle data requests directly or use another mechanism? </p> <p>The methods used to share data will be dependent on a number of factors such as the type, size, complexity and sensitivity of data. Mention earlier examples to show a track record of effective data sharing.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Method For Data Sharing"]
  },
  "DCC_11" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What are the risks to data security and how will these be managed?</li> <li>Will you follow any formal standards?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>If your data is sensitive (e.g. detailed personal data, politically sensitive information or trade secrets) you should discuss any appropriate security measures that you will be taking. Note the main risks and how these will be managed. Identify any formal standards that you will comply with e.g. ISO 27001.</p> <p>See DCC Briefing Paper on <a target='_blank' href='http://www.dcc.ac.uk/resources/briefing-papers/standards-watch-papers/information-security-management-iso-27000-iso-27k-s'>Information Security Management - ISO 27000</a>.</p> <p>See UKDS guidance on <a target='_blank' href='http://ukdataservice.ac.uk/manage-data/store/security.aspx'>data security</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Security"]
  },
  "DCC_12" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What data will you create?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Give a brief description of the data that will be created, noting its content and coverage</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Description"]
  },
  "DCC_13" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What format will your data be in?</li> <li>Why have you chosen to use particular formats?</li> <li>Do the chosen formats and software enable sharing and long-term validity of data?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Outline and justify your choice of format e.g. SPSS, Open Document Format, tab-delimited format, MS Excel. Decisions may be based on staff expertise, a preference for open formats, the standards accepted by data centres or widespread usage within a given community. Using standardised and interchangeable or open lossless data formats ensures the long-term usability of data.</p> <p>See UKDS Guidance on <a target='_blank' href='http://ukdataservice.ac.uk/manage-data/format/recommended-formats.aspx'>recommended formats</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Format"]
  },
  "DCC_14" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What is the long-term preservation plan for the dataset? e.g. deposit in a data repository</li> <li>Will additional resources be needed to prepare data for deposit or meet charges from data repositories?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Researchers should consider how datasets that have long-term value will be preserved and curated beyond the lifetime of the grant. Also outline the plans for preparing and documenting data for sharing and archiving.</p> <p>If you do not propose to use an established repository, the data management plan should demonstrate that resources and systems will be in place to enable the data to be curated effectively beyond the lifetime of the grant.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Preservation Plan"]
  },
  "DCC_15" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What is the relationship to existing data e.g. in public repositories?</li> <li>How does your data complement and integrate with existing data?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Consider the relationship between the data that you will capture and existing data available in public repositories or elsewhere.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Relationship to Existing Data"]
  },
  "DCC_16" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What metadata, documentation or other supporting material should accompany the data for it to be interpreted correctly?</li> <li>What information needs to be retained to enable the data to be read and interpreted in the future?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Describe the types of documentation that will accompany the data to provide secondary users with any necessary details to prevent misuse, misinterpretation or confusion. This may include information on the methodology used to collect the data, analytical and procedural information, definitions of variables, units of measurement, any assumptions made, the format and file type of the data.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Documentation"]
  },
  "DCC_17" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What types of data will you create?</li> <li>Which types of data will have long-term value?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Outline the types of data that are expected to be produced from the project e.g. quantitative, qualitative, survey data, experimental measurements, models, images, audiovisual data, samples etc. Include the raw data arising directly from the research, the reduced data derived from it, and published data.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Type"]
  },
  "DCC_18" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>When will you make the data available?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Data (with accompanying metadata) should be shared in a timely fashion. It is generally expected that timely release would be no later than publication of the main findings and should be in-line with established best practice in the field. Researchers have a legitimate interest in benefiting from their investment of time and effort in producing data, but not in prolonged exclusive use.  Research funders typically allow embargoes in line with practice in the field, but expect these to be outlined up-front and justified.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Timeframe For Data Sharing"]
  },
  "DCC_19" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Where (i.e. in which repository) will the data be deposited?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Most research funders recommend the use of established data repositories, community databases and related initiatives to aid data preservation, sharing and reuse.</p> <p>An international list of data repositories is available via <a target='_blank' href='http://databib.org'>Databib</a> or <a target='_blank' href='http://www.re3data.org'>Re3data</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Repository"]
  },
  "DCC_20" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Which data are of long-term value and should be shared and/or preserved?</li> <li>How will you decide what to keep?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Indicate which data you intend to preserve beyond the period of funding. This should be based on what has long-term value and is economically viable to keep. Consider how long you wish to keep the data and what will happen to it e.g. deposit in a data repository to enable reuse.</p> <p>See the DCC guide: <a target='_blank' href='http://www.dcc.ac.uk/resources/how-guides/appraise-select-data'>How to appraise and select research data for curation</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Selection"]
  },
  "DCC_21" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Who is responsible for each data management activity?</li> <li>How are responsibilities split across partner sites in collaborative research projects?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Outline the roles and responsibilities for all activities e.g. data capture, metadata production, data quality, storage and backup, data archiving &amp; data sharing. Individuals should be named where possible. For collaborative projects you should explain the co-ordination of data management responsibilities across partners.</p> <p>See UKDS guidance on data management <a target='_blank' href='http://ukdataservice.ac.uk/manage-data/plan/roles-and-responsibilities.aspx'>roles and responsibilities</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Responsibilities"]
  },
  "DCC_22" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Who may be interested in using your data?</li><li>What are the further intended or foreseeable research uses for the data?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>You should think about the possibilities for reuse of your data in other contexts and by other users, and connect this as appropriate with your plans for dissemination and Pathways to Impact. Where there is potential for reuse, you should use standards and formats that facilitate this. Where possible outline the types of users you expect and estimate numbers.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Expected Reuse"]
  },
  "DCC_23" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Who owns the data?</li> <li>How will the data be licensed for reuse?</li><li>If you are using third-party data, how do the permissions you have been granted affect licensing?</li> <li>Will data sharing be postponed / restricted e.g. to seek patents?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>State who will own the copyright and IPR of any new data that you will generate. For multi-partner projects, IPR ownership may be worth covering in a consortium agreement. If purchasing or reusing existing data sources, consider how the permissions granted to you affect licensing decisions. Outline any restrictions needed on data sharing e.g. to protect proprietary or patentable data.</p> <p>See the DCC guide: <a target='_blank' href='http://www.dcc.ac.uk/resources/how-guides/license-research-data'>How to license research data</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["IPR Ownership and Licencing"]
  },
  "DCC_24" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Will access be tightly controlled or restricted? e.g. by using data enclaves / secure data services</li> <li>Will a data sharing agreement be required?</li> <li>How will the data be licensed for reuse?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Indicate whether external users will be bound by data sharing agreements, licenses or end-user agreements. If so, set out the terms and key responsibilities to be followed. Note how access will be controlled, for example by the use of specialist services. A data enclave provides a controlled secure environment in which eligible researchers can perform analyses using restricted data resources. Where a managed access process is required, the procedure should be clearly described and transparent.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Managed Access Procedures"]
  },
  "DCC_25" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul><li>How will you capture / create the metadata?</li><li>Can any of this information be created automatically?</li><li>What metadata standards will you use and why?</li></ul> <p class='guidance_header'>Guidance:</p> <p>Metadata should be created to describe the data and aid discovery. Consider how you will capture this information and where it will be recorded e.g. in a database with links to each item, in a ‘readme’ text file, in file headers etc.</p><p>Researchers are strongly encouraged to use community standards to describe and structure data, where these are in place. The DCC offers a <a target='_blank' href='http://www.dcc.ac.uk/resources/metadata-standards'>catalogue of disciplinary metadata standards</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Metadata"]
  },
  "DCC_26" => {
    text: "<p class='guidance_header'>Questions to consider:</p><ul><li>What additional resources are needed to deliver your plan?</li> <li>Is additional specialist expertise (or training for existing staff) required?</li><li>Do you have sufficient storage and equipment or do you need to cost in more?</li><li>Will charges be applied by data repositories?</li><li>Have you costed in time and effort to prepare the data for sharing / preservation?</li></ul><p class='guidance_header'>Guidance:</p> <p>Carefully consider any resources needed to deliver the plan. Where dedicated resources are needed, these should be outlined and justified. Outline any relevant technical expertise, support and training that is likely to be required and how it will be acquired. Provide details and justification for any hardware or software which will be purchased or additional storage and backup costs that may be charged by IT services. </p><p>Funding should be included to cover any charges applied by data repositories, for example to handle data of exceptional size or complexity. Also remember to cost in time and effort to prepare data for deposit and ensure it is adequately documented to enable reuse. If you are not depositing in a data repository, ensure you have appropriate resources and systems in place to share and preserve the data.</p> <p>See UKDS guidance on <a target='_blank' href='http://ukdataservice.ac.uk/manage-data/plan/costing.aspx'>costing data management</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Resourcing"]
  },
  "DCC_27" => {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul><li>Where will the data be stored?</li> <li>How will the data be backed up? i.e. how often, to where, how many copies, is this automated&#8230;</li> <li>Who will be responsible for storage and backup?</li> <li>Do you have access to enough storage or will you need to include charges for additional services?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Describe how the data will be stored and backed-up to ensure the data and metadata are securely stored during the lifetime of the project. Storing data on laptops, computer hard drives or external storage devices alone is very risky. The use of robust, managed storage with automatic backup, for example that provided by university IT teams, is preferable.</p> <p>See UKDA guidance on <a target='_blank' href='http://data-archive.ac.uk/create-manage/storage.aspx'>data storage and backup</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Storage and Backup"]
  }
}

guidances.each do |g, details|
  guidance = Guidance.new
  guidance.text = details[:text]
  guidance.guidance_groups << GuidanceGroup.find_by_name(details[:guidance_group])
  details[:themes].each do |theme|
    guidance.themes << Theme.find_by_title(theme)
  end
  guidance.save!
end

templates = {
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

phases = {
  "DCC" => {
    title: "DCC Template",
    number: 1,
    template: "DCC Template"
  },
  "AHRC" => {
    title: "AHRC Template",
    number: 1,
    template: "AHRC Template"
  },
}

phases.each do |p, details|
  phase = Phase.new
  phase.title = details[:title]
  phase.number = details[:number]
  phase.dmptemplate = Dmptemplate.find_by_title(details[:template])
  phase.save!
end

versions = {
  "DCC" => {
    title: "DCC Template Version 1",
    number: 1,
    phase: "DCC Template"
  },
  "AHRC" => {
    title: "AHRC Template Version 1",
    number: 1,
    phase: "AHRC Template"
  },
}

versions.each do |v, details|
  version = Version.new
  version.title = details[:title]
  version.number = details[:number]
  version.phase = Phase.find_by_title(details[:phase])
  version.save!
end

sections = {
  "Data Collection" => {
    title: "Data Collection",
    number: 1,
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    version: "DCC Template Version 1",
    organisation: "DCC"
  },
  "Documentation and Metadata" => {
    title: "Documentation and Metadata",
    number: 2,
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    version: "DCC Template Version 1",
    organisation: "DCC"
  },
  "Ethics and Legal Compliance" => {
    title: "Ethics and Legal Compliance",
    number: 3,
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    version: "DCC Template Version 1",
    organisation: "DCC"
  },
  "Storage and Backup" => {
    title: "Storage and Backup",
    number: 4,
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    version: "DCC Template Version 1",
    organisation: "DCC"
  },
  "Selection and Preservation" => {
    title: "Selection and Preservation",
    number: 5,
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    version: "DCC Template Version 1",
    organisation: "DCC"
  },
  "Data Sharing" => {
    title: "Data Sharing",
    number: 6,
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    version: "DCC Template Version 1",
    organisation: "DCC"
  },
  "Responsibilities and Resources" => {
    title: "Responsibilities and Resources",
    number: 7,
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    version: "DCC Template Version 1",
    organisation: "DCC"
  }
}

sections.each do |s, details|
  section = Section.new
  section.title = details[:title]
  section.number = details[:number]
  section.description = details[:description]
  section.version = Version.find_by_title(details[:version])
  section.organisation = Organisation.find_by_abbreviation(details[:organisation])
  section.save!
end

questions = {
  "What data will you collect or create?" => {
    text: "What data will you collect or create?",
    section: "Data Collection",
    number: 1,
    guidance: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What type, format and volume of data?</li> <li>Do your chosen formats and software enable sharing and long-term access to the data?</li> <li>Are there any existing data that you can reuse?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Give a brief description of the data, including any existing data or third-party sources that will be used, in each case noting its content, type and coverage. Outline and justify your choice of format and consider the implications of data format and data volumes in terms of storage, backup and access.</p>",
    themes: ["Existing Data", "Data Volumes", "Data Type", "Data Format"],
    format: "Text area"
  },
  "How will the data be collected or created?" => {
    text: "How will the data be collected or created?",
    section: "Data Collection",
    number: 2,
    guidance: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What standards or methodologies will you use?</li> <li>How will you structure and name your folders and files?</li> <li>How will you handle versioning?</li> <li>What quality assurance processes will you adopt?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Outline how the data will be collected/created and which community data standards (if any) will be used. Consider how the data will be organised during the project, mentioning for example naming conventions, version control and folder structures. Explain how the consistency and quality of data collection will be controlled and documented. This may include processes such as calibration, repeat samples or measurements, standardised data capture or recording, data entry validation, peer review of data or representation with controlled vocabularies.</p>",
    themes: ["Data Capture Methods", "Data Quality"],
    format: "Text field"
  },
  "What documentation and metadata will accompany the data?" => {
    text: "What documentation and metadata will accompany the data?",
    section: "Documentation and Metadata",
    number: 1,
    guidance: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What information is needed for the data to be to be read and interpreted in the future?</li> <li>How will you capture / create this documentation and metadata?</li> <li>What metadata standards will you use and why?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Describe the types of documentation that will accompany the data to help secondary users to understand and reuse it. This should at least include basic details that will help people to find the data, including who created or contributed to the data, its title, date of creation and under what conditions it can be accessed.</p> <p>Documentation may also include details on the methodology used, analytical and procedural information, definitions of variables, vocabularies, units of measurement, any assumptions made, and the format and file type of the data. Consider how you will capture this information and where it will be recorded. Wherever possible you should identify and use existing community standards.</p>",
    themes: ["Documentation", "Metadata"],
    format: "Text area"
  },
  "How will you manage any ethical issues?" => {
    text: "How will you manage any ethical issues?",
    section: "Ethics and Legal Compliance",
    number: 1,
    guidance: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Have you gained consent for data preservation and sharing?</li> <li>How will you protect the identity of participants if required? e.g. via anonymisation</li> <li>How will sensitive data be handled to ensure it is stored and transferred securely?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Ethical issues affect how you store data, who can see/use it and how long it is kept. Managing ethical concerns may include: anonymisation of data; referral to departmental or institutional ethics committees; and formal consent agreements. You should show that you are aware of any issues and have planned accordingly. If you are carrying out research involving human participants, you must also ensure that consent is requested to allow data to be shared and reused.</p>",
    themes: ["Ethical Issues"],
    format: "Text area"
  },
  "How will you manage copyright and Intellectual Property Rights (IPR) issues?" => {
    text: "How will you manage copyright and Intellectual Property Rights (IPR) issues?",
    section: "Ethics and Legal Compliance",
    number: 2,
    guidance: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Who owns the data?</li> <li>How will the data be licensed for reuse?</li> <li>Are there any restrictions on the reuse of third-party data?</li> <li>Will data sharing be postponed / restricted e.g. to publish or seek patents?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>State who will own the copyright and IPR of any data that you will collect or create, along with the licence(s) for its use and reuse. For multi-partner projects, IPR ownership may be worth covering in a consortium agreement. Consider any relevant funder, institutional, departmental or group policies on copyright or IPR. Also consider permissions to reuse third-party data and any restrictions needed on data sharing.</p>",
    themes: ["IPR Ownership and Licencing"],
    format: "Text area"
  },
  "How will the data be stored and backed up during the research?" => {
    text: "How will the data be stored and backed up during the research?",
    section: "Storage and Backup",
    number: 1,
    guidance: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Do you have sufficient storage or will you need to include charges for additional services?</li> <li>How will the data be backed up?</li> <li>Who will be responsible for backup and recovery?</li> <li>How will the data be recovered in the event of an incident?</li> </ul> <p class='guidance_header'>Guidance: </p> <p>State how often the data will be backed up and to which locations. How many copies are being made? Storing data on laptops, computer hard drives or external storage devices alone is very risky. The use of robust, managed storage provided by university IT teams is preferable. Similarly, it is normally better to use automatic backup services provided by IT Services than rely on manual processes. If you choose to use a third-party service, you should ensure that this does not conflict with any funder, institutional, departmental or group policies, for example in terms of the legal jurisdiction in which data are held or the protection of sensitive data.</p>",
    themes: ["Storage and Backup"],
    format: "Text area"
  },
  "How will you manage access and security?" => {
    text: "How will you manage access and security?",
    section: "Storage and Backup",
    number: 2,
    guidance: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What are the risks to data security and how will these be managed?</li> <li>How will you control access to keep the data secure?</li> <li>How will you ensure that collaborators can access your data securely?</li> <li>If creating or collecting data in the field how will you ensure its safe transfer into your main secured systems?</li> </ul> <p class='guidance_header'>Guidance: </p> <p>If your data is confidential (e.g. personal data not already in the public domain, confidential information or trade secrets), you should outline any appropriate security measures and note any formal standards that you will comply with e.g. ISO 27001.&quot;</p>",
    themes: ["Data Security"],
    format: "Text area"
  },
  "Which data are of long-term value and should be retained, shared, and/or preserved?" => {
    text: "Which data are of long-term value and should be retained, shared, and/or preserved?",
    section: "Selection and Preservation",
    number: 1,
    guidance: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What data must be retained/destroyed for contractual, legal, or regulatory purposes?</li> <li>How will you decide what other data to keep?</li> <li>What are the foreseeable research uses for the data?</li> <li>How long will the data be retained and preserved?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Consider how the data may be reused e.g. to validate your research findings, conduct new studies, or for teaching. Decide which data to keep and for how long. This could be based on any obligations to retain certain data, the potential reuse value, what is economically viable to keep, and any additional effort required to prepare the data for data sharing and preservation. Remember to consider any additional effort required to prepare the data for sharing and preservation, such as changing file formats.</p>",
    themes: ["Data Selection"],
    format: "Text area"
  },
  "What is the long-term preservation plan for the dataset?" => {
    text: "What is the long-term preservation plan for the dataset?",
    section: "Selection and Preservation",
    number: 2,
    guidance: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Where e.g. in which repository or archive will the data be held?</li> <li>What costs if any will your selected data repository or archive charge?</li> <li>Have you costed in time and effort to prepare the data for sharing / preservation?</li> </ul> <p class='guidance_header'>Guidance: </p> <p>Consider how datasets that have long-term value will be preserved and curated beyond the lifetime of the grant. Also outline the plans for preparing and documenting data for sharing and archiving. If you do not propose to use an established repository, the data management plan should demonstrate that resources and systems will be in place to enable the data to be curated effectively beyond the lifetime of the grant.</p>",
    themes: ["Preservation Plan", "Data Repository"],
    format: "Text area"
  },
  "How will you share the data?" => {
    text: "How will you share the data?",
    section: "Data Sharing",
    number: 1,
    guidance: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>How will potential users find out about your data?</li> <li>With whom will you share the data, and under what conditions?</li> <li>Will you share data via a repository, handle requests directly or use another mechanism?</li> <li>When will you make the data available?</li> <li>Will you pursue getting a persistent identifier for your data?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Consider where, how, and to whom data with acknowledged long-term value should be made available. The methods used to share data will be dependent on a number of factors such as the type, size, complexity and sensitivity of data. If possible, mention earlier examples to show a track record of effective data sharing. Consider how people might acknowledge the reuse of your data.</p>",
    themes: ["Method For Data Sharing"],
    format: "Text area"
  },
  "Are any restrictions on data sharing required?" => {
    text: "Are any restrictions on data sharing required?",
    section: "Data Sharing",
    number: 2,
    guidance: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What action will you take to overcome or minimise restrictions?</li> <li>For how long do you need exclusive use of the data and why?</li> <li>Will a data sharing agreement (or equivalent) be required?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Outline any expected difficulties in sharing data with acknowledged long-term value, along with causes and possible measures to overcome these. Restrictions may be due to confidentiality, lack of consent agreements or IPR, for example. Consider whether a non-disclosure agreement would give sufficient protection for confidential data.</p>",
    themes: ["Restrictions on Sharing"],
    format: "Text area"
  },
  "Who will be responsible for data management?" => {
    text: "Who will be responsible for data management?",
    section: "Responsibilities and Resources",
    number: 1,
    guidance: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Who is responsible for implementing the DMP, and ensuring it is reviewed and revised?</li> <li>Who will be responsible for each data management activity?</li> <li>How will responsibilities be split across partner sites in collaborative research projects?</li> <li>Will data ownership and responsibilities for RDM be part of any consortium agreement or contract agreed between partners?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Outline the roles and responsibilities for all activities e.g. data capture, metadata production, data quality, storage and backup, data archiving &amp; data sharing. Consider who will be responsible for ensuring relevant policies will be respected. Individuals should be named where possible.</p>",
    themes: ["Responsibilities"],
    format: "Text area"
  },
  "What resources will you require to deliver your plan?" => {
    text: "What resources will you require to deliver your plan?",
    section: "Responsibilities and Resources",
    number: 2,
    guidance: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Is additional specialist expertise (or training for existing staff) required?</li> <li>Do you require hardware or software which is additional or exceptional to existing institutional provision?</li> <li>Will charges be applied by data repositories?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Carefully consider any resources needed to deliver the plan, e.g. software, hardware, technical expertise, etc. Where dedicated resources are needed, these should be outlined and justified.</p>",
    themes: ["Resourcing"],
    format: "Text area"
  }
}

questions.each do |q, details|
  question = Question.new
  question.text = details[:text]
  question.number = details[:number]
  question.guidance = details[:guidance]
  question.question_format = QuestionFormat.find_by_title(details[:format])
  question.section = Section.find_by_title(details[:section])
  details[:themes].each do |theme|
    question.themes << Theme.find_by_title(theme)
  end
  question.save!
end

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
