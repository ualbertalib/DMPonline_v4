# -*- encoding: utf-8 -*-
# stub: arbre 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "arbre"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Greg Bell"]
  s.date = "2012-08-28"
  s.description = "An Object Oriented DOM Tree in Ruby"
  s.email = ["gregdbell@gmail.com"]
  s.homepage = ""
  s.rubygems_version = "2.2.0"
  s.summary = "An Object Oriented DOM Tree in Ruby"

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 3.0.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 3.0.0"])
  end
end
