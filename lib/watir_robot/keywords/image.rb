module WatirRobot
  
  #
  # Functionality related to images in an HTML document
  module Image
    
    #
    # Click an image
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def click_image(loc)
      @browser.image(parse_location(loc)).click
    end
    
  end
  
end