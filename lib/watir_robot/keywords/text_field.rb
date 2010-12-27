module WatirRobot
  
  #
  # Functionality related to text fields (+<input>+ of type text and password)
  # 
  module TextField
    
    ### Actions ###
    
    #
    # Focus cursor inside a textfield
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    #
    def focus_textfield(loc)
      @browser.text_field(parse_location(loc)).focus
    end
    
    #
    # Input text into a text field
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String] text the text to type into the field
    # 
    def input_text(loc, text)
      @browser.text_field(parse_location(loc)).set text
    end
    
    #
    # Input a password into a password field.
    #
    # @note This value will not be logged.
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String] password the password to type into the field
    # 
    def input_password(loc, password)
      # This will differ from input_text when logging is implemented
      @browser.text_field(parse_location(loc)).set password
    end
    
    
    ### Conditions ###
    
    #
    # Verify that textfield's text contains the value
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String] text the text to type into the field
    # 
    def textfield_should_contain(loc, text)
      raise(Exception::ElementMatchError, "The textfield located at #{loc} does not contain the text #{text}") unless
        @browser.text_field(parse_location(loc)).value.include? text
    end
    
    #
    # Verify that textfield's text is the value
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String] text the text to compare against
    # 
    def textfield_text_should_be(loc, text)
      raise(Exception::ElementMatchError, "The textfield located at #{loc} does not have text equal to #{text}") unless
        @browser.text_field(parse_location(loc)).value == text
    end
    
  end
  
end