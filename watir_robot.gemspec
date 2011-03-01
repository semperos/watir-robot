# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{watir_robot}
  s.version = "0.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Gregoire"]
  s.date = %q{2011-03-01}
  s.description = %q{Watir Robot - Remote keyword library for Robot Framework}
  s.email = %q{}
  s.extra_rdoc_files = ["CHANGELOG", "LICENSE", "README.rdoc", "lib/watir_robot.rb", "lib/watir_robot/exception.rb", "lib/watir_robot/keywords/area.rb", "lib/watir_robot/keywords/browser.rb", "lib/watir_robot/keywords/button.rb", "lib/watir_robot/keywords/checkbox.rb", "lib/watir_robot/keywords/element.rb", "lib/watir_robot/keywords/file_field.rb", "lib/watir_robot/keywords/form.rb", "lib/watir_robot/keywords/image.rb", "lib/watir_robot/keywords/link.rb", "lib/watir_robot/keywords/list.rb", "lib/watir_robot/keywords/native.rb", "lib/watir_robot/keywords/page.rb", "lib/watir_robot/keywords/radio.rb", "lib/watir_robot/keywords/select.rb", "lib/watir_robot/keywords/table.rb", "lib/watir_robot/keywords/text_field.rb", "lib/watir_robot/parser.rb"]
  s.files = ["CHANGELOG", "KEYWORDS.rdoc", "LICENSE", "Manifest", "README.rdoc", "Rakefile", "lib/watir_robot.rb", "lib/watir_robot/exception.rb", "lib/watir_robot/keywords/area.rb", "lib/watir_robot/keywords/browser.rb", "lib/watir_robot/keywords/button.rb", "lib/watir_robot/keywords/checkbox.rb", "lib/watir_robot/keywords/element.rb", "lib/watir_robot/keywords/file_field.rb", "lib/watir_robot/keywords/form.rb", "lib/watir_robot/keywords/image.rb", "lib/watir_robot/keywords/link.rb", "lib/watir_robot/keywords/list.rb", "lib/watir_robot/keywords/native.rb", "lib/watir_robot/keywords/page.rb", "lib/watir_robot/keywords/radio.rb", "lib/watir_robot/keywords/select.rb", "lib/watir_robot/keywords/table.rb", "lib/watir_robot/keywords/text_field.rb", "lib/watir_robot/parser.rb", "watir_robot.gemspec"]
  s.homepage = %q{http://github.com/semperos/watir-robot}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Watir_robot", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{watir_robot}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Watir Robot - Remote keyword library for Robot Framework}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<robot_remote_server>, [">= 2.5.5.2"])
      s.add_runtime_dependency(%q<watir-webdriver>, [">= 0.1.8"])
    else
      s.add_dependency(%q<robot_remote_server>, [">= 2.5.5.2"])
      s.add_dependency(%q<watir-webdriver>, [">= 0.1.8"])
    end
  else
    s.add_dependency(%q<robot_remote_server>, [">= 2.5.5.2"])
    s.add_dependency(%q<watir-webdriver>, [">= 0.1.8"])
  end
end
