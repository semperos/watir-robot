module WatirRobot
  
  #
  # Functionality related to checkbox form elements
  # 
  module CheckBox
    
    ### Actions ###
    
    #
    # Check a checkbox
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    #
    def select_checkbox(loc)
      @browser.checkbox(parse_location(loc)).set
    end
    
    #
    # Uncheck a checkbox
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    #
    def unselect_checkbox(loc)
      @browser.checkbox(parse_location(loc)).set(false)
    end
    
    
    ### Conditions ###
    
    #
    # Verify that checkbox is checked
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def checkbox_should_be_selected(loc)
      raise(Exception::CheckboxSelectionError, "The checkbox located at #{loc} is not checked off.") unless
        @browser.checkbox(parse_location(loc)).set?
    end

    #
    # Verify that checkbox is not checked
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def checkbox_should_not_be_selected(loc)
      raise(Exception::CheckboxSelectionError, "The checkbox located at #{loc} is checked off erroneously.") if
        @browser.checkbox(parse_location(loc)).set?
    end
    
  end
  
end