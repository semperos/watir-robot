module WatirRobot
  
  #
  # Custom exceptions for Watir Robot test cases
  # 
  module Exception
  
    #
    # Exception when an object cannot be found on the given page
    # 
    class ObjectDoesNotExist < RuntimeError; end
      #
      # Exception when an HTML element cannot be found on the given page
      #
      class ElementDoesNotExist < ObjectDoesNotExist; end

    #
    # Exception when an object is found on a given page erroneously
    #
    class ObjectExists < RuntimeError; end
      #
      # Exception when an HTML element is found on a page erroneously
      #
      class ElementExists < ObjectExists; end

    #
    # Exception when an object does not match expected parameters
    # 
    class ObjectMatchError < RuntimeError; end
      #
      # Exception when an element does not match expected parameters
      #
      class ElementMatchError < ObjectMatchError; end
      
      #
      # Exception when the page does not match expected parameters
      #
      class PageMatchError < ObjectMatchError; end
      
      #
      # Exception when the page title does not match expected string value
      #
      class TitleMatchError < ObjectMatchError; end
      
      #
      # Exception when the URL does not match the expected string value
      #
      class UrlMatchError < ObjectMatchError; end

      #
      # Exception when trying to match a Window is unsuccessful
      #
      class WindowMatchError < ObjectMatchError; end
    
    #
    # Exception when an object is visible or invisible and should be the opposite
    # 
    class ObjectVisibilityError < RuntimeError; end
      #
      # Exception when an HTML element is visible or invisible and should be the opposite
      #
      class ElementVisibilityError < ObjectVisibilityError; end
    
    #
    # Exception when object is "selected" or "unselected" when it should be the opposite
    # 
    class ObjectSelectionError < RuntimeError; end
      #
      # Exception when a checkbox is selected or unselected when it should be the opposite
      #
      class CheckboxSelectionError < RuntimeError; end
      
      #
      # Exception when a radio button is selected or unselected when it should be the opposite
      #
      class RadioSelectionError < RuntimeError; end
      
      #
      # Exception when a select list has items selected or unselected which should be the opposite
      #
      class SelectListSelectionError < RuntimeError; end
  
  end
  
end
