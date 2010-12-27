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
    def select_item_from_list(loc, item, by_value = 'false')
      # Give user option to select by value rather than by text of option or label
      # Since the text is immediately visible, I assume people will default to that
      by_value = by_value.downcase
      if value == 'false'
        @browser.select(parse_locatoin(loc)).select(item)
      elsif by_value == 'true'
        @browser.select(parse_location(loc)).select_value(item)
      else
        raise(ArgumentError,
              "If you specify that you want to select the list item by its value attribute, the only valid values are 'true' or 'false' (case-insensitive)")
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
    def clear_items_from_select_list(loc)
      @browser.select(parse_location(loc)).clear
    end
    
  end
  
end