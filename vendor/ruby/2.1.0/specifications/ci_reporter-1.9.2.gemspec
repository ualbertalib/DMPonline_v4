# -*- encoding: utf-8 -*-
# stub: ci_reporter 1.9.2 ruby lib

Gem::Specification.new do |s|
  s.name = "ci_reporter".freeze
  s.version = "1.9.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Sieger".freeze]
  s.date = "2014-04-06"
  s.description = "CI::Reporter is an add-on to Test::Unit, RSpec and Cucumber that allows you to generate XML reports of your test, spec and/or feature runs. The resulting files can be read by a continuous integration system that understands Ant's JUnit report XML format, thus allowing your CI system to track test/spec successes and failures.".freeze
  s.email = "nick@nicksieger.com".freeze
  s.extra_rdoc_files = ["History.txt".freeze, "LICENSE.txt".freeze, "Manifest.txt".freeze, "README.rdoc".freeze]
  s.files = ["History.txt".freeze, "LICENSE.txt".freeze, "Manifest.txt".freeze, "README.rdoc".freeze]
  s.homepage = "https://github.com/nicksieger/ci_reporter".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze, "-SHN".freeze, "-f".freeze, "darkfish".freeze]
  s.rubyforge_project = "caldersphere".freeze
  s.rubygems_version = "2.7.9".freeze
  s.summary = "CI::Reporter allows you to generate reams of XML for use with continuous integration systems.".freeze

  s.installed_by_version = "2.7.9" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<builder>.freeze, [">= 2.1.2"])
      s.add_development_dependency(%q<rdoc>.freeze, ["~> 4.0"])
      s.add_development_dependency(%q<hoe-git>.freeze, ["~> 1.5.0"])
      s.add_development_dependency(%q<cucumber>.freeze, [">= 1.3.3"])
      s.add_development_dependency(%q<rspec>.freeze, ["> 2.0.0"])
      s.add_development_dependency(%q<test-unit>.freeze, ["> 2.4.9"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 2.2.0"])
      s.add_development_dependency(%q<spinach>.freeze, [">= 0.8.7"])
      s.add_development_dependency(%q<hoe>.freeze, ["~> 3.7"])
    else
      s.add_dependency(%q<builder>.freeze, [">= 2.1.2"])
      s.add_dependency(%q<rdoc>.freeze, ["~> 4.0"])
      s.add_dependency(%q<hoe-git>.freeze, ["~> 1.5.0"])
      s.add_dependency(%q<cucumber>.freeze, [">= 1.3.3"])
      s.add_dependency(%q<rspec>.freeze, ["> 2.0.0"])
      s.add_dependency(%q<test-unit>.freeze, ["> 2.4.9"])
      s.add_dependency(%q<minitest>.freeze, ["~> 2.2.0"])
      s.add_dependency(%q<spinach>.freeze, [">= 0.8.7"])
      s.add_dependency(%q<hoe>.freeze, ["~> 3.7"])
    end
  else
    s.add_dependency(%q<builder>.freeze, [">= 2.1.2"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 4.0"])
    s.add_dependency(%q<hoe-git>.freeze, ["~> 1.5.0"])
    s.add_dependency(%q<cucumber>.freeze, [">= 1.3.3"])
    s.add_dependency(%q<rspec>.freeze, ["> 2.0.0"])
    s.add_dependency(%q<test-unit>.freeze, ["> 2.4.9"])
    s.add_dependency(%q<minitest>.freeze, ["~> 2.2.0"])
    s.add_dependency(%q<spinach>.freeze, [">= 0.8.7"])
    s.add_dependency(%q<hoe>.freeze, ["~> 3.7"])
  end
end
