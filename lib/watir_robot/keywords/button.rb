module WatirRobot
  
  #
  # Functionality related to HTML buttons (whether +<input>+ type submit or actual +<button>+ tags)
  # 
  module Button
    
    ### Actions ###
    
    #
    # Click a button
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    #
    def click_button(loc)
      @browser.button(parse_location(loc)).click
    end
    
  end
  
end
