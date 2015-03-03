# -*- encoding: utf-8 -*-
# stub: activeadmin 0.6.6 ruby lib

Gem::Specification.new do |s|
  s.name = "activeadmin"
  s.version = "0.6.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Greg Bell"]
  s.date = "2015-02-02"
  s.description = "The administration framework for Ruby on Rails."
  s.email = ["gregdbell@gmail.com"]
  s.homepage = "http://activeadmin.info"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.0"
  s.summary = "The administration framework for Ruby on Rails."

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<arbre>, ["~> 1.0"])
      s.add_runtime_dependency(%q<bourbon>, ["< 4", ">= 1.0.0"])
      s.add_runtime_dependency(%q<devise>, ["< 4", ">= 1.5.4"])
      s.add_runtime_dependency(%q<formtastic>, ["~> 2.0"])
      s.add_runtime_dependency(%q<inherited_resources>, ["~> 1.3"])
      s.add_runtime_dependency(%q<jquery-rails>, ["< 3", ">= 1.0.0"])
      s.add_runtime_dependency(%q<kaminari>, ["!= 0.15.0", "~> 0.13"])
      s.add_runtime_dependency(%q<meta_search>, ["~> 1.0"])
      s.add_runtime_dependency(%q<rails>, ["< 4", ">= 3.0.0"])
      s.add_runtime_dependency(%q<sass>, ["~> 3.1"])
    else
      s.add_dependency(%q<arbre>, ["~> 1.0"])
      s.add_dependency(%q<bourbon>, ["< 4", ">= 1.0.0"])
      s.add_dependency(%q<devise>, ["< 4", ">= 1.5.4"])
      s.add_dependency(%q<formtastic>, ["~> 2.0"])
      s.add_dependency(%q<inherited_resources>, ["~> 1.3"])
      s.add_dependency(%q<jquery-rails>, ["< 3", ">= 1.0.0"])
      s.add_dependency(%q<kaminari>, ["!= 0.15.0", "~> 0.13"])
      s.add_dependency(%q<meta_search>, ["~> 1.0"])
      s.add_dependency(%q<rails>, ["< 4", ">= 3.0.0"])
      s.add_dependency(%q<sass>, ["~> 3.1"])
    end
  else
    s.add_dependency(%q<arbre>, ["~> 1.0"])
    s.add_dependency(%q<bourbon>, ["< 4", ">= 1.0.0"])
    s.add_dependency(%q<devise>, ["< 4", ">= 1.5.4"])
    s.add_dependency(%q<formtastic>, ["~> 2.0"])
    s.add_dependency(%q<inherited_resources>, ["~> 1.3"])
    s.add_dependency(%q<jquery-rails>, ["< 3", ">= 1.0.0"])
    s.add_dependency(%q<kaminari>, ["!= 0.15.0", "~> 0.13"])
    s.add_dependency(%q<meta_search>, ["~> 1.0"])
    s.add_dependency(%q<rails>, ["< 4", ">= 3.0.0"])
    s.add_dependency(%q<sass>, ["~> 3.1"])
  end
end
