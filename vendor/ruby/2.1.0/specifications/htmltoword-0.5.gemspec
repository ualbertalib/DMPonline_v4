# -*- encoding: utf-8 -*-
# stub: htmltoword 0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "htmltoword"
  s.version = "0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nicholas Frandsen, Cristina Matonte"]
  s.date = "2015-11-11"
  s.description = "Convert html to word docx document."
  s.email = ["nick.rowe.frandsen@gmail.com, anitsirc1@gmail.com"]
  s.executables = ["htmltoword"]
  s.files = ["bin/htmltoword"]
  s.homepage = "http://github.com/karnov/htmltoword"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.0"
  s.summary = "This simple gem allows you to create MS Word docx documents from simple html documents. This makes it easy to create dynamic reports and forms that can be downloaded by your users as simple MS Word docx files."

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<rubyzip>, [">= 1.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<methadone>, [">= 0"])
      s.add_development_dependency(%q<rmultimarkdown>, [">= 0"])
    else
      s.add_dependency(%q<actionpack>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<rubyzip>, [">= 1.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<methadone>, [">= 0"])
      s.add_dependency(%q<rmultimarkdown>, [">= 0"])
    end
  else
    s.add_dependency(%q<actionpack>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<rubyzip>, [">= 1.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<methadone>, [">= 0"])
    s.add_dependency(%q<rmultimarkdown>, [">= 0"])
  end
end
