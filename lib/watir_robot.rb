require 'watir-webdriver'

require 'watir_robot/parser'
require 'watir_robot/exception'

require 'watir_robot/keywords/browser'
require 'watir_robot/keywords/element'
require 'watir_robot/keywords/button'
require 'watir_robot/keywords/checkbox'
require 'watir_robot/keywords/file_field'
require 'watir_robot/keywords/form'
require 'watir_robot/keywords/image'
require 'watir_robot/keywords/link'
require 'watir_robot/keywords/list'
require 'watir_robot/keywords/native'
require 'watir_robot/keywords/page'
require 'watir_robot/keywords/radio'
require 'watir_robot/keywords/select'
require 'watir_robot/keywords/table'
require 'watir_robot/keywords/text_field'

#
# The overarching module which contains all keyword definitions and utilities
#
module WatirRobot

  #
  # The class which defines Robot Framework keywords.
  #
  # Feed an instance of this class to an instance of +RobotRemoteServer+
  # provided by the +robot_remote_server+ gem to make these keywords
  # available to your Robot Framework tests and to RIDE.
  #
  class KeywordLibrary
    include WatirRobot::Exception
    include WatirRobot::Parser
    
    include WatirRobot::Browser
    include WatirRobot::Button
    include WatirRobot::CheckBox
    include WatirRobot::Element
    include WatirRobot::FileField
    include WatirRobot::Form
    include WatirRobot::Image
    include WatirRobot::Link
    include WatirRobot::List
    include WatirRobot::Native
    include WatirRobot::Page
    include WatirRobot::Radio
    include WatirRobot::Select
    include WatirRobot::Table
    include WatirRobot::TextField
  end
  
end

