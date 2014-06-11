module Settings
  class Dmptemplate < RailsSettings::SettingObject

    DEFAULT_FORMATTING = {
      margin: { # in millimeters
        top:    20,
        bottom: 20,
        left:   20,
        right:  20
      },
      font_face: 'Arial, Helvetica, Sans-Serif',
      font_size: 12 # pt
    }

    validate do
      formatting = value['formatting']

      if formatting.present?
        errs = []
        errs << :negative_margin if formatting[:margin].any? {|m| m.to_i < 0 }
        errs << :negative_font_size if formatting[:font_size].to_i < 0
        errs << :unkown_margin unless (formatting.margin.keys - DEFAULT_FORMATTING.margin.keys).empty?
        errs << :unknown_key unless (formatting.keys - DEFAULT_FORMATTING.keys).empty?

        errs.map do |key|
          errors.add(:formatting, I18n.t("helpers.settings.templates.errors.#{key}"))
        end
      end
    end
  end
end
