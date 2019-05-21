module Htmltoword
  module TemplatesHelper
    def template_file(template_file_name = nil)
      default_path = File.join(::Htmltoword.config.default_templates_path, 'default.docx')
      template_path = template_file_name.nil? ? '' : File.join(::Htmltoword.config.custom_templates_path, template_file_name)
      File.exist?(template_path) ? template_path : default_path
    end
  end
end
