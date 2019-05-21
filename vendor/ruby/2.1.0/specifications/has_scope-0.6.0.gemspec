# -*- encoding: utf-8 -*-
# stub: has_scope 0.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "has_scope".freeze
  s.version = "0.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jos\u{e9} Valim".freeze]
  s.date = "2015-02-08"
  s.description = "Maps controller filters to your resource scopes".freeze
  s.email = "opensource@plataformatec.com.br".freeze
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze]
  s.homepage = "http://github.com/plataformatec/has_scope".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.rubygems_version = "2.7.9".freeze
  s.summary = "Maps controller filters to your resource scopes.".freeze

  s.installed_by_version = "2.7.9" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>.freeze, [">= 3.2", "< 5"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.2", "< 5"])
    else
      s.add_dependency(%q<actionpack>.freeze, [">= 3.2", "< 5"])
      s.add_dependency(%q<activesupport>.freeze, [">= 3.2", "< 5"])
    end
  else
    s.add_dependency(%q<actionpack>.freeze, [">= 3.2", "< 5"])
    s.add_dependency(%q<activesupport>.freeze, [">= 3.2", "< 5"])
  end
end
