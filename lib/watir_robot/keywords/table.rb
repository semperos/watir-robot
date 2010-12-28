module WatirRobot
  
  #
  # Functionality related to HTMl tables, including headers, bodies, footers, and cells
  # 
  module Table
    
    ### Actions ###
    
    #
    # Get contents of a single table cell
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String] row with the top-most row as 1, the number of the row in question
    # @param [String] col with the left-most row as 1, the number of the column in question
    # @return [String] the text contained within the targeted table cell
    # 
    def get_table_cell(loc, row, col)
      row = row.to_i - 1
      col = col.to_i - 1
      @browser.table(parse_location(loc))[row][col].text
    end
    
    
    ### Conditions ###
    
    #
    # Verify that table cell contains certain contents
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String] row with the top-most row as 1, the number of the row in question
    # @param [String] col with the left-most row as 1, the number of the column in question
    # @param [String] text the text to compare against
    # 
    def table_cell_should_contain(loc, row, col, text)
      row = row.to_i - 1
      col = col.to_i - 1
      raise(ElementMatchError, "The table cell at row #{row} and column #{col}, located in the table at #{loc}, does not contain the text #{text}") unless
        @browser.table(parse_location(loc))[row][col].text.include? text
    end
    
    #
    # Verify that a table column contains certain contents
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String] col with the left-most row as 1, the number of the column in question
    # @param [String] text the text to compare against
    # 
    def table_column_should_contain(loc, col, text)
      # There's no "nice" way to do this, so we run through each row and snag
      #   the cell at offset y
      col = col.to_i - 1
      content = ''
      @browser.table(parse_location(loc)).rows.each do |row|
        content << ' '
        content << row[col].text
      end
      
      raise(Exception::ElementMatchError, "The table column number #{c} in the table located at #{loc} does not contain the text #{text}") unless
        content.include? text
    end
    
    #
    # Verify that a table's header contains certain contents
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String] text the text to compare against
    # 
    def table_header_should_contain(loc, text)
      raise(Exception::ElementMatchError, "The table header of the table located at #{loc} does not contain the text #{text}") unless
        @browser.table(parse_location(loc)).thead.text.include? text
    end
    
    #
    # Verify that a table row conatins certain contents
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String] row with the top-most row as 1, the number of the row in question
    # @param [String] text the text to compare against
    # 
    def table_row_should_contain(loc, row, text)
      row = row.to_i - 1
      raise(Exception::ElementMatchError, "The table row number #{row} in the table located at #{loc} does not contain the text #{text}") unless
        @browser.table(parse_location(loc))[row].text.include? text
    end
    
    #
    # Verify that certain content is contained somewhere within an entire HTML table
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    # @param [String] text the text to compare against
    # 
    def table_should_contain(loc, text)
      raise(Exception::ElementMatchError, "The table located at #{loc} does not contain the text #{text}") unless
        @browser.table(parse_location(loc)).text.include? text
    end
    
  end
  
end