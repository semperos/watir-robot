module WatirRobot
  
  #
  # Functionality scoped against the entire HTML page
  # 
  module Page
  
    ### Actions ###
  
    #
    # Log page source in a readable format
    # 
    def log_page_source
      print @browser.html
    end
    
    #
    # Get source of page
    #
    # @return [String] the HTML content of the entire page
    # 
    def get_page_source
      @browser.html
    end
  
    #
    # Get text of a page
    #
    # @return [String] teh text content of the entire page, without HTML markup
    # 
    def get_page_text
      @browser.text
    end
  
    #
    # Get status of page (located at bottom of browser window)
    #
    # @return [String] the status displayed at the bottom of the browser window
    # 
    def get_page_status
      @browser.status
    end
  
    #
    # Get page title
    #
    # @return [String] the title of the page as defined by the +<title>+ tag
    def get_title
      @browser.title
    end

    #
    # Get the text of all elements that match a given XPath query
    #
    # @param [String] xpath the xpath query to use for searching
    # @param [String] sep the separator that will be used in printing out the results
    # @return [String] a string of the text of all the matching elements, separated by sep
    #
    def get_all_elements_by_xpath(xpath, sep = ';;')
      matches = []
      @browser.elements_by_xpath(xpath).each do |element|
        matches << element.text
      end
      return matches.join(sep)
    end
    
    #
    # Execute arbitrary JavaScript
    # 
    def execute_javascript(code)
      @browser.execute_script(code)
    end
  
  
    ### Conditions ###
    
    #
    # Verify page text contains a certain value
    #
    # @param [String] text the text to compare against
    # 
    def page_should_contain(text)
      raise(Exception::PageMatchError, "The expected text #{text} was not contained in the page: #{@browser.text}") unless
        @browser.text.include? text
    end
    
    #
    # Verify page text does not contain a certain value
    #
    # @param [String] text the text to compare against
    # 
    def page_should_not_contain(text)
      raise(Exception::PageMatchError, "The expected text #{text} was contained in the page erroneously: #{@browser.text}") if
        @browser.text.include? text
    end

    #
    # Verify area tag exists on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    #
    def page_should_contain_area(loc)
      raise(Exception::ElementDoesNotExist, "The area described by #{loc} is not contained within the page:\n#{@browser.html}") unless
        @browser.area(parse_location(loc)).exists?
    end

    #
    # Verify area tag exists on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    #
    def page_should_not_contain_area(loc)
      raise(Exception::ElementExists, "The area described by #{loc} is erroneously contained within the page:\n#{@browser.html}") if
        @browser.area(parse_location(loc)).exists?
    end

    #
    # Verify button exists on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def page_should_contain_button(loc)
      raise(Exception::ElementDoesNotExist, "The button described by #{loc} is not contained within the page:\n#{@browser.html}") unless
        @browser.button(parse_location(loc)).exists?
    end
    
    #
    # Verify button does not exist on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def page_should_not_contain_button(loc)
      raise(Exception::ElementExists, "The button described by #{loc} is erroneously contained within the page:\n#{@browser.html}") if
        @browser.button(parse_location(loc)).exists?
    end
    
    #
    # Verify checkbox exists on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def page_should_contain_checkbox(loc)
      raise(Exception::ElementDoesNotExist, "The checkbox described by #{loc} is not contained within the page:\n#{@browser.html}") unless
        @browser.checkbox(parse_location(loc)).exists?
    end

    #
    # Verify checkbox does not exist on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def page_should_not_contain_checkbox(loc)
      raise(Exception::ElementExists, "The checkbox described by #{loc} is erroneously contained within the page:\n#{@browser.html}") if
        @browser.checkbox(parse_location(loc)).exists?
    end
    
    #
    # Verify element exists on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def page_should_contain_element(loc)
      raise(Exception::ElementDoesNotExist, "The element described by #{loc} is not contained within the page:\n#{@browser.html}") unless
        @browser.element(parse_location(loc)).exists?
    end

    #
    # Verify element exists on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def page_should_not_contain_element(loc)
      raise(Exception::ElementExists, "The element described by #{loc} is erroneously contained within the page:\n#{@browser.html}") if
        @browser.element(parse_location(loc)).exists?
    end
    
    #
    # Verify image exists on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def page_should_contain_image(loc)
      raise(Exception::ElementDoesNotExist, "The image described by #{loc} is not contained within the page:\n#{@browser.html}") unless
        @browser.image(parse_location(loc)).exists?
    end

    #
    # Verify image does not exist on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def page_should_not_contain_image(loc)
      raise(Exception::ElementExists, "The image described by #{loc} is erroneously contained within the page:\n#{@browser.html}") if
        @browser.image(parse_location(loc)).exists?
    end

    #
    # Verify link exists on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def page_should_contain_link(loc)
      raise(Exception::ElementDoesNotExist, "The link described by #{loc} is not contained within the page:\n#{@browser.html}") unless
        @browser.link(parse_location(loc)).exists?
    end

    #
    # Verify link does not exist on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def page_should_not_contain_link(loc)
      raise(Exception::ElementExists, "The link described by #{loc} is erroneously contained within the page:\n#{@browser.html}") if
        @browser.link(parse_location(loc)).exists?
    end
    
    #
    # Verify list exists on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String, nil] ordered nil means check both ul and ol, true is ol, false is ul; strings for the booleans because the arguments come from Robot Framework
    # 
    def page_should_contain_list(loc, ordered = nil)
      ordered = ordered.downcase unless ordered.nil?
      if ordered.nil?
        # Not specified; match either
        raise(Exception::ElementDoesNotExist, "The list described by #{loc} is not contained within the page:\n#{@browser.html}") unless
          (@browser.ol(parse_location(loc)).exists? || @browser.ul(parse_location(loc)).exists?)
      elsif ordered == 'true'
        raise(Exception::ElementDoesNotExist, "The ordered list described by #{loc} is not contained within the page:\n#{@browser.html}") unless
          @browser.ol(parse_location(loc)).exists?
      elsif ordered == 'false'
        raise(Exception::ElementDoesNotExist, "The unordered list described by #{loc} is not contained within the page:\n#{@browser.html}") unless
          @browser.ul(parse_location(loc)).exists?
      else
        raise(ArgumentError, "If you specify ordered vs. unordered lists, the only valid values are 'true' or 'false' (case-insensitive)")
      end
    end
    
    #
    # Verify list does not exist on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String, nil] ordered nil means check both ul and ol, true is ol, false is ul; strings for the booleans because the arguments come from Robot Framework
    # 
    def page_should_not_contain_list(loc, ordered = nil)
      ordered = ordered.downcase unless ordered == nil
      if ordered.nil?
        # Not specified; match either
        raise(Exception::ElementExists, "The list described by #{loc} is erroneously contained within the page:\n#{@browser.html}") if
          (@browser.ol(parse_location(loc)).exists? || @browser.ul(parse_location(loc)).exists?)
      elsif ordered == 'true'
        raise(Exception::ElementExists, "The ordered list described by #{loc} is erroneously contained within the page:\n#{@browser.html}") if
          @browser.ol(parse_location(loc)).exists?
      elsif ordered == 'false'
        raise(Exception::ElementExists, "The unordered list described by #{loc} is erroneously contained within the page:\n#{@browser.html}") if
          @browser.ul(parse_location(loc)).exists?
      else
        raise(ArgumentError, "If you specify ordered vs. unordered lists, the only valid values are 'true' or 'false' (case-insensitive)")
      end
    end

    #
    # Verify radio button exists on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def page_should_contain_radio_button(loc)
      raise(Exception::ElementDoesNotExist, "The radio button described by #{loc} is not contained within the page:\n#{@browser.html}") unless
        @browser.radio(parse_location(loc)).exists?
    end

    #
    # Verify radio button does not exist on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def page_should_not_contain_radio_button(loc)
      raise(Exception::ElementExists, "The radio button described by #{loc} is erroneously contained within the page:\n#{@browser.html}") if
        @browser.radio(parse_location(loc)).exists?
    end

    #
    # Verify select list does exist on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    #
    def page_should_contain_select_list(loc)
      raise(Exception::ElementDoesNotExist, "The select list described by #{loc} is not contained within the page:\n#{@browser.html}") unless
        @browser.select(parse_location(loc)).exists?
    end

    #
    # Verify select list does not exist on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    #
    def page_should_not_contain_select_list(loc)
      raise(Exception::ElementExists, "The select list described by #{loc} is not contained within the page erroneously:\n#{@browser.html}") if
        @browser.select(parse_location(loc)).exists?
    end

    #
    # Verify link exists on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def page_should_contain_textfield(loc)
      raise(Exception::ElementDoesNotExist, "The text field described by #{loc} is not contained within the page:\n#{@browser.html}") unless
        @browser.text_field(parse_location(loc)).exists?
    end

    #
    # Verify link does not exist on page
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # 
    def page_should_not_contain_textfield(loc)
      raise(Exception::ElementExists, "The text field described by #{loc} is not contained within the page erroneously:\n#{@browser.html}") if
        @browser.text_field(parse_location(loc)).exists?
    end

    #
    # Verify page title, i.e. the <title> in <head>
    #
    # @param [String] title the title text to compare against
    # 
    def title_should_be(title)
      raise(Exception::TitleMatchError, "The page title #{@browser.title} is not correct; it should be #{title}") unless @browser.title == title
    end
    
    #
    # Verify that the page title contains a certain value
    #
    # @param [String] text the text to compare against
    # 
    def title_should_contain(text)
      raise(Exception::TitleMatchError, "The page title #{@browser.url} is not correct; it should contain #{text}") unless @browser.title.include?(text)
    end
    
  end  
  
end

