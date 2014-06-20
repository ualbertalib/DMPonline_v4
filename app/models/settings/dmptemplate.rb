module Settings
  class Dmptemplate < RailsSettings::SettingObject

    VALID_FONT_FACES = [
      'Arial, Helvetica, Sans-Serif',
      '"Times New Roman", Times, Serif'
    ]

    DEFAULT_FORMATTING = {
      margin: { # in millimeters
        top:    20,
        bottom: 20,
        left:   20,
        right:  20
      },
      font_face: VALID_FONT_FACES.first,
      font_size: 12 # pt
    }

    DEFAULT_MAX_PAGES = 3

    validate do
      formatting = value['formatting']
      max_pages  = value['max_pages']

      if formatting.present?
        errs = []

        unless (DEFAULT_FORMATTING.keys - formatting.keys).empty?
          errs << :missing_key
        else
          unless formatting[:margin].is_a?(Hash)
            errs << :invalid_margin
          else
            errs << :negative_margin if formatting[:margin].any? {|k,v| v.to_i < 0 }
            errs << :unknown_margin unless (formatting[:margin].keys - DEFAULT_FORMATTING[:margin].keys).empty?
          end

          errs << :invalid_font_size if formatting[:font_size].to_s !~ /^\d+$/
          errs << :invalid_font_face unless VALID_FONT_FACES.member?(formatting[:font_face])
          errs << :unknown_key unless (formatting.keys - DEFAULT_FORMATTING.keys).empty?
        end

        errs.map do |key|
          errors.add(:formatting, I18n.t("helpers.settings.plans.errors.#{key}"))
        end

      end

      if max_pages.present? && (!max_pages.is_a?(Integer) || max_pages <= 0)
        errors.add(:max_pages, I18n.t('helpers.settings.plans.errors.invalid_max_pages'))
      end
    end

    before_save do
      self.formatting[:font_size] = self.formatting[:font_size].to_i if self.formatting[:font_size].present?
      self.formatting[:margin].each do |key, val|
        self.formatting[:margin][key] = val.to_i
      end
    end
  end
end
