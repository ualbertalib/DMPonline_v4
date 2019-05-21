# -*- encoding: utf-8 -*-
# stub: dragonfly 1.0.12 ruby lib

Gem::Specification.new do |s|
  s.name = "dragonfly".freeze
  s.version = "1.0.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mark Evans".freeze]
  s.date = "2015-09-16"
  s.description = "Dragonfly is a framework that enables on-the-fly processing for any content type.\n  It is especially suited to image handling. Its uses range from image thumbnails to standard attachments to on-demand text generation.".freeze
  s.email = "mark@new-bamboo.co.uk".freeze
  s.extra_rdoc_files = ["LICENSE".freeze, "README.md".freeze]
  s.files = ["LICENSE".freeze, "README.md".freeze]
  s.homepage = "http://github.com/markevans/dragonfly".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "================================================================================\n\nYou've installed Dragonfly hooray!!\n\nQuite a few things have changed since version 0.9.\nPlease check the documentation at <http://markevans.github.io/dragonfly>\nand see upgrade notes at <https://github.com/markevans/dragonfly/wiki/Upgrading-from-0.9-to-1.0> if upgrading.\n\n================================================================================\n".freeze
  s.rubygems_version = "2.7.8".freeze
  s.summary = "Ideal gem for handling attachments in Rails, Sinatra and Rack applications.".freeze

  s.installed_by_version = "2.7.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>.freeze, [">= 1.3.0"])
      s.add_runtime_dependency(%q<multi_json>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<addressable>.freeze, ["~> 2.3"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.5"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_development_dependency(%q<activemodel>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rack>.freeze, [">= 1.3.0"])
      s.add_dependency(%q<multi_json>.freeze, ["~> 1.0"])
      s.add_dependency(%q<addressable>.freeze, ["~> 2.3"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.5"])
      s.add_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_dependency(%q<activemodel>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rack>.freeze, [">= 1.3.0"])
    s.add_dependency(%q<multi_json>.freeze, ["~> 1.0"])
    s.add_dependency(%q<addressable>.freeze, ["~> 2.3"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.5"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_dependency(%q<activemodel>.freeze, [">= 0"])
  end
end
