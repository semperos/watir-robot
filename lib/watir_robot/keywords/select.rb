module WatirRobot
  
  #
  # Functionality related to select list form elements
  # 
  module Select
    
    ### Actions ###
    
    #
    # Select a single item from a drop-down select list
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String] item the label, text or value of an item to select
    # @param [String] by_value boolean, whether or not to select an element by visible text or by value attribute (as string because arg comes from Robot Framework)
    # 
    def select_item_from_list(list_loc, item_loc)
      # Give user option to select by value rather than by text of option or label
      # Since the text is immediately visible, I assume people will default to that
      if item_loc[0..4].downcase == 'text='
        item_loc = item_loc[5..item_loc.length]
        @browser.select(parse_location(list_loc)).select(item_loc)
      elsif item_loc[0..5].downcase == 'value='
        item_loc = item_loc[6..item_loc.length]
        @browser.select(parse_location(list_loc)).select_value(item_loc)
      else
        raise(ArgumentError, "The only attributes allowed are 'text' and 'value'")
      end
    end
    
    #
    # Select all items from a drop-down select list
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def select_all_items_from_list(loc)
      select_list = @browser.select(parse_location(loc))
      select_list.options.each do |item|
        select_list.select_value(item.value) # Using value because it's more likely to be programmatically ensured unique
      end
    end
    
    #
    # Clear all select options from a drop-down select list
    #
    # @note The underlying Watir-WebDriver code will raise an error if the
    # select list is not a multiple select list
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def clear_items_from_list(loc)
      @browser.select(parse_location(loc)).clear
    end


    ### Conditions ###

    #
    # Ensure that an item is selected
    #
    # @param [String] list_loc attribute/value pairs that match a select list
    # @param [String] item_loc attribute/value pairs that match an item in a select list
    #
    def item_should_be_selected(list_loc, item_loc)
      raise(Exception::SelectListSelectionError, "The item described by #{item_loc} in the select list described by #{list_loc} is not selected") unless
        @browser.select(parse_location(list_loc)).option(parse_location(item_loc)).selected?
    end

    #
    # Ensure that an item is not selected
    #
    # @param [String] list_loc attribute/value pairs that match a select list
    # @param [String] item_loc attribute/value pairs that match an item in a select list
    #
    def item_should_not_be_selected(list_loc, item_loc)
      raise(Exception::SelectListSelectionError, "The item described by #{item_loc} in the select list described by #{list_loc} is selected") if
        @browser.select(parse_location(list_loc)).option(parse_location(item_loc)).selected?
    end

  end
  
end