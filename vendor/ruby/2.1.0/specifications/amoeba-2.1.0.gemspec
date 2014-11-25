# -*- encoding: utf-8 -*-
# stub: amoeba 2.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "amoeba"
  s.version = "2.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Vaughn Draughon"]
  s.date = "2014-09-08"
  s.description = "An extension to ActiveRecord to allow the duplication method to also copy associated children, with recursive support for nested of grandchildren. The behavior is controllable with a simple DSL both on your rails models and on the fly, i.e. per instance. Numerous configuration styles and preprocessing directives are included for power and flexibility. Supports preprocessing of field values to prepend strings such as \"Copy of \", to nullify or process field values with regular expressions. Supports most association types including has_one :through and has_many :through.\n\nTags: copy child associations, copy nested children, copy associated child records, nested copy, copy associations, copy relations, copy relationships, duplicate associations, duplicate associated records, duplicate child records, duplicate children, copy all, duplicate all, clone child associations, clone nested children, clone associated child records, nested clone, clone associations, clone relations, clone relationships, cloning child associations, cloning nested children, cloning associated child records, deep_cloning, nested cloning, cloning associations, cloning relations, cloning relationships, cloning child associations, cloning nested children, cloning associated child records, nested cloning, cloning associations, cloning relations, cloning relationships, cloning child associations, cloning nested children, cloning associated child records, deep_cloning, nested cloning, cloning associations, cloning relations, cloning relationships, duplicate child associations, duplicate nested children, duplicate associated child records, nested duplicate, duplicate associations, duplicate relations, duplicate relationships, duplicate child associations, duplicate nested children, duplicate associated child records, deep_duplicate, nested duplicate, duplicate associations, duplicate relations, duplicate relationships, deep_copy, deep_clone, deep_cloning, deep clone, deep cloning, has_one, has_many, has_and_belongs_to_many\n"
  s.email = "vaughn@rocksolidwebdesign.com"
  s.homepage = "http://github.com/rocksolidwebdesign/amoeba"
  s.licenses = ["BSD"]
  s.rubyforge_project = "amoeba"
  s.rubygems_version = "2.2.0"
  s.summary = "Easy copying of rails models and their child associations."

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_runtime_dependency(%q<activerecord>, ["< 5", ">= 3.2.6"])
    else
      s.add_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_dependency(%q<rspec>, ["~> 2.3"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<activerecord>, ["< 5", ">= 3.2.6"])
    end
  else
    s.add_dependency(%q<bundler>, [">= 1.0.0"])
    s.add_dependency(%q<rspec>, ["~> 2.3"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<activerecord>, ["< 5", ">= 3.2.6"])
  end
end
