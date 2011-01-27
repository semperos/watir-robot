require 'rubygems'
require 'rake'
require 'yard'
require 'fileutils'
require 'echoe'

PROJECT_DIR = File.expand_path(File.dirname(__FILE__))

Echoe.new('watir_robot') do |p|
  p.description    = "Watir Robot - Remote keyword library for Robot Framework"
  p.url            = "http://github.com/semperos/watir-robot"
  p.author         = "Daniel Gregoire"
  p.ignore_pattern = ["tmp/*", "scripts/*", "yardoc/*"]
  p.runtime_dependencies = ['robot_remote_server >=2.5.5.2', 'watir-webdriver >=0.1.8']
  p.need_tar_gz = false
end

YARD::Rake::YardocTask.new do |t|
#  t.files   = ['lib/**/*.rb', OTHER_PATHS]
  t.options = ['-b', 'yardoc']
end


namespace :clean do
  desc "Remove Robot Framework test-run output"
  task :rf do
    FileUtils.rm Dir.glob(File.join('**', 'example_tests', '*.html'))
    FileUtils.rm Dir.glob(File.join('**', 'example_tests', '*.xml'))
    FileUtils.rm Dir.glob(File.join('**', '*.png'))
  end

  desc "Remove YARD documentation"
  task :doc do
    doc_dir = File.join(PROJECT_DIR, "doc")
    FileUtils.rm_rf(doc_dir) if File.exists?(doc_dir)
  end

  desc "Remote YARD registry cache"
  task :yardoc do
    yardoc_dir = File.join(PROJECT_DIR, "yardoc")
    FileUtils.rm_rf(yardoc_dir) if File.exists?(yardoc_dir)
  end

  desc "Cleanup all generated files"
  task :all do
    Rake::Task['clean:rf'].invoke
    Rake::Task['clean:doc'].invoke
    Rake::Task['clean:yardoc'].invoke
  end
end