module Htmltoword
  class Document
    class << self
      include HtmltowordHelper

      def create(content, template_name = nil, extras = false)
        template_name += extension if template_name && !template_name.end_with?(extension)
        document = new(template_file(template_name))
        document.replace_file(content, Document.doc_xml_file, extras)
        document.generate
      end

      def create_with_content(template, content, set=nil, extras = false)
        template += extension unless template.end_with?(extension)
        content = replace_values(content, set) if set
        document = new(template_file(template))
        document.replace_file(content, Document.doc_xml_file, extras)
        document.generate
      end

      def extension
        '.docx'
      end

      def doc_xml_file
        'word/document.xml'
      end

      def numbering_xml_file
        'word/numbering.xml'
      end

      def numbering_xslt
        File.join(Htmltoword.config.default_xslt_path, 'numbering.xslt')
      end

      def xslt_template(extras = false)
        File.join(Htmltoword.config.default_xslt_path, (extras ? 'htmltoword.xslt' : 'base.xslt'))
      end
    end

    def initialize(template_path)
      @replaceable_files = {}
      @template_path = template_path
    end

    #
    # Generate a string representing the contents of a docx file.
    #
    def generate
      Zip::File.open(@template_path) do |template_zip|
        buffer = Zip::OutputStream.write_buffer do |out|
          template_zip.each do |entry|
            out.put_next_entry entry.name
            if @replaceable_files[entry.name] && entry.name == Document.doc_xml_file
              source = entry.get_input_stream.read.sub(/(<w:body>)((.|\n)*?)(<w:sectPr)/, "\\1#{@replaceable_files[entry.name]}\\4")
              out.write(source)
            elsif @replaceable_files[entry.name]
              out.write(@replaceable_files[entry.name])
            else
              out.write(template_zip.read(entry.name))
            end
          end
        end
        buffer.string
      end
    end

    def replace_file(html, file_name = Document.doc_xml_file, extras = false)
      html = html.presence || '<body></body>'
      source = Nokogiri::HTML(html.gsub(/>\s+</, '><'))
      transform_and_replace(source, Document.numbering_xslt, Document.numbering_xml_file)
      transform_and_replace(source, Document.xslt_template(extras), file_name, extras)
    end

    private

    def transform_and_replace source, xslt, file, remove_ns = false
      xslt = Nokogiri::XSLT(File.open(xslt))
      content = xslt.apply_to(source)
      content.gsub!(/\s*xmlns:(\w+)="(.*?)\s*"/,'') if remove_ns
      @replaceable_files[file] =  content
    end
  end
end
