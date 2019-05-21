module Htmltoword
  module XSLTHelper
    def document_xslt(extras = false)
      file_name = extras ? 'htmltoword' : 'base'
      xslt_path(file_name)
    end

    def xslt_path(template_name)
      File.join(Htmltoword.config.default_xslt_path, "#{template_name}.xslt")
    end

    def xslt(stylesheet_name: nil, stylesheet_path: nil)
      return Nokogiri::XSLT(File.open(stylesheet_path)) if stylesheet_path
      Nokogiri::XSLT(File.open(xslt_path(stylesheet_name)))
    end
  end
end
