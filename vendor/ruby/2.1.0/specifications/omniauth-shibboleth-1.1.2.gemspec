# -*- encoding: utf-8 -*-
# stub: omniauth-shibboleth 1.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-shibboleth"
  s.version = "1.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Toyokazu Akiyama"]
  s.date = "2014-07-30"
  s.description = "OmniAuth Shibboleth strategies for OmniAuth 1.x"
  s.email = ["toyokazu@gmail.com"]
  s.homepage = ""
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.0"
  s.summary = "OmniAuth Shibboleth strategies for OmniAuth 1.x"

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<omniauth>, [">= 1.0.0"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.8"])
    else
      s.add_dependency(%q<omniauth>, [">= 1.0.0"])
      s.add_dependency(%q<rack-test>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.8"])
    end
  else
    s.add_dependency(%q<omniauth>, [">= 1.0.0"])
    s.add_dependency(%q<rack-test>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.8"])
  end
end
