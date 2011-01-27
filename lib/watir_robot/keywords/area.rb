module WatirRobot

  module Area

    ### Actions ###

    #
    # Click an area element (acts as a link)
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    #
    def click_area(loc)
      @browser.area(parse_location(loc)).click
    end
  end
end