module WatirRobot
  
  #
  # Functionality related to radio button form elements
  # 
  module Radio
    
    ### Actions ###
    
    #
    # Select a radio button
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    #
    def select_radio_button(loc)
      @browser.radio(parse_location(loc)).set
    end
    
    
    ### Conditions ###
    
    #
    # Verify that radio button is selected
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def radio_button_should_be_selected(loc)
      raise(Exception::RadioSelectionError, "The radio button located at #{loc} is not selected.") unless
        @browser.radio(parse_location(loc)).set?
    end
    
    #
    # Verify that radio button is not selected
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def radio_button_should_not_be_selected(loc)
      raise(Exception::RadioSelectionError, "The radio button located at #{loc} is selected.") if
        @browser.radio(parse_location(loc)).set?
    end
    
  end
  
end