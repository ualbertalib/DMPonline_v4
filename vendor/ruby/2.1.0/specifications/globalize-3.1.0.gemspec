# -*- encoding: utf-8 -*-
# stub: globalize 3.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "globalize".freeze
  s.version = "3.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Sven Fuchs".freeze, "Joshua Harvey".freeze, "Clemens Kofler".freeze, "John-Paul Bader".freeze, "Tomasz Stachewicz".freeze, "Philip Arndt".freeze, "Chris Salzberg".freeze]
  s.date = "2014-01-25"
  s.description = "Rails I18n de-facto standard library for ActiveRecord model/data translation.".freeze
  s.email = "nobody@globalize-rails.org".freeze
  s.homepage = "https://github.com/globalize/globalize".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "\nGlobalize has extracted versioning support to a separate gem named\nglobalize-versioning. If you are using versioning (with paper_trail\nor any other versioning gem), please add the line\n\"gem 'globalize-versioning'\" to your Gemfile and go to the github\npage at globalize/globalize-versioning if you encounter any problems.\n\nNote that the globalize-versioning gem does not delegate versions to\nthe translation table, so you will have to update your syntax to\nthe form: `post.translation.versions`. See the globalize-versioning\nreadme for details.\n\n".freeze
  s.rubygems_version = "2.7.9".freeze
  s.summary = "Rails I18n de-facto standard library for ActiveRecord model/data translation".freeze

  s.installed_by_version = "2.7.9" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>.freeze, [">= 3.1.0", "< 4.0.0"])
      s.add_runtime_dependency(%q<activemodel>.freeze, [">= 3.1.0", "< 4.0.0"])
      s.add_development_dependency(%q<database_cleaner>.freeze, ["~> 0.6.0"])
      s.add_development_dependency(%q<mocha>.freeze, [">= 0"])
      s.add_development_dependency(%q<pathname_local>.freeze, [">= 0"])
      s.add_development_dependency(%q<test_declarative>.freeze, [">= 0"])
      s.add_development_dependency(%q<friendly_id>.freeze, [">= 0"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rdoc>.freeze, [">= 0"])
    else
      s.add_dependency(%q<activerecord>.freeze, [">= 3.1.0", "< 4.0.0"])
      s.add_dependency(%q<activemodel>.freeze, [">= 3.1.0", "< 4.0.0"])
      s.add_dependency(%q<database_cleaner>.freeze, ["~> 0.6.0"])
      s.add_dependency(%q<mocha>.freeze, [">= 0"])
      s.add_dependency(%q<pathname_local>.freeze, [">= 0"])
      s.add_dependency(%q<test_declarative>.freeze, [">= 0"])
      s.add_dependency(%q<friendly_id>.freeze, [">= 0"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rdoc>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 3.1.0", "< 4.0.0"])
    s.add_dependency(%q<activemodel>.freeze, [">= 3.1.0", "< 4.0.0"])
    s.add_dependency(%q<database_cleaner>.freeze, ["~> 0.6.0"])
    s.add_dependency(%q<mocha>.freeze, [">= 0"])
    s.add_dependency(%q<pathname_local>.freeze, [">= 0"])
    s.add_dependency(%q<test_declarative>.freeze, [">= 0"])
    s.add_dependency(%q<friendly_id>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rdoc>.freeze, [">= 0"])
  end
end
