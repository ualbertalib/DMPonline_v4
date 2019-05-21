# -*- encoding: utf-8 -*-
# stub: friendly_id 4.0.10.1 ruby lib

Gem::Specification.new do |s|
  s.name = "friendly_id".freeze
  s.version = "4.0.10.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Norman Clarke".freeze, "Philip Arndt".freeze]
  s.date = "2013-08-20"
  s.description = "FriendlyId is the \"Swiss Army bulldozer\" of slugging and permalink plugins for\nRuby on Rails. It allows you to create pretty URLs and work with human-friendly\nstrings as if they were numeric ids for Active Record models.\n".freeze
  s.email = ["norman@njclarke.com".freeze, "parndt@gmail.com".freeze]
  s.homepage = "http://github.com/norman/friendly_id".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "NOTE: FriendlyId 4.x breaks compatibility with 3.x. If you're upgrading\nfrom 3.x, please see this document:\n\nhttp://rubydoc.info/github/norman/friendly_id/master/file/WhatsNew.md\n\n".freeze
  s.rubyforge_project = "friendly_id".freeze
  s.rubygems_version = "2.7.8".freeze
  s.summary = "A comprehensive slugging and pretty-URL plugin.".freeze

  s.installed_by_version = "2.7.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>.freeze, [">= 3.0", "< 4.0"])
      s.add_development_dependency(%q<railties>.freeze, [">= 3.0", "< 4.0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 4.4.0"])
      s.add_development_dependency(%q<mocha>.freeze, ["~> 0.13.1"])
      s.add_development_dependency(%q<maruku>.freeze, [">= 0"])
      s.add_development_dependency(%q<yard>.freeze, [">= 0"])
      s.add_development_dependency(%q<i18n>.freeze, [">= 0"])
      s.add_development_dependency(%q<ffaker>.freeze, [">= 0"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_development_dependency(%q<globalize3>.freeze, [">= 0"])
    else
      s.add_dependency(%q<activerecord>.freeze, [">= 3.0", "< 4.0"])
      s.add_dependency(%q<railties>.freeze, [">= 3.0", "< 4.0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 4.4.0"])
      s.add_dependency(%q<mocha>.freeze, ["~> 0.13.1"])
      s.add_dependency(%q<maruku>.freeze, [">= 0"])
      s.add_dependency(%q<yard>.freeze, [">= 0"])
      s.add_dependency(%q<i18n>.freeze, [">= 0"])
      s.add_dependency(%q<ffaker>.freeze, [">= 0"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_dependency(%q<globalize3>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 3.0", "< 4.0"])
    s.add_dependency(%q<railties>.freeze, [">= 3.0", "< 4.0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 4.4.0"])
    s.add_dependency(%q<mocha>.freeze, ["~> 0.13.1"])
    s.add_dependency(%q<maruku>.freeze, [">= 0"])
    s.add_dependency(%q<yard>.freeze, [">= 0"])
    s.add_dependency(%q<i18n>.freeze, [">= 0"])
    s.add_dependency(%q<ffaker>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<globalize3>.freeze, [">= 0"])
  end
end
