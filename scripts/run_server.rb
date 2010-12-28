#!/usr/bin/env jruby

if __FILE__ == $0
  require 'rubygems'
  require 'robot_remote_server'
  require 'watir_robot'
  RobotRemoteServer.new(WatirRobot::KeywordLibrary.new,
                          host = 'localhost',
                          port = 8270,
                          yardoc_file = File.expand_path("#{File.dirname(__FILE__)}/../yardoc"),
                          yardoc_options = [[:docstring, ''], [:file, 'File'], [:source, 'Source Code']])
end

