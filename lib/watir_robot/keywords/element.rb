module WatirRobot
  
  #
  # Functionality related to HTML elements in a generic, global context
  # 
  module Element
    
    ### Actions ###
    
    #
    # Get the value of an attribute for an element
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String] attr the attribute for which to return a value
    # @return [String] the value of the attribute for the given HTML element
    # 
    def get_element_attribute(loc, attr)
      @browser.element(parse_location(loc)).attribute_value(attr)
    end
    
    #
    # Get an element's text
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @return [String] the text of a given HTML *without* any HTML markup
    #
    def get_element_text(loc)
      @browser.element(parse_location(loc)).text
    end
    
    #
    # Click any HTML element
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def click_element(loc)
      @browser.element(parse_location(loc)).click
    end
    
    #
    # Set focus to element
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def focus(loc)
      @browser.element(parse_location(loc)).focus
    end
    
    ### Conditions ###

    #
    # Verify that an element is visible
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def element_should_be_visible(loc)
      raise(Exception::ElementVisibilityError, "The element described by #{parse_location(loc)} is not visible") unless
        @browser.element(parse_location(loc)).visible?
    end
    
    #
    # Verify that an element is not visible
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def element_should_not_be_visible(loc)
      raise(Exception::ElementVisibilityError, "The element described by #{parse_location(loc)} is not visible") if
        @browser.element(parse_location(loc)).visible?
    end
    
    #
    # Verify that an element's text contains a specific value
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String] text the text to compare against
    # 
    def element_text_should_contain(loc, text)
      raise(Exception::ElementMatchError, "The element's text #{@browser.element(parse_location(loc)).text} does not contain the text #{text}") unless
        @browser.element(parse_location(loc)).text.include? text
    end
    
    #
    # Verify that an element's text matches a specific value
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String] text the text to compare against
    # 
    def element_text_should_be(loc, text)
      raise(Exception::ElementMatchError, "The element's text #{@browser.element(parse_location(loc)).text} does not equal #{text}") unless
        @browser.element(parse_location(loc)).text == text      
    end
    
  end  
  
end

