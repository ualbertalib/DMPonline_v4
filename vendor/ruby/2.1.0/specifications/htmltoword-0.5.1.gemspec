# -*- encoding: utf-8 -*-
# stub: htmltoword 0.5.1 ruby lib

Gem::Specification.new do |s|
  s.name = "htmltoword".freeze
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nicholas Frandsen, Cristina Matonte".freeze]
  s.date = "2015-11-24"
  s.description = "Convert html to word docx document.".freeze
  s.email = ["nick.rowe.frandsen@gmail.com, anitsirc1@gmail.com".freeze]
  s.executables = ["htmltoword".freeze]
  s.files = ["bin/htmltoword".freeze]
  s.homepage = "http://github.com/karnov/htmltoword".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.9".freeze
  s.summary = "This simple gem allows you to create MS Word docx documents from simple html documents. This makes it easy to create dynamic reports and forms that can be downloaded by your users as simple MS Word docx files.".freeze

  s.installed_by_version = "2.7.9" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<rubyzip>.freeze, [">= 1.0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<methadone>.freeze, [">= 0"])
      s.add_development_dependency(%q<rmultimarkdown>.freeze, [">= 0"])
    else
      s.add_dependency(%q<actionpack>.freeze, [">= 0"])
      s.add_dependency(%q<nokogiri>.freeze, [">= 0"])
      s.add_dependency(%q<rubyzip>.freeze, [">= 1.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<methadone>.freeze, [">= 0"])
      s.add_dependency(%q<rmultimarkdown>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<actionpack>.freeze, [">= 0"])
    s.add_dependency(%q<nokogiri>.freeze, [">= 0"])
    s.add_dependency(%q<rubyzip>.freeze, [">= 1.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<methadone>.freeze, [">= 0"])
    s.add_dependency(%q<rmultimarkdown>.freeze, [">= 0"])
  end
end
