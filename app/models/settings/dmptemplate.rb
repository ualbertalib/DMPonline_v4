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

    class << self
      def default_formatting_for(project)
        if project.dmptemplate.present?
          project.dmptemplate.settings(:export).formatting
        else
          DEFAULT_FORMATTING
        end
      end
    end

    validate do
      formatting = value['formatting']

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
    end

    before_save do
      self.formatting[:font_size] = self.formatting[:font_size].to_i
    end
  end
end
