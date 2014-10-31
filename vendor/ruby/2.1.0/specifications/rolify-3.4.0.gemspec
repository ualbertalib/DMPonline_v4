# -*- encoding: utf-8 -*-
# stub: rolify 3.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rolify"
  s.version = "3.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Florent Monbillard"]
  s.date = "2014-01-28"
  s.description = "Very simple Roles library without any authorization enforcement supporting scope on resource objects (instance or class). Supports ActiveRecord and Mongoid ORMs."
  s.email = ["f.monbillard@gmail.com"]
  s.homepage = "http://eppo.github.com/rolify/"
  s.licenses = ["MIT"]
  s.rubyforge_project = "rolify"
  s.rubygems_version = "2.2.0"
  s.summary = "Roles library with resource scoping"

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<ammeter>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 2.0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<fuubar>, [">= 0"])
    else
      s.add_dependency(%q<ammeter>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.0"])
      s.add_dependency(%q<rspec-rails>, [">= 2.0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<fuubar>, [">= 0"])
    end
  else
    s.add_dependency(%q<ammeter>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.0"])
    s.add_dependency(%q<rspec-rails>, [">= 2.0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<fuubar>, [">= 0"])
  end
end
