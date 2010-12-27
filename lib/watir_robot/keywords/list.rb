module WatirRobot
  
  #
  # Functionality related to ordered and unordered HTML lists
  # 
  module List
    
    ### Actions ###
    
    #
    # Get text from the items of a list
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String, nil] ordered nil means check both ul and ol, true is ol, false is ul; strings for the booleans because the arguments come from Robot Framework
    # @param [String] sep the separator that should be used to separate the list items
    # 
    def get_list_items(loc, ordered = nil, sep = ";;")
      ordered = ordered.downcase unless ordered == nil
      if ordered.nil?
        # TODO: Warn user about this ambiguity
        list = @browser.ol(parse_location(loc)) or @browser.ul(parse_location(loc))
      elsif ordered == 'true'
        list = @browser.ol(parse_location(loc))
      elsif ordered == 'false'
        list = @browser.ul(parse_location(loc))
      else
        raise(ArgumentError, "If you specify ordered vs. unordered lists, the only valid values are 'true' or 'false' (case-insensitive)")
      end
      
      items = []
      list.lis.each do |item|
        items << item.text
      end
      
      items.join(sep)
    end
    
  end
  
end
