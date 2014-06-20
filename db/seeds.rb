# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Dmptemplate default formatting settings based on https://je-s.rcuk.ac.uk/Handbook/pages/GuidanceonCompletingaStandardG/CaseforSupportandAttachments/CaseforSupportandAttachments.htm

formatting = {
  'AHRC' => {
    font_face: "Arial, Helvetica, Sans-Serif",
    font_size: 11,
    margin: { top: 20, bottom: 20, left: 20, right: 20 }
  },
  'BBSRC' => {
    font_face: "Arial, Helvetica, Sans-Serif",
    font_size: 11,
    margin: { top: 20, bottom: 20, left: 20, right: 20 }
  },
  'CRUK' => {
    font_face: "Arial, Helvetica, Sans-Serif",
    font_size: 12,
    margin: { top: 20, bottom: 20, left: 20, right: 20 }
  },
  'DMP' => {
    font_face: "Arial, Helvetica, Sans-Serif",
    font_size: 12,
    margin: { top: 20, bottom: 20, left: 20, right: 20 }
  },
  'ESRC' => {
    font_face: "Arial, Helvetica, Sans-Serif",
    font_size: 11,
    margin: { top: 20, bottom: 20, left: 20, right: 20 }
  },
  'MRC' => {
    font_face: "Arial, Helvetica, Sans-Serif",
    font_size: 11,
    margin: { top: 20, bottom: 20, left: 20, right: 20 }
  },
  'NERC' => {
    font_face: "Arial, Helvetica, Sans-Serif",
    font_size: 11,
    margin: { top: 20, bottom: 20, left: 20, right: 20 }
  },
  'STFC' => {
    font_face: "Arial, Helvetica, Sans-Serif",
    font_size: 11,
    margin: { top: 20, bottom: 20, left: 20, right: 20 }
  },
  'Wellcome Trust' => {
    font_face: "Arial, Helvetica, Sans-Serif",
    font_size: 12,
    margin: { top: 20, bottom: 20, left: 20, right: 20 }
  }
}

formatting.each do |org, settings|
  template = Dmptemplate.find_by_title("#{org} Template")
  template.settings(:export).formatting = settings
  template.save!
end
