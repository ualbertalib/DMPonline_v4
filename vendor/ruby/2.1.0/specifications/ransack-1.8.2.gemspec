# -*- encoding: utf-8 -*-
# stub: ransack 1.8.2 ruby lib

Gem::Specification.new do |s|
  s.name = "ransack"
  s.version = "1.8.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Ernie Miller", "Ryan Bigg", "Jon Atack"]
  s.date = "2016-08-08"
  s.description = "Ransack is the successor to the MetaSearch gem. It improves and expands upon MetaSearch's functionality, but does not have a 100%-compatible API."
  s.email = ["ernie@erniemiller.org", "radarlistener@gmail.com", "jonnyatack@gmail.com"]
  s.homepage = "https://github.com/activerecord-hackery/ransack"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9")
  s.rubyforge_project = "ransack"
  s.rubygems_version = "2.2.0"
  s.summary = "Object-based searching for Active Record and Mongoid (currently)."

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, [">= 3.0"])
      s.add_runtime_dependency(%q<activerecord>, [">= 3.0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0"])
      s.add_runtime_dependency(%q<i18n>, [">= 0"])
      s.add_runtime_dependency(%q<polyamorous>, ["~> 1.3"])
      s.add_development_dependency(%q<rspec>, ["~> 3"])
      s.add_development_dependency(%q<machinist>, ["~> 1.0.6"])
      s.add_development_dependency(%q<faker>, ["~> 0.9.5"])
      s.add_development_dependency(%q<sqlite3>, ["~> 1.3.3"])
      s.add_development_dependency(%q<pg>, [">= 0"])
      s.add_development_dependency(%q<mysql2>, ["= 0.3.20"])
      s.add_development_dependency(%q<pry>, ["= 0.10"])
    else
      s.add_dependency(%q<actionpack>, [">= 3.0"])
      s.add_dependency(%q<activerecord>, [">= 3.0"])
      s.add_dependency(%q<activesupport>, [">= 3.0"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<polyamorous>, ["~> 1.3"])
      s.add_dependency(%q<rspec>, ["~> 3"])
      s.add_dependency(%q<machinist>, ["~> 1.0.6"])
      s.add_dependency(%q<faker>, ["~> 0.9.5"])
      s.add_dependency(%q<sqlite3>, ["~> 1.3.3"])
      s.add_dependency(%q<pg>, [">= 0"])
      s.add_dependency(%q<mysql2>, ["= 0.3.20"])
      s.add_dependency(%q<pry>, ["= 0.10"])
    end
  else
    s.add_dependency(%q<actionpack>, [">= 3.0"])
    s.add_dependency(%q<activerecord>, [">= 3.0"])
    s.add_dependency(%q<activesupport>, [">= 3.0"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<polyamorous>, ["~> 1.3"])
    s.add_dependency(%q<rspec>, ["~> 3"])
    s.add_dependency(%q<machinist>, ["~> 1.0.6"])
    s.add_dependency(%q<faker>, ["~> 0.9.5"])
    s.add_dependency(%q<sqlite3>, ["~> 1.3.3"])
    s.add_dependency(%q<pg>, [">= 0"])
    s.add_dependency(%q<mysql2>, ["= 0.3.20"])
    s.add_dependency(%q<pry>, ["= 0.10"])
  end
end
