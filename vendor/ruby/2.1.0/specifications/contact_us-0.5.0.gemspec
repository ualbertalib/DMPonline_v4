# -*- encoding: utf-8 -*-
# stub: contact_us 0.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "contact_us".freeze
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jeff Dutil".freeze]
  s.date = "2013-11-19"
  s.description = "A Rails 3+ Engine providing a basic contact form.  I used Formtastic to keep things simple, and to hook into your apps custom Formtastic stylesheets.".freeze
  s.email = ["JDutil@BurlingtonWebApps.com".freeze]
  s.homepage = "https://github.com/jdutil/contact_us".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubyforge_project = "contact_us".freeze
  s.rubygems_version = "2.7.9".freeze
  s.summary = "Gem providing simple Contact Us functionality with a Rails 3+ Engine.".freeze

  s.installed_by_version = "2.7.9" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<capybara>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 2.13"])
      s.add_development_dependency(%q<shoulda-matchers>.freeze, [">= 1.5.4"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.7"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.3.5"])
      s.add_development_dependency(%q<formtastic>.freeze, [">= 2.1.0"])
      s.add_development_dependency(%q<simple_form>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<rails>.freeze, [">= 3.0.0"])
    else
      s.add_dependency(%q<capybara>.freeze, ["~> 2.0"])
      s.add_dependency(%q<rspec-rails>.freeze, ["~> 2.13"])
      s.add_dependency(%q<shoulda-matchers>.freeze, [">= 1.5.4"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.7"])
      s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3.5"])
      s.add_dependency(%q<formtastic>.freeze, [">= 2.1.0"])
      s.add_dependency(%q<simple_form>.freeze, [">= 0"])
      s.add_dependency(%q<rails>.freeze, [">= 3.0.0"])
    end
  else
    s.add_dependency(%q<capybara>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 2.13"])
    s.add_dependency(%q<shoulda-matchers>.freeze, [">= 1.5.4"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.7"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3.5"])
    s.add_dependency(%q<formtastic>.freeze, [">= 2.1.0"])
    s.add_dependency(%q<simple_form>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 3.0.0"])
  end
end
