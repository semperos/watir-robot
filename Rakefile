require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('watir_robot') do |p|
  p.description    = "Watir Robot - Remote keyword library for Robot Framework"
  p.url            = "http://github.com/semperos/watir-robot"
  p.author         = "Daniel Gregoire"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.runtime_dependencies = ['robot_remote_server >=2.5.5.2', 'watir-webdriver >=0.1.8']
  p.need_tar_gz = false
end
