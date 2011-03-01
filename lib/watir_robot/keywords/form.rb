module WatirRobot
  
  #
  # Functionality related to HTML forms as a whole
  #
  module Form

    #
    # Verify that a form contains a specific button
    #
    # @param [String] form_loc attribute/value pairs that match an HTML element
    # @param [String] field_loc attribute/value pairs that match an HTML element
    #
    def form_should_contain_button(form_loc, field_loc)
      raise(Exception::ElementMatchError, "The button described by #{field_loc} was not located in the form described by #{form_loc}.") unless
        @browser.form(parse_location(form_loc)).button(parse_location(field_loc)).exists?
    end

    #
    # Verify that a form does not contain a specific button
    #
    # @param [String] form_loc attribute/value pairs that match an HTML element
    # @param [String] field_loc attribute/value pairs that match an HTML element
    #
    def form_should_not_contain_button(form_loc, field_loc)
      raise(Exception::ElementMatchError, "The button described by #{field_loc} was erroneously located in the form described by #{form_loc}.") if
        @browser.form(parse_location(form_loc)).button(parse_location(field_loc)).exists?
    end

    #
    # Verify that a form contains a specific checkbox
    #
    # @param [String] form_loc attribute/value pairs that match an HTML element
    # @param [String] field_loc attribute/value pairs that match an HTML element
    #
    def form_should_contain_checkbox(form_loc, field_loc)
      raise(Exception::ElementMatchError, "The checkbox described by #{field_loc} was not located in the form described by #{form_loc}.") unless
        @browser.form(parse_location(form_loc)).checkbox(parse_location(field_loc)).exists?
    end

    #
    # Verify that a form does not contain a specific checkbox
    #
    # @param [String] form_loc attribute/value pairs that match an HTML element
    # @param [String] field_loc attribute/value pairs that match an HTML element
    #
    def form_should_not_contain_checkbox(form_loc, field_loc)
      raise(Exception::ElementMatchError, "The checkbox described by #{field_loc} was erroneously located in the form described by #{form_loc}.") if
        @browser.form(parse_location(form_loc)).checkbox(parse_location(field_loc)).exists?
    end

    #
    # Verify that a form contains a specific element
    #
    # @param [String] form_loc attribute/value pairs that match an HTML element
    # @param [String] field_loc attribute/value pairs that match an HTML element
    #
    def form_should_contain_element(form_loc, field_loc)
      raise(Exception::ElementMatchError, "The element described by #{field_loc} was not located in the form described by #{form_loc}.") unless
        @browser.form(parse_location(form_loc)).checkbox(parse_location(field_loc)).exists?
    end

    #
    # Verify that a form does not contain a specific element
    #
    # @param [String] form_loc attribute/value pairs that match an HTML element
    # @param [String] field_loc attribute/value pairs that match an HTML element
    #
    def form_should_not_contain_element(form_loc, field_loc)
      raise(Exception::ElementMatchError, "The element described by #{field_loc} was erroneously located in the form described by #{form_loc}.") if
        @browser.form(parse_location(form_loc)).checkbox(parse_location(field_loc)).exists?
    end

    #
    # Verify that a form contains a specific file-field
    #
    # @param [String] form_loc attribute/value pairs that match an HTML element
    # @param [String] field_loc attribute/value pairs that match an HTML element
    #
    def form_should_contain_filefield(form_loc, field_loc)
      raise(Exception::ElementMatchError, "The file-field described by #{field_loc} was not located in the form described by #{form_loc}.") unless
        @browser.form(parse_location(form_loc)).file_field(parse_location(field_loc)).exists?
    end

    #
    # Verify that a form does not contain a specific file-field
    #
    # @param [String] form_loc attribute/value pairs that match an HTML element
    # @param [String] field_loc attribute/value pairs that match an HTML element
    #
    def form_should_not_contain_filefield(form_loc, field_loc)
      raise(Exception::ElementMatchError, "The file-field described by #{field_loc} was erroneously located in the form described by #{form_loc}.") if
        @browser.form(parse_location(form_loc)).file_field(parse_location(field_loc)).exists?
    end

    #
    # Verify that a form contains a specific radio button
    #
    # @param [String] form_loc attribute/value pairs that match an HTML element
    # @param [String] field_loc attribute/value pairs that match an HTML element
    #
    def form_should_contain_radio_button(form_loc, field_loc)
      raise(Exception::ElementMatchError, "The radio button described by #{field_loc} was not located in the form described by #{form_loc}.") unless
        @browser.form(parse_location(form_loc)).radio(parse_location(field_loc)).exists?
    end

    #
    # Verify that a form does not contain a specific radio button
    #
    # @param [String] form_loc attribute/value pairs that match an HTML element
    # @param [String] field_loc attribute/value pairs that match an HTML element
    #
    def form_should_not_contain_radio_button(form_loc, field_loc)
      raise(Exception::ElementMatchError, "The radio button described by #{field_loc} was erroneously located in the form described by #{form_loc}.") if
        @browser.form(parse_location(form_loc)).radio(parse_location(field_loc)).exists?
    end

    #
    # Verify that a form contains a specific select list
    #
    # @param [String] form_loc attribute/value pairs that match an HTML element
    # @param [String] field_loc attribute/value pairs that match an HTML element
    #
    def form_should_contain_select_list(form_loc, field_loc)
      raise(Exception::ElementMatchError, "The select list described by #{field_loc} was not located in the form described by #{form_loc}.") unless
        @browser.form(parse_location(form_loc)).select(parse_location(field_loc)).exists?
    end

    #
    # Verify that a form does not contain a specific select list
    #
    # @param [String] form_loc attribute/value pairs that match an HTML element
    # @param [String] field_loc attribute/value pairs that match an HTML element
    #
    def form_should_not_contain_select_list(form_loc, field_loc)
      raise(Exception::ElementMatchError, "The select list described by #{field_loc} was erroneously located in the form described by #{form_loc}.") if
        @browser.form(parse_location(form_loc)).select(parse_location(field_loc)).exists?
    end

    #
    # Verify that a form contains a specific text field
    #
    # @param [String] form_loc attribute/value pairs that match an HTML element
    # @param [String] field_loc attribute/value pairs that match an HTML element
    #
    def form_should_contain_textfield(form_loc, field_loc)
      raise(Exception::ElementMatchError, "The textfield described by #{field_loc} was not located in the form described by #{form_loc}.") unless
        @browser.form(parse_location(form_loc)).text_field(parse_location(field_loc)).exists?
    end

    #
    # Verify that a form does not contain a specific text field
    #
    # @param [String] form_loc attribute/value pairs that match an HTML element
    # @param [String] field_loc attribute/value pairs that match an HTML element
    #
    def form_should_not_contain_textfield(form_loc, field_loc)
      raise(Exception::ElementMatchError, "The textfield described by #{field_loc} was erroneously located in the form described by #{form_loc}.") if
        @browser.form(parse_location(form_loc)).text_field(parse_location(field_loc)).exists?
    end
    
  end
  
end
