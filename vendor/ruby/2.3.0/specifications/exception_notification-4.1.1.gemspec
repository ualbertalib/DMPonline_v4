# -*- encoding: utf-8 -*-
# stub: exception_notification 4.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "exception_notification".freeze
  s.version = "4.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.8.11".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jamis Buck".freeze, "Josh Peek".freeze]
  s.date = "2015-06-09"
  s.email = "smartinez87@gmail.com".freeze
  s.homepage = "http://smartinez87.github.com/exception_notification".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "2.7.8".freeze
  s.summary = "Exception notification for Rails apps".freeze

  s.installed_by_version = "2.7.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionmailer>.freeze, [">= 3.0.4"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.0.4"])
      s.add_development_dependency(%q<rails>.freeze, [">= 3.0.4"])
      s.add_development_dependency(%q<resque>.freeze, ["~> 1.2.0"])
      s.add_development_dependency(%q<sidekiq>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<tinder>.freeze, ["~> 1.8"])
      s.add_development_dependency(%q<httparty>.freeze, ["~> 0.10.2"])
      s.add_development_dependency(%q<mocha>.freeze, [">= 0.13.0"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 1.3.4"])
      s.add_development_dependency(%q<coveralls>.freeze, ["~> 0.6.5"])
      s.add_development_dependency(%q<appraisal>.freeze, ["~> 1.0.0"])
      s.add_development_dependency(%q<hipchat>.freeze, [">= 1.0.0"])
      s.add_development_dependency(%q<carrier-pigeon>.freeze, [">= 0.7.0"])
      s.add_development_dependency(%q<slack-notifier>.freeze, [">= 1.0.0"])
    else
      s.add_dependency(%q<actionmailer>.freeze, [">= 3.0.4"])
      s.add_dependency(%q<activesupport>.freeze, [">= 3.0.4"])
      s.add_dependency(%q<rails>.freeze, [">= 3.0.4"])
      s.add_dependency(%q<resque>.freeze, ["~> 1.2.0"])
      s.add_dependency(%q<sidekiq>.freeze, ["~> 3.0"])
      s.add_dependency(%q<tinder>.freeze, ["~> 1.8"])
      s.add_dependency(%q<httparty>.freeze, ["~> 0.10.2"])
      s.add_dependency(%q<mocha>.freeze, [">= 0.13.0"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 1.3.4"])
      s.add_dependency(%q<coveralls>.freeze, ["~> 0.6.5"])
      s.add_dependency(%q<appraisal>.freeze, ["~> 1.0.0"])
      s.add_dependency(%q<hipchat>.freeze, [">= 1.0.0"])
      s.add_dependency(%q<carrier-pigeon>.freeze, [">= 0.7.0"])
      s.add_dependency(%q<slack-notifier>.freeze, [">= 1.0.0"])
    end
  else
    s.add_dependency(%q<actionmailer>.freeze, [">= 3.0.4"])
    s.add_dependency(%q<activesupport>.freeze, [">= 3.0.4"])
    s.add_dependency(%q<rails>.freeze, [">= 3.0.4"])
    s.add_dependency(%q<resque>.freeze, ["~> 1.2.0"])
    s.add_dependency(%q<sidekiq>.freeze, ["~> 3.0"])
    s.add_dependency(%q<tinder>.freeze, ["~> 1.8"])
    s.add_dependency(%q<httparty>.freeze, ["~> 0.10.2"])
    s.add_dependency(%q<mocha>.freeze, [">= 0.13.0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 1.3.4"])
    s.add_dependency(%q<coveralls>.freeze, ["~> 0.6.5"])
    s.add_dependency(%q<appraisal>.freeze, ["~> 1.0.0"])
    s.add_dependency(%q<hipchat>.freeze, [">= 1.0.0"])
    s.add_dependency(%q<carrier-pigeon>.freeze, [">= 0.7.0"])
    s.add_dependency(%q<slack-notifier>.freeze, [">= 1.0.0"])
  end
end
