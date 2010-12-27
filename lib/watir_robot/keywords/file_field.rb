module WatirRobot
  
  #
  # Functionality for HTML file-upload fields
  #
  module FileField
    
    ### Actions ###
    
    #
    # Insert path of a file into a file-upload field
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String] path the path to the file you wish to upload from your computer
    #
    def choose_file(loc, path)
      @browser.file_field(parse_location(loc)).set path
    end
    
    #
    # Get the file path present in a file-upload field
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String] the path of the file in a file-upload field
    # 
    def get_filefield_path(loc)
      @browser.file_field(parse_location(loc)).value
    end
  end
end
