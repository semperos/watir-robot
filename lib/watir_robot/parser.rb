module WatirRobot
  
  #
  # This module contains the functions necessary to convert arguments obtained
  # from Robot Framework tests and make them meaningful to the underlying
  # Watir-WebDriver code. These are NOT Robot Framework keywords.
  # 
  module Parser
    
    #
    # Mapping of Unicode values to java.awt.event.KeyEvent constants
    #
    KEY_CONSTANTS = {
      32 => ['VK_SPACE'],
      33 => ['VK_EXCLAMATION_MARK'],
      34 => ['VK_SHIFT', 'VK_QUOTE'],
      35 => ['VK_SHIFT', 'VK_3'],
      36 => ['VK_SHIFT', 'VK_4'],
      38 => ['VK_AMPERSAND'],
      39 => ['VK_QUOTE'],
      40 => ['VK_SHIFT', 'VK_9'],
      41 => ['VK_SHIFT', 'VK_0'],
      42 => ['VK_ASTERISK'],
      43 => ['VK_ADD'],
      45 => ['VK_SUBTRACT'],
      46 => ['VK_DECIMAL'],
      47 => ['VK_SLASH'],
      48 => ['VK_0'],
      49 => ['VK_1'],
      50 => ['VK_2'],
      51 => ['VK_3'],
      52 => ['VK_4'],
      53 => ['VK_5'],
      54 => ['VK_6'],
      55 => ['VK_7'],
      56 => ['VK_8'],
      57 => ['VK_9'],
      58 => ['VK_SHIFT', 'VK_SEMICOLON'],
      59 => ['VK_SEMICOLON'],
      60 => ['VK_SHIFT', 'VK_COMMA'],
      61 => ['VK_EQUALS'],
      62 => ['VK_SHIFT', 'VK_DECIMAL'],
      64 => ['VK_AT'],
      65 => ['VK_SHIFT', 'VK_A'],
      66 => ['VK_SHIFT', 'VK_B'],
      67 => ['VK_SHIFT', 'VK_C'],
      68 => ['VK_SHIFT', 'VK_D'],
      69 => ['VK_SHIFT', 'VK_E'],
      70 => ['VK_SHIFT', 'VK_F'],
      71 => ['VK_SHIFT', 'VK_G'],
      72 => ['VK_SHIFT', 'VK_H'],
      73 => ['VK_SHIFT', 'VK_I'],
      74 => ['VK_SHIFT', 'VK_J'],
      75 => ['VK_SHIFT', 'VK_K'],
      76 => ['VK_SHIFT', 'VK_L'],
      77 => ['VK_SHIFT', 'VK_M'],
      78 => ['VK_SHIFT', 'VK_N'],
      79 => ['VK_SHIFT', 'VK_O'],
      80 => ['VK_SHIFT', 'VK_P'],
      81 => ['VK_SHIFT', 'VK_Q'],
      82 => ['VK_SHIFT', 'VK_R'],
      83 => ['VK_SHIFT', 'VK_S'],
      84 => ['VK_SHIFT', 'VK_T'],
      85 => ['VK_SHIFT', 'VK_U'],
      86 => ['VK_SHIFT', 'VK_V'],
      87 => ['VK_SHIFT', 'VK_W'],
      88 => ['VK_SHIFT', 'VK_X'],
      89 => ['VK_SHIFT', 'VK_Y'],
      90 => ['VK_SHIFT', 'VK_Z'],
      91 => ['VK_OPEN_BRACKET'],
      92 => ['VK_BACK_SLASH'],
      93 => ['VK_CLOSE_BRACKET'],
      94 => ['VK_SHIFT', 'VK_6'],
      95 => ['VK_SHIFT', 'VK_SUBTRACT'],
      96 => ['VK_BACK_QUOTE'],
      97 => ['VK_A'],
      98 => ['VK_B'],
      99 => ['VK_C'],
      100 => ['VK_D'],
      101 => ['VK_E'],
      102 => ['VK_F'],
      103 => ['VK_G'],
      104 => ['VK_H'],
      105 => ['VK_I'],
      106 => ['VK_J'],
      107 => ['VK_K'],
      108 => ['VK_L'],
      109 => ['VK_M'],
      110 => ['VK_N'],
      111 => ['VK_O'],
      112 => ['VK_P'],
      113 => ['VK_Q'],
      114 => ['VK_R'],
      115 => ['VK_S'],
      116 => ['VK_T'],
      117 => ['VK_U'],
      118 => ['VK_V'],
      119 => ['VK_W'],
      120 => ['VK_X'],
      121 => ['VK_Y'],
      122 => ['VK_Z'],
      123 => ['VK_SHIFT', 'VK_OPEN_BRACKET'],
      125 => ['VK_SHIFT', 'VK_CLOSE_BRACKET'],
    }
  
    #
    # (Non-Keyword) Parses the "location" string provided as argument for locating HTML elements.
    #
    # Watir-WebDriver expects a hash of parameters by which to search for HTML
    # elements. This function take arguments from Robot Framework tests in the
    # form of <tt>attribute=value</tt> and constructs a hash which
    # Watir-WebDriver can use to uniquely identify HTML elements on the page.
    #
    # @param [String] loc argument from Robot Framework to locate an HTML element
    # @return [Hash] a hash which Watir-WebDriver can use to locate an HTML element
    #
    def parse_location(loc)
      loc = self.trim_sides(loc)
      
      if loc[0..3].downcase == 'css='
        return {:css => loc[4..loc.length]}
      elsif loc[0..5].downcase == 'xpath='
        return {:xpath => loc[6..loc.length]}
      elsif !loc.include? '='
        return {:id => loc}
      else
        # Comma-separated attributes
        attr_list = loc.split(',')
        attrs = {}
        attr_list.each do |a|
          attr_kv = a.split('=')
          # Need to turn strings in format "/regex-here/" into actual regexes
          if attr_kv[1].start_with?('/')
            attr_kv[1] = Regexp.new(Regexp.quote(attr_kv[1].gsub('/', '')))
          end
          attr_kv[1] = self.trim_sides(attr_kv[1]) unless attr_kv[1].is_a? Regexp
          attrs[self.trim_sides(attr_kv[0])] = attr_kv[1]
        end
        # Watir expects symbols for keys
        attrs = Hash[attrs.map { |k, v| [k.to_sym, v] }]
        if attrs.key? :id
          attrs.delete_if {|k, v| k != :id}
        end
        return attrs
      end
    end
    
    #
    # (Non-keyword) Parses a key-code argument, provided as an actual character or in ASCII code
    #
    # @param [String] key the key for which to find the java.awt.KeyEvent key-code constant
    # @return [String] the constant for the key event
    #
    def parse_key_code(key)
      if key[0..5].downcase = 'ascii='
        # return the ASCII code directly
        return key[6..key.length]
      else
        # we assume it's a character and try to map it to a constant
      end
    end
    
    #
    # (Non-keyword) Small utility for trimming whitespace from both sides of a string
    #
    # @param [String] s string to trim both sides of
    # @return [Strgin] the same string without whitespace on the left or right sides
    #
    def trim_sides(s)
      s = s.lstrip
      s = s.rstrip
      return s
    end
    
  end

end
