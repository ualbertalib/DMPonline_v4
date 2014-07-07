# -*- encoding: utf-8 -*-
# stub: friendly_id 4.0.10.1 ruby lib

Gem::Specification.new do |s|
  s.name = "friendly_id"
  s.version = "4.0.10.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Norman Clarke", "Philip Arndt"]
  s.date = "2013-08-20"
  s.description = "FriendlyId is the \"Swiss Army bulldozer\" of slugging and permalink plugins for\nRuby on Rails. It allows you to create pretty URLs and work with human-friendly\nstrings as if they were numeric ids for Active Record models.\n"
  s.email = ["norman@njclarke.com", "parndt@gmail.com"]
  s.homepage = "http://github.com/norman/friendly_id"
  s.licenses = ["MIT"]
  s.post_install_message = "NOTE: FriendlyId 4.x breaks compatibility with 3.x. If you're upgrading\nfrom 3.x, please see this document:\n\nhttp://rubydoc.info/github/norman/friendly_id/master/file/WhatsNew.md\n\n"
  s.rubyforge_project = "friendly_id"
  s.rubygems_version = "2.2.0"
  s.summary = "A comprehensive slugging and pretty-URL plugin."

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, ["< 4.0", ">= 3.0"])
      s.add_development_dependency(%q<railties>, ["< 4.0", ">= 3.0"])
      s.add_development_dependency(%q<minitest>, ["~> 4.4.0"])
      s.add_development_dependency(%q<mocha>, ["~> 0.13.1"])
      s.add_development_dependency(%q<maruku>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<i18n>, [">= 0"])
      s.add_development_dependency(%q<ffaker>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<globalize3>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, ["< 4.0", ">= 3.0"])
      s.add_dependency(%q<railties>, ["< 4.0", ">= 3.0"])
      s.add_dependency(%q<minitest>, ["~> 4.4.0"])
      s.add_dependency(%q<mocha>, ["~> 0.13.1"])
      s.add_dependency(%q<maruku>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<ffaker>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<globalize3>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, ["< 4.0", ">= 3.0"])
    s.add_dependency(%q<railties>, ["< 4.0", ">= 3.0"])
    s.add_dependency(%q<minitest>, ["~> 4.4.0"])
    s.add_dependency(%q<mocha>, ["~> 0.13.1"])
    s.add_dependency(%q<maruku>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<ffaker>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<globalize3>, [">= 0"])
  end
end
