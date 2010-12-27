module WatirRobot
  
  #
  # Functionality related to links in an HTML document
  # 
  module Link
    
    ### Actions ###
    
    #
    # Click a link
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def click_link(loc)
      @browser.link(parse_location(loc)).click
    end

  end
  
end